package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.dto.ProductDTO;
import lk.jiat.ElectroZone.entity.Model;
import lk.jiat.ElectroZone.entity.Product;
import lk.jiat.ElectroZone.entity.Stock;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.Session;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class SingleProductService {
    public String getSimilarProducts(String sId) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        if (sId == null || sId.isBlank()) {
            message = "Product ID not found!";
        } else if (!sId.matches(Validator.IS_INTEGER)) {
            message = "Invalid product number!";
        } else {
            int stockId = Integer.parseInt(sId);
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Stock stock = hibernateSession.find(Stock.class, stockId);
            if (stock == null) {
                message = "Product not found!";
            } else {
                List<Model> modelList = hibernateSession.createQuery("FROM Model m WHERE m.brand=:brand", Model.class)
                        .setParameter("brand", stock.getProduct().getModel().getBrand())
                        .getResultList();
                // sub query
                List<Stock> stockList = hibernateSession.createQuery("FROM Stock s WHERE s.product.model IN :modelList AND s != :stock", Stock.class)
                        .setParameter("modelList", modelList)
                        .setParameter("stock", stock)
                        .getResultList();
                List<ProductDTO> productDTOList = new ArrayList<>();
                for (Stock s : stockList) {
                    ProductDTO productDTO = new ProductDTO();
                    productDTO.setStockId(s.getId());
                    productDTO.setTitle(s.getProduct().getTitle());

                    List<String> imagePaths = new ArrayList<>();
                    List<lk.jiat.ElectroZone.entity.ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", lk.jiat.ElectroZone.entity.ProductImage.class)
                            .setParameter("product", s.getProduct())
                            .setMaxResults(1)
                            .getResultList();
                    if (!pImages.isEmpty()) {
                        imagePaths.add(pImages.get(0).getImageUrl());
                    } else {
                        imagePaths.add("assets/img/default-product.png");
                    }
                    productDTO.setImages(imagePaths);

                    productDTO.setPrice(s.getPrice());
                    productDTO.setStorageValue(s.getProduct().getStorage().getValue());
                    productDTO.setColorValue(s.getProduct().getColor().getValue());
                    productDTOList.add(productDTO);
                }
                responseObject.add("similarProducts",AppUtil.GSON.toJsonTree(productDTOList));
                status=true;
            }
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String getSingleProduct(String sId) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if (sId == null || sId.isBlank()) {
            message = "Product number not found!";
        } else if (!sId.matches(Validator.IS_INTEGER)) {
            message = "Invalid product number!";
        } else {
            int stockId = Integer.parseInt(sId);
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Stock stock = hibernateSession.find(Stock.class, stockId);

            ProductDTO productDTO = new ProductDTO();
            productDTO.setStockId(stock.getId());
            productDTO.setTitle(stock.getProduct().getTitle());
            productDTO.setPrice(stock.getPrice());
            productDTO.setQty(stock.getQty());
            productDTO.setBrandName(stock.getProduct().getModel().getBrand().getName());
            productDTO.setModelName(stock.getProduct().getModel().getName());
            
            productDTO.setQualityValue(stock.getProduct().getQuality() != null ? stock.getProduct().getQuality().getValue() : "N/A");
            
            List<String> imagePaths = new ArrayList<>();
            List<lk.jiat.ElectroZone.entity.ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", lk.jiat.ElectroZone.entity.ProductImage.class)
                    .setParameter("product", stock.getProduct())
                    .getResultList();
            if (!pImages.isEmpty()) {
                for (lk.jiat.ElectroZone.entity.ProductImage pi : pImages) {
                    imagePaths.add(pi.getImageUrl());
                }
            } else {
                imagePaths.add("assets/img/default-product.png");
            }
            productDTO.setImages(imagePaths);
            
            productDTO.setColorValue(stock.getProduct().getColor().getValue());
            productDTO.setStorageValue(stock.getProduct().getStorage().getValue());
            productDTO.setDescription(stock.getProduct().getDescription());

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd yyyy");
            productDTO.setCreatedAt(formatter.format(stock.getCreatedAt()));
            responseObject.add("singleProduct", AppUtil.GSON.toJsonTree(productDTO));
            status = true;
            hibernateSession.close();
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
