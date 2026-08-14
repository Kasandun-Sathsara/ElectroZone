package lk.jiat.ElectroZone.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.dto.AdminDashboardResponseDTO;
import lk.jiat.ElectroZone.dto.InvoiceDTO;
import lk.jiat.ElectroZone.dto.ProductDTO;
import lk.jiat.ElectroZone.dto.StockDTO;
import lk.jiat.ElectroZone.entity.Order;
import lk.jiat.ElectroZone.entity.Product;
import lk.jiat.ElectroZone.entity.Stock;
import lk.jiat.ElectroZone.entity.Status;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletContext;
import java.io.InputStream;
import org.glassfish.jersey.media.multipart.BodyPart;
import org.glassfish.jersey.media.multipart.ContentDisposition;
import lk.jiat.ElectroZone.entity.*;

public class AdminService {
    public String getDashboardStats() {
        AdminDashboardResponseDTO response = new AdminDashboardResponseDTO();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long totalOrders = session.createQuery("SELECT count(o) FROM Order o", Long.class).uniqueResult();
            response.setTotalOrders(totalOrders != null ? totalOrders : 0);

            Double totalRevenue = session.createQuery("SELECT sum(oi.qty * oi.stock.price) FROM OrderItem oi", Double.class).uniqueResult();
            response.setTotalRevenue(totalRevenue != null ? totalRevenue : 0);

            Long totalProducts = session.createQuery("SELECT count(p) FROM Product p", Long.class).uniqueResult();
            response.setTotalProducts(totalProducts != null ? totalProducts : 0);

            Long totalCustomers = session.createQuery("SELECT count(u) FROM User u", Long.class).uniqueResult();
            response.setTotalCustomers(totalCustomers != null ? totalCustomers : 0);

            List<Order> orders = session.createQuery("FROM Order o ORDER BY o.id DESC", Order.class).setMaxResults(5).getResultList();
            List<InvoiceDTO> recentOrders = new ArrayList<>();
            for (Order order : orders) {
                InvoiceDTO dto = new InvoiceDTO();
                dto.setInvoiceNo("ORD-" + String.format("%04d", order.getId()));
                dto.setInvoiceDate(order.getCreatedAt().toString());
                dto.setInvoiceStatus(order.getStatus() != null ? order.getStatus().getValue() : "PENDING");
                dto.setBuyerName(order.getUser() != null ? order.getUser().getFullName() : "Unknown");
                double total = order.getOrderItems().stream().mapToDouble(oi -> oi.getQty() * oi.getStock().getPrice()).sum();
                dto.setShippingCharges(total);
                recentOrders.add(dto);
            }
            response.setRecentOrders(recentOrders);

            List<Stock> lowStocks = session.createQuery("FROM Stock s WHERE s.qty < 10 ORDER BY s.qty ASC", Stock.class).setMaxResults(5).getResultList();
            List<ProductDTO> lowStockAlerts = new ArrayList<>();
            for (Stock stock : lowStocks) {
                ProductDTO pDTO = new ProductDTO();
                pDTO.setProductId(stock.getProduct().getId());
                pDTO.setTitle(stock.getProduct().getTitle());
                pDTO.setQty(stock.getQty());
                if (stock.getProduct().getImages() != null && !stock.getProduct().getImages().isEmpty()) {
                    List<String> images = new ArrayList<>();
                    images.add(stock.getProduct().getImages().get(0));
                    pDTO.setImages(images);
                }
                lowStockAlerts.add(pDTO);
            }
            response.setLowStockAlerts(lowStockAlerts);

            response.setStatus(true);
            response.setMessage("Success");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(false);
            response.setMessage("Failed to load dashboard data");
        }
        return AppUtil.GSON.toJson(response);
    }

    public String getAllProducts() {
        JsonObject responseObject = new JsonObject();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            try {
                int count1 = session.createNativeQuery("INSERT INTO product_images_list (pr_id, images) SELECT pr_id, images FROM product_images WHERE images IS NOT NULL AND pr_id NOT IN (SELECT pr_id FROM product_images_list)").executeUpdate();
                int count2 = session.createNativeQuery("INSERT INTO product_image_entities (product_id, image_url, is_primary) SELECT pr_id, images, 1 FROM product_images WHERE images IS NOT NULL AND pr_id NOT IN (SELECT product_id FROM product_image_entities)").executeUpdate();
                responseObject.addProperty("migration", "Success: " + count1 + "," + count2);
            } catch(Exception e) {
                responseObject.addProperty("migration", "Error: " + e.getMessage());
            }
            tx.commit();
            
            List<Product> products = session.createQuery("FROM Product p ORDER BY p.id DESC", Product.class).getResultList();
            List<ProductDTO> dtos = new ArrayList<>();
            for (Product p : products) {
                ProductDTO dto = new ProductDTO();
                dto.setProductId(p.getId());
                dto.setTitle(p.getTitle());
                if(p.getCategory() != null) {
                    dto.setCategoryId(p.getCategory().getId());
                    dto.setCategoryName(p.getCategory().getName());
                }
                if(p.getModel() != null) {
                    if(p.getModel().getBrand() != null) {
                        dto.setBrandId(p.getModel().getBrand().getId());
                        dto.setBrandName(p.getModel().getBrand().getName());
                    }
                    dto.setModelId(p.getModel().getId());
                    dto.setModelName(p.getModel().getName());
                }
                if(p.getStorage() != null) {
                    dto.setStorageId(p.getStorage().getId());
                    dto.setStorageValue(p.getStorage().getValue());
                }
                if(p.getColor() != null) {
                    dto.setColorId(p.getColor().getId());
                    dto.setColorValue(p.getColor().getValue());
                }
                List<Stock> stocks = session.createQuery("FROM Stock s WHERE s.product=:product ORDER BY s.id DESC", Stock.class).setParameter("product", p).getResultList();
                List<StockDTO> stockDTOList = new ArrayList<>();
                int totalQty = 0;
                double minPrice = 0;
                if(!stocks.isEmpty()) minPrice = stocks.get(0).getPrice();
                for (Stock s : stocks) {
                    StockDTO stockDTO = new StockDTO();
                    stockDTO.setStockId(s.getId());
                    stockDTO.setQty(s.getQty());
                    stockDTO.setPrice(s.getPrice());
                    stockDTOList.add(stockDTO);
                    totalQty += s.getQty();
                }
                dto.setQty(totalQty);
                dto.setPrice(minPrice);
                dto.setStockDTOList(stockDTOList);
                if (p.getImages() != null && !p.getImages().isEmpty()) {
                    List<String> images = new ArrayList<>();
                    images.add(p.getImages().get(0));
                    dto.setImages(images);
                } else {
                    List<lk.jiat.ElectroZone.entity.ProductImage> pImages = session.createQuery("FROM ProductImage p WHERE p.product=:product", lk.jiat.ElectroZone.entity.ProductImage.class).setParameter("product", p).getResultList();
                    if(!pImages.isEmpty()) {
                        List<String> images = new ArrayList<>();
                        images.add(pImages.get(0).getImageUrl());
                        dto.setImages(images);
                    }
                }
                dtos.add(dto);
            }
            responseObject.addProperty("status", true);
            responseObject.add("products", AppUtil.GSON.toJsonTree(dtos));
        } catch (Exception e) {
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to load products");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String deleteProduct(int id) {
        JsonObject responseObject = new JsonObject();
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Product product = session.find(Product.class, id);
            if (product != null) {
                session.remove(product);
                transaction.commit();
                responseObject.addProperty("status", true);
                responseObject.addProperty("message", "Product deleted successfully");
            } else {
                responseObject.addProperty("status", false);
                responseObject.addProperty("message", "Product not found");
            }
        } catch (Exception e) {
            if(transaction != null) transaction.rollback();
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to delete product");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String getAllCustomers() {
        JsonObject responseObject = new JsonObject();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<User> users = session.createQuery("FROM User u WHERE u.role.name = 'USER' ORDER BY u.id DESC", User.class).getResultList();
            JsonArray customersArray = new JsonArray();
            for (User u : users) {
                JsonObject obj = new JsonObject();
                obj.addProperty("id", u.getId());
                obj.addProperty("fullName", u.getFullName());
                obj.addProperty("email", u.getEmail());
                obj.addProperty("mobile", u.getMobile());
                obj.addProperty("sinceAt", u.getCreatedAt() != null ? u.getCreatedAt().toString() : "Unknown");
                obj.addProperty("status", u.getStatus() != null ? u.getStatus().getValue() : "UNKNOWN");
                customersArray.add(obj);
            }
            responseObject.addProperty("status", true);
            responseObject.add("customers", customersArray);
        } catch (Exception e) {
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to load customers");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String updateCustomerStatus(int id, String statusName) {
        JsonObject responseObject = new JsonObject();
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            User user = session.find(User.class, id);
            if (user != null) {
                Status userStatus = session.createQuery("FROM Status s WHERE s.value=:name", Status.class)
                                           .setParameter("name", statusName).uniqueResult();
                if (userStatus != null) {
                    user.setStatus(userStatus);
                    session.merge(user);
                    transaction.commit();
                    responseObject.addProperty("status", true);
                    responseObject.addProperty("message", "Customer status updated successfully");
                } else {
                    responseObject.addProperty("status", false);
                    responseObject.addProperty("message", "Invalid customer status");
                }
            } else {
                responseObject.addProperty("status", false);
                responseObject.addProperty("message", "Customer not found");
            }
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to update customer status");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String getAllOrders() {
        JsonObject responseObject = new JsonObject();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<Order> orders = session.createQuery("FROM Order o ORDER BY o.id DESC", Order.class).getResultList();
            List<InvoiceDTO> dtos = new ArrayList<>();
            for (Order order : orders) {
                InvoiceDTO dto = new InvoiceDTO();
                dto.setInvoiceNo("ORD-" + String.format("%04d", order.getId()));
                double total = order.getOrderItems().stream().mapToDouble(oi -> oi.getQty() * oi.getStock().getPrice()).sum();
                dto.setShippingCharges(total);
                dto.setBuyerName(order.getUser() != null ? order.getUser().getFullName() : "Unknown");
                dto.setInvoiceDate(order.getCreatedAt().toString());
                dto.setInvoiceStatus(order.getStatus() != null ? order.getStatus().getValue() : "PENDING");
                dto.setEmail(String.valueOf(order.getId())); 
                dtos.add(dto);
            }
            responseObject.addProperty("status", true);
            responseObject.add("orders", AppUtil.GSON.toJsonTree(dtos));
        } catch (Exception e) {
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to load orders");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String updateOrderStatus(int id, String statusName) {
        JsonObject responseObject = new JsonObject();
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Order order = session.find(Order.class, id);
            if (order != null) {
                Status orderStatus = session.createQuery("FROM Status s WHERE s.value=:name", Status.class).setParameter("name", statusName).uniqueResult();
                if (orderStatus != null) {
                    order.setStatus(orderStatus);
                    session.merge(order);
                    transaction.commit();
                    responseObject.addProperty("status", true);
                    responseObject.addProperty("message", "Order status updated successfully");
                } else {
                    responseObject.addProperty("status", false);
                    responseObject.addProperty("message", "Invalid order status");
                }
            } else {
                responseObject.addProperty("status", false);
                responseObject.addProperty("message", "Order not found");
            }
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Failed to update order status");
        }
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewProductAdmin(ProductDTO productDTO, List<BodyPart> imageParts, ServletContext context) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        if (productDTO.getCategoryId() <= 0) {
            message = "Invalid category.";
        } else if (productDTO.getBrandId() <= 0) {
            message = "Invalid brand type.";
        } else if (productDTO.getModelId() <= 0) {
            message = "Invalid model type.";
        } else if (productDTO.getTitle() == null || productDTO.getTitle().isBlank()) {
            message = "Product title is required!";
        } else if (productDTO.getDescription() == null || productDTO.getDescription().isBlank()) {
            message = "Product description is required!";
        } else if (productDTO.getStorageId() <= 0) {
            message = "Invalid storage type.";
        } else if (productDTO.getColorId() <= 0) {
            message = "Invalid color type.";
        } else if (productDTO.getPrice() <= 0) {
            message = "Price must be greater than 0.";
        } else if (productDTO.getQty() <= 0) {
            message = "Quantity must be greater than 0.";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Category category = hibernateSession.find(Category.class, productDTO.getCategoryId());
            Model model = hibernateSession.find(Model.class, productDTO.getModelId());
            Storage storage = hibernateSession.find(Storage.class, productDTO.getStorageId());
            Color color = hibernateSession.find(Color.class, productDTO.getColorId());
            
            if (category != null && model != null && storage != null && color != null) {
                Product product = new Product();
                product.setTitle(productDTO.getTitle());
                product.setDescription(productDTO.getDescription());
                product.setCategory(category);
                product.setModel(model);
                product.setStorage(storage);
                product.setQuality(null);
                product.setColor(color);
                product.setSeller(null); // Added by Admin
                product.setImages(new ArrayList<>());
                
                Stock stock = new Stock();
                stock.setProduct(product);
                stock.setPrice(productDTO.getPrice());
                stock.setQty(productDTO.getQty());
                
                Transaction transaction = hibernateSession.beginTransaction();
                try {
                    Discount defaultDiscount = hibernateSession.createQuery("FROM Discount d WHERE d.couponCode='DEFAULT'", Discount.class)
                            .getResultStream().findFirst().orElse(null);
                    
                    if (defaultDiscount == null) {
                        defaultDiscount = new Discount();
                        defaultDiscount.setCouponCode("DEFAULT");
                        defaultDiscount.setValue(0.0);
                        defaultDiscount.setStartedAt(new java.util.Date());
                        // expire in 10 years
                        defaultDiscount.setExpiredAt(new java.util.Date(System.currentTimeMillis() + 10L * 365 * 24 * 60 * 60 * 1000));
                        hibernateSession.persist(defaultDiscount);
                    }

                    Status approvedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                            .setParameter("value", String.valueOf(Status.Type.APPROVED))
                            .getSingleResult();
                    
                    stock.setDiscount(defaultDiscount);
                    stock.setStatus(approvedStatus);

                    hibernateSession.persist(product);
                    hibernateSession.persist(stock);
                    
                    // Handle file uploads
                    FileUploadService fileUploadService = new FileUploadService(context);
                    if (imageParts != null) {
                        for (BodyPart part : imageParts) {
                            InputStream inputStream = part.getEntityAs(InputStream.class);
                            ContentDisposition contentDisposition = part.getContentDisposition();
                            FileUploadService.FileItem fileItem = fileUploadService.uploadFile("product_uploads", inputStream, contentDisposition);
                            boolean isPrimary = product.getImages().isEmpty();
                            product.getImages().add(fileItem.getFilePath());
                            
                            ProductImage pi = new ProductImage(product, fileItem.getFilePath(), isPrimary);
                            hibernateSession.persist(pi);
                        }
                    }
                    
                    hibernateSession.merge(product); // Update images list
                    transaction.commit();
                    status = true;
                    message = "Product added successfully";
                } catch (Exception e) {
                    transaction.rollback();
                    e.printStackTrace();
                    message = "Failed to save product to database: " + e.getMessage();
                }
            } else {
                message = "Invalid product attributes provided.";
            }
            hibernateSession.close();
        }
        
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewBrand(String name) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if(name == null || name.isBlank()) {
            message = "Brand name is required";
        } else {
            Transaction transaction = null;
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();
                Brand brand = new Brand();
                brand.setName(name);
                session.persist(brand);
                transaction.commit();
                status = true;
                message = "Brand added successfully";
                responseObject.addProperty("id", brand.getId());
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
                message = "Failed to add brand";
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewModel(String name, int brandId) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if(name == null || name.isBlank() || brandId <= 0) {
            message = "Valid model name and brand are required";
        } else {
            Transaction transaction = null;
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();
                Brand brand = session.find(Brand.class, brandId);
                if(brand != null) {
                    Model model = new Model();
                    model.setName(name);
                    model.setBrand(brand);
                    session.persist(model);
                    transaction.commit();
                    status = true;
                    message = "Model added successfully";
                    responseObject.addProperty("id", model.getId());
                } else {
                    message = "Invalid brand selected";
                }
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
                message = "Failed to add model";
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewStorage(String value) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if(value == null || value.isBlank()) {
            message = "Storage value is required";
        } else {
            Transaction transaction = null;
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();
                Storage storage = new Storage();
                storage.setValue(value);
                session.persist(storage);
                transaction.commit();
                status = true;
                message = "Storage added successfully";
                responseObject.addProperty("id", storage.getId());
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
                message = "Failed to add storage";
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewColor(String value) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if(value == null || value.isBlank()) {
            message = "Color name is required";
        } else {
            Transaction transaction = null;
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();
                Color color = new Color();
                color.setValue(value);
                session.persist(color);
                transaction.commit();
                status = true;
                message = "Color added successfully";
                responseObject.addProperty("id", color.getId());
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
                message = "Failed to add color";
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewQuality(String value) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if(value == null || value.isBlank()) {
            message = "Quality/Condition name is required";
        } else {
            Transaction transaction = null;
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                transaction = session.beginTransaction();
                Quality quality = new Quality();
                quality.setValue(value);
                session.persist(quality);
                transaction.commit();
                status = true;
                message = "Quality added successfully";
                responseObject.addProperty("id", quality.getId());
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
                message = "Failed to add quality";
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
    
    
    public String addNewCategory(String name) {
        com.google.gson.JsonObject responseObject = new com.google.gson.JsonObject();
        org.hibernate.Session hibernateSession = lk.jiat.ElectroZone.util.HibernateUtil.getSessionFactory().openSession();
        org.hibernate.Transaction transaction = null;
        try {
            transaction = hibernateSession.beginTransaction();
            lk.jiat.ElectroZone.entity.Category category = new lk.jiat.ElectroZone.entity.Category();
            category.setName(name);
            hibernateSession.persist(category);
            transaction.commit();
            
            responseObject.addProperty("status", true);
            responseObject.addProperty("message", "Category added successfully.");
            responseObject.addProperty("id", category.getId());
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Category already exists or failed to save.");
        } finally {
            hibernateSession.close();
        }
        return lk.jiat.ElectroZone.util.AppUtil.GSON.toJson(responseObject);
    }
}
