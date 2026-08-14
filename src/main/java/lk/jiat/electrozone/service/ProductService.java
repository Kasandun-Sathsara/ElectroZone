package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import jakarta.persistence.criteria.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.core.Context;
import lk.jiat.ElectroZone.dto.ProductDTO;
import lk.jiat.ElectroZone.dto.SearchResponseDTO;
import lk.jiat.ElectroZone.dto.StockDTO;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;
import org.hibernate.query.criteria.JpaCriteriaQuery;
import org.hibernate.query.criteria.JpaRoot;

import java.time.format.DateTimeFormatter;
import java.util.*;

public class ProductService {
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy MMMM dd");

    public String getBasicSearchData(String title) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if (!title.isBlank()) {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();

            Status approvedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                    .setParameter("value", String.valueOf(Status.Type.APPROVED)).getSingleResult();

            List<Stock> stockList = hibernateSession.createQuery("FROM Stock s WHERE s.product.title LIKE :title AND s.status=:status", Stock.class)
                    .setParameter("title", "%" + title + "%")
                    .setParameter("status", approvedStatus)
                    .getResultList();
            if (stockList.isEmpty()) {
                message = "Product not found!";
            } else {
                List<SearchResponseDTO> searchResponseDTOS = new ArrayList<>();
                for (Stock stock : stockList) {
                    SearchResponseDTO dto = new SearchResponseDTO();
                    dto.setStockId(stock.getId());
                    dto.setTitle(stock.getProduct().getTitle());
                    dto.setPrice(stock.getPrice());
                    List<lk.jiat.ElectroZone.entity.ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", lk.jiat.ElectroZone.entity.ProductImage.class)
                            .setParameter("product", stock.getProduct())
                            .setMaxResults(1)
                            .getResultList();
                    if (!pImages.isEmpty()) {
                        dto.setImage(pImages.get(0).getImageUrl());
                    } else {
                        dto.setImage("assets/img/default-product.png");
                    }
                    searchResponseDTOS.add(dto);
                }
                responseObject.add("basicSearchData", AppUtil.GSON.toJsonTree(searchResponseDTOS));
                status = true;
            }
            hibernateSession.close();
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String getAllUserProducts(@Context HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("user") == null) {
            message = "Session Expired. Please logged in!";
        } else {
            User sessionUser = (User) httpSession.getAttribute("user");
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Seller seller = hibernateSession.createQuery("FROM Seller s WHERE s.user=:user", Seller.class)
                    .setParameter("user", sessionUser)
                    .getSingleResultOrNull();
            if (seller == null) {
                message = "The requested profile is not a seller account. Please register first as a seller";
            } else {
                if (!seller.getStatus().getValue().equals(String.valueOf(Status.Type.APPROVED))) {
                    message = "Not approved account. Please be patient till admin approval!";
                } else {
                    Set<Product> productSet = seller.getProducts();
                    if (productSet.isEmpty()) {
                        message = "Products Not Found";
                    } else {
                        List<ProductDTO> productDTOList = new ArrayList<>();
                        for (Product p : productSet) {
                            ProductDTO dto = new ProductDTO();
                            dto.setProductId(p.getId());
                            dto.setTitle(p.getTitle());

                            List<Stock> stocks = hibernateSession.createQuery("FROM Stock s WHERE s.product=:product ORDER BY s.id DESC", Stock.class)
                                    .setParameter("product", p)
                                    .getResultList();

                            List<StockDTO> stockDTOList = new ArrayList<>();
                            for (Stock s : stocks) {
                                StockDTO stockDTO = new StockDTO();
                                stockDTO.setStockId(s.getId());
                                stockDTO.setProductId(s.getProduct().getId());
                                stockDTO.setQty(s.getQty());
                                stockDTO.setPrice(s.getPrice());
                                stockDTO.setCreatedAt(formatter.format(s.getCreatedAt()));
                                stockDTOList.add(stockDTO);
                            }
                            dto.setStockDTOList(stockDTOList);
                            productDTOList.add(dto);
                            stockDTOList.sort(Comparator.comparing(StockDTO::getStockId).reversed());
                            productDTOList.sort(Comparator.comparing(ProductDTO::getProductId).reversed());
                        }
                        responseObject.add("products", AppUtil.GSON.toJsonTree(productDTOList));
                        status = true;
                        message = "Product loading successful";
                    }
                }
            }
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);

        return AppUtil.GSON.toJson(responseObject);
    }

