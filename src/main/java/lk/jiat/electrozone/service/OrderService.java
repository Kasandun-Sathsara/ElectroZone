package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
public class OrderService {
    public Order createPendingOrder(User user, Session hibernateSession) {
        Status pendingStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                .setParameter("value", String.valueOf(Status.Type.PENDING))
                .getSingleResult();
        Order order = new Order();
        order.setUser(user);
        order.setStatus(pendingStatus);

        hibernateSession.persist(order);

        List<Cart> cartList = hibernateSession.createQuery("FROM Cart c WHERE c.user=:user", Cart.class)
                .setParameter("user", user)
                .getResultList();
        for (Cart cart : cartList) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setQty(cart.getQty());
            orderItem.setRating(AppUtil.DEFAULT_RATING_VALUE);
            orderItem.setStock(cart.getStock());
            orderItem.setSeller(cart.getStock().getProduct().getSeller());
            hibernateSession.persist(orderItem);
        }
        hibernateSession.beginTransaction().commit();
        return order;
    }

    public void completeOrder(String orderId) {
        int oId = Integer.parseInt(orderId.replaceAll(Validator.NON_DIGIT_PATTERN, ""));

        try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = hibernateSession.beginTransaction();
            try {
                Order order = hibernateSession.find(Order.class, oId);
                if (order == null) {
                    throw new RuntimeException("Order not found for Order ID: " + oId);
                }
                // update stock quantity
                List<OrderItem> orderItems = order.getOrderItems();
                if (orderItems != null && !orderItems.isEmpty()) {
                    for (OrderItem orderItem : orderItems) {
                        Stock stock = orderItem.getStock();
                        int updatedQty = stock.getQty() - orderItem.getQty();
                        if (updatedQty < 0) {
                            throw new RuntimeException("Insufficient stock for product: " + stock.getProduct().getTitle());
                        }
                        stock.setQty(updatedQty);
                        hibernateSession.merge(stock);
                    }
                }

                // update order status
                Status completedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                        .setParameter("value", String.valueOf(Status.Type.COMPLETED))
                        .getSingleResult();
                order.setStatus(completedStatus);
                hibernateSession.merge(order);

                // remove cart items
                List<Cart> cartList = hibernateSession.createQuery("FROM Cart c WHERE c.user=:user", Cart.class)
                        .setParameter("user", order.getUser())
                        .getResultList();
                for (Cart cart : cartList) {
                    hibernateSession.remove(cart); // completely remove from db
                }
                transaction.commit();
            } catch (HibernateException e) {
                transaction.rollback();
                throw new RuntimeException("Failed to complete order: " + e.getMessage(), e);
            }
        }
    }

    public void failedOrder(String orderId) {
        int oId = Integer.parseInt(orderId.replaceAll(Validator.NON_DIGIT_PATTERN, ""));
        try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = hibernateSession.beginTransaction();
            try {
                Order order = hibernateSession.find(Order.class, oId);
                if (order == null) {
                    throw new RuntimeException("Order not foud for Order Id: " + oId);
                }
                Status rejectedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                        .setParameter("value", String.valueOf(Status.Type.REJECTED)).getSingleResult();
                order.setStatus(rejectedStatus);
                hibernateSession.merge(order);
                transaction.commit();
            } catch (HibernateException e) {
                transaction.rollback();
                throw new RuntimeException("Failed to reject order: " + oId);
            }
        }
    }

    public String getUserOrders(HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            User user = (User) httpSession.getAttribute("user");
            
            try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
                List<Order> orders = hibernateSession.createQuery("FROM Order o WHERE o.user=:user ORDER BY o.createdAt DESC", Order.class)
                        .setParameter("user", user)
                        .getResultList();
                        
                com.google.gson.JsonArray ordersArray = new com.google.gson.JsonArray();
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy");
                
                for (Order order : orders) {
                    JsonObject orderObj = new JsonObject();
                    orderObj.addProperty("id", order.getId());
                    orderObj.addProperty("status", order.getStatus().getValue());
                    orderObj.addProperty("createdAt", order.getCreatedAt().format(formatter));
                    
                    double total = 0;
                    com.google.gson.JsonArray itemsArray = new com.google.gson.JsonArray();
                    
                    for (OrderItem item : order.getOrderItems()) {
                        JsonObject itemObj = new JsonObject();
                        itemObj.addProperty("productTitle", item.getStock().getProduct().getTitle());
                        itemObj.addProperty("qty", item.getQty());
                        itemObj.addProperty("price", item.getStock().getPrice());
                        
                        total += (item.getQty() * item.getStock().getPrice());
                        
                        List<ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", ProductImage.class)
                                .setParameter("product", item.getStock().getProduct())
                                .setMaxResults(1)
                                .getResultList();
                        if (!pImages.isEmpty()) {
                            itemObj.addProperty("image", pImages.get(0).getImageUrl());
                        } else {
                            itemObj.addProperty("image", "assets/img/default-product.png");
                        }
                        itemsArray.add(itemObj);
                    }
                    
                    orderObj.addProperty("total", total);
                    orderObj.add("items", itemsArray);
                    ordersArray.add(orderObj);
                }
                
                responseObject.add("orders", ordersArray);
                status = true;
            } catch (Exception e) {
                message = "Failed to load orders: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            responseObject.addProperty("status_code", 401);
            message = "Please login first";
        }
        
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String verifyOrderDetails(String orderId){
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        int oId = Integer.parseInt(orderId.replaceAll(Validator.NON_DIGIT_PATTERN,""));
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        Order order = hibernateSession.find(Order.class, oId);
        if(order==null){
            message="Incorrect oder details. Please check credentials!";
        }else{
            if(order.getStatus().getValue().equals(String.valueOf(Status.Type.COMPLETED))){
                status=true;
            }
        }
        hibernateSession.close();
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
