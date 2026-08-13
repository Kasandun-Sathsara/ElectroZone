package lk.jiat.ElectroZone.service;

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
            List<Product> products = session.createQuery("FROM Product p ORDER BY p.id DESC", Product.class).getResultList();
            List<ProductDTO> dtos = new ArrayList<>();
            for (Product p : products) {
                ProductDTO dto = new ProductDTO();
                dto.setProductId(p.getId());
                dto.setTitle(p.getTitle());
                if(p.getModel() != null) {
                    dto.setBrandName(p.getModel().getBrand().getName());
                    dto.setModelName(p.getModel().getName());
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
}