    public String updateProduct(Product product) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = hibernateSession.beginTransaction();
        try {
            hibernateSession.merge(product);
            transaction.commit();
            status = true;
            message = "Product images uploading successful";
        } catch (HibernateException e) {
            transaction.rollback();
            message = "Product image uploading failed!";
        }
        hibernateSession.close();
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public Product getProductById(int id) {
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        Product product = hibernateSession.find(Product.class, id);
        hibernateSession.close();
        return product;
    }

    public String addNewProduct(ProductDTO productDTO, @Context HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        /// product-inserting-part-start
        if (productDTO.getBrandId() <= 0) {
            message = "Invalid brand type. Please select a correct brand!";
        } else if (productDTO.getModelId() <= 0) {
            message = "Invalid model type. Please select a correct model!";
        } else if (productDTO.getTitle() == null) {
            message = "Product title is required!";
        } else if (productDTO.getTitle().isBlank()) {
            message = "Product title can not be empty!";
        } else if (productDTO.getDescription() == null) {
            message = "Product description is required!";
        } else if (productDTO.getDescription().isBlank()) {
            message = "Product description can not be empty!";
        } else if (productDTO.getStorageId() <= 0) {
            message = "Invalid storage type. Please select a correct storage!";
        } else if (productDTO.getColorId() <= 0) {
            message = "Invalid color type. Please select a correct color!";
        } else if (productDTO.getQualityId() <= 0) {
            message = "Invalid condition type. Please select a correct condition!";
        } else if (productDTO.getPrice() <= 0) {
            message = "Product price can not be less than or equal to 0";
        } else if (productDTO.getQty() <= 0) {
            message = "Product quantity can not be less than or equal to 0";
        } else {
            HttpSession httpSession = request.getSession(false);
            if (httpSession == null) {
                message = "Session expired! Please logged in";
            } else if (httpSession.getAttribute("user") == null) {
                message = "Please logged in";
            } else {
                User sessionUser = (User) httpSession.getAttribute("user");
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                Seller seller = hibernateSession.createQuery("FROM Seller s WHERE s.user=:user", Seller.class)
                        .setParameter("user", sessionUser)
                        .getSingleResultOrNull();
                if (seller == null) {
                    message = "The requested profile is not a seller account. Please register first as a seller";
                } else {
                    if (!seller.getStatus().getValue().equals(String.valueOf(Status.Type.APPROVED))) {
                        message = "Not approved account. Please be patient till admin approval!";
                    } else {
                        Model model = hibernateSession.find(Model.class, productDTO.getModelId());
                        if (model == null) {
                            message = "Model not found. Please contact administration";
                        } else {
                            Storage storage = hibernateSession.find(Storage.class, productDTO.getStorageId());
                            if (storage == null) {
                                message = "Storage not found. Please contact administration";
                            } else {
                                Color color = hibernateSession.find(Color.class, productDTO.getColorId());
                                if (color == null) {
                                    message = "Color not found. Please contact administration";
                                } else {
                                    Quality quality = hibernateSession.find(Quality.class, productDTO.getQualityId());
                                    if (quality == null) {
                                        message = "Quality not found. Please contact administration";
                                    } else {
                                        Product product = new Product();
                                        product.setTitle(productDTO.getTitle());
                                        product.setDescription(productDTO.getDescription());
                                        product.setModel(model);
                                        product.setStorage(storage);
                                        product.setQuality(quality);
                                        product.setColor(color);
                                        product.setSeller(seller);

                                        Stock stock = new Stock();
                                        stock.setProduct(product);
                                        stock.setPrice(productDTO.getPrice());
                                        stock.setQty(productDTO.getQty());

                                        Discount defaultDiscount = hibernateSession.createNamedQuery("Discount.findDefault", Discount.class)
                                                .getSingleResult();
                                        Status pendingStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                                                .setParameter("value", String.valueOf(Status.Type.PENDING))
                                                .getSingleResult();
                                        stock.setDiscount(defaultDiscount);
                                        stock.setStatus(pendingStatus);

                                        Transaction transaction = hibernateSession.beginTransaction();
                                        try {
                                            hibernateSession.persist(product);
                                            hibernateSession.persist(stock);
                                            transaction.commit();
                                            status = true;
                                            responseObject.addProperty("productId", product.getId());
                                        } catch (HibernateException e) {
                                            transaction.rollback();
                                        }

                                    }
                                }
                            }
                        }
                    }
                }
                hibernateSession.close();
            }
        }
        /// product-inserting-part-end

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
