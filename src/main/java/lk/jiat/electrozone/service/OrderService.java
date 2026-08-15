package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.util.Env;
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

                Status completedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                        .setParameter("value", String.valueOf(Status.Type.COMPLETED))
                        .getSingleResult();
                order.setStatus(completedStatus);
                hibernateSession.merge(order);

                List<Cart> cartList = hibernateSession.createQuery("FROM Cart c WHERE c.user=:user", Cart.class)
                        .setParameter("user", order.getUser())
                        .getResultList();
                for (Cart cart : cartList) {
                    hibernateSession.remove(cart);
                }

                transaction.commit();

                try {
                    User user = order.getUser();
                    if (user != null && user.getEmail() != null) {
                        String recipientEmail = user.getEmail();
                        String buyerName = (user.getFirstName() != null ? user.getFirstName() : "") + " " + (user.getLastName() != null ? user.getLastName() : "");

                        String buyerAddress = "Customer Address";
                        String cityName = "Sri Lanka";
                        try {
                            List<Address> userAddresses = hibernateSession.createQuery(
                                    "FROM Address a WHERE a.user=:user ORDER BY a.isPrimary DESC", Address.class)
                                    .setParameter("user", user)
                                    .getResultList();
                            if (!userAddresses.isEmpty()) {
                                Address a = userAddresses.get(0);
                                buyerAddress = a.getLineOne() + (a.getLineTwo() != null && !a.getLineTwo().isBlank() ? ", " + a.getLineTwo() : "");
                                if (a.getCity() != null) cityName = a.getCity().getName();
                            }
                        } catch (Exception e) {
                            System.out.println("Could not resolve address for email: " + e.getMessage());
                        }

                        double withinCityPrice = 300.0;
                        double outOfCityPrice = 500.0;
                        try {
                            List<DeliveryType> deliveryTypes = hibernateSession.createQuery("FROM DeliveryType", DeliveryType.class).getResultList();
                            for (DeliveryType dt : deliveryTypes) {
                                if (String.valueOf(DeliveryType.Value.WITHIN_CITY).equalsIgnoreCase(dt.getName())) {
                                    withinCityPrice = dt.getPrice();
                                } else if (String.valueOf(DeliveryType.Value.OUT_OF_CITY).equalsIgnoreCase(dt.getName())) {
                                    outOfCityPrice = dt.getPrice();
                                }
                            }
                        } catch (Exception ignored) {}

                        StringBuilder itemsHtml = new StringBuilder();
                        double subtotal = 0;
                        double shippingCharges = 0;
                        int idx = 1;

                        for (OrderItem item : order.getOrderItems()) {
                            String pTitle = item.getStock() != null && item.getStock().getProduct() != null ? item.getStock().getProduct().getTitle() : "Product";
                            double uPrice = item.getStock() != null ? item.getStock().getPrice() : 0.0;
                            int qty = item.getQty();
                            double lineTotal = uPrice * qty;
                            subtotal += lineTotal;

                            try {
                                if (item.getSeller() != null && item.getSeller().getUser() != null) {
                                    List<Address> sAddresses = hibernateSession.createQuery(
                                            "FROM Address a WHERE a.user=:user ORDER BY a.isPrimary DESC", Address.class)
                                            .setParameter("user", item.getSeller().getUser())
                                            .getResultList();
                                    if (!sAddresses.isEmpty() && sAddresses.get(0).getCity() != null && sAddresses.get(0).getCity().getName().equalsIgnoreCase(cityName)) {
                                        shippingCharges += withinCityPrice;
                                    } else {
                                        shippingCharges += outOfCityPrice;
                                    }
                                } else {
                                    shippingCharges += withinCityPrice;
                                }
                            } catch (Exception e) {
                                shippingCharges += withinCityPrice;
                            }

                            itemsHtml.append("<tr>")
                                .append("<td style='padding: 12px 14px; border-bottom: 1px solid #f1f5f9; color: #64748b;'>").append(idx++).append("</td>")
                                .append("<td style='padding: 12px 14px; border-bottom: 1px solid #f1f5f9; font-weight: 600; color: #1e293b;'>").append(pTitle).append("</td>")
                                .append("<td style='padding: 12px 14px; border-bottom: 1px solid #f1f5f9; text-align: center; color: #334155;'>").append(qty).append("</td>")
                                .append("<td style='padding: 12px 14px; border-bottom: 1px solid #f1f5f9; text-align: right; color: #334155;'>Rs. ").append(String.format("%,.2f", uPrice)).append("</td>")
                                .append("<td style='padding: 12px 14px; border-bottom: 1px solid #f1f5f9; text-align: right; font-weight: 700; color: #1e293b;'>Rs. ").append(String.format("%,.2f", lineTotal)).append("</td>")
                                .append("</tr>");
                        }

                        double grandTotal = subtotal + shippingCharges;
                        String orderDateStr = java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy").format(order.getCreatedAt());
                        String invoiceUrl = Env.get("app.url") + "/invoice.jsp?orderId=" + oId;

                        String emailHtml = 
                            "<div style='font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif; max-width: 650px; margin: 0 auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0; box-shadow: 0 4px 15px rgba(0,0,0,0.05);'>" +

                            "<div style='background: linear-gradient(135deg, #2563eb, #1d4ed8); padding: 28px 32px; text-align: center; color: #ffffff;'>" +
                                "<h1 style='margin: 0; font-size: 24px; font-weight: 800; letter-spacing: -0.5px;'>ElectroZone</h1>" +
                                "<p style='margin: 6px 0 0 0; color: #bfdbfe; font-size: 14px;'>Official Payment Receipt & Tax Invoice</p>" +
                            "</div>" +

                            "<div style='padding: 30px;'>" +
                                "<div style='display: flex; justify-content: space-between; margin-bottom: 24px; border-bottom: 2px solid #f1f5f9; padding-bottom: 16px;'>" +
                                    "<table style='width: 100%;'><tr>" +
                                        "<td>" +
                                            "<span style='font-size: 12px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px;'>Invoice Number</span><br>" +
                                            "<span style='font-size: 18px; font-weight: 800; color: #2563eb;'>#000" + oId + "</span>" +
                                        "</td>" +
                                        "<td style='text-align: center;'>" +
                                            "<span style='font-size: 12px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px;'>Date</span><br>" +
                                            "<span style='font-size: 14px; font-weight: 600; color: #334155;'>" + orderDateStr + "</span>" +
                                        "</td>" +
                                        "<td style='text-align: right;'>" +
                                            "<span style='font-size: 12px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px;'>Status</span><br>" +
                                            "<span style='background-color: #10b981; color: #ffffff; font-size: 12px; font-weight: 700; padding: 4px 14px; border-radius: 50px;'>PAID</span>" +
                                        "</td>" +
                                    "</tr></table>" +
                                "</div>" +

                                "<table style='width: 100%; margin-bottom: 24px; background: #f8fafc; border-radius: 8px; padding: 16px; border: 1px solid #e2e8f0;'>" +
                                    "<tr>" +
                                        "<td style='width: 50%; vertical-align: top; padding: 10px;'>" +
                                            "<div style='font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; margin-bottom: 6px;'>Billed To (Customer)</div>" +
                                            "<div style='font-weight: 700; color: #1e293b; font-size: 14px;'>" + buyerName + "</div>" +
                                            "<div style='color: #64748b; font-size: 13px; margin-top: 2px;'>" + buyerAddress + "</div>" +
                                            "<div style='color: #64748b; font-size: 13px;'>" + cityName + ", Sri Lanka</div>" +
                                            "<div style='color: #2563eb; font-size: 13px; margin-top: 2px; font-weight: 600;'>" + recipientEmail + "</div>" +
                                        "</td>" +
                                        "<td style='width: 50%; vertical-align: top; text-align: right; padding: 10px;'>" +
                                            "<div style='font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; margin-bottom: 6px;'>Merchant (From)</div>" +
                                            "<div style='font-weight: 700; color: #1e293b; font-size: 14px;'>ElectroZone (PVT) LTD</div>" +
                                            "<div style='color: #64748b; font-size: 13px; margin-top: 2px;'>No 45, Galle Road, Colombo 03</div>" +
                                            "<div style='color: #64748b; font-size: 13px;'>Western Province, Sri Lanka</div>" +
                                            "<div style='color: #64748b; font-size: 13px;'>info@electrozone.lk</div>" +
                                        "</td>" +
                                    "</tr>" +
                                "</table>" +

                                "<table style='width: 100%; border-collapse: collapse; margin-bottom: 20px;'>" +
                                    "<thead>" +
                                        "<tr style='background-color: #f1f5f9;'>" +
                                            "<th style='padding: 10px 14px; text-align: left; font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;'>#</th>" +
                                            "<th style='padding: 10px 14px; text-align: left; font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;'>Product Details</th>" +
                                            "<th style='padding: 10px 14px; text-align: center; font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;'>Qty</th>" +
                                            "<th style='padding: 10px 14px; text-align: right; font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;'>Unit Price</th>" +
                                            "<th style='padding: 10px 14px; text-align: right; font-size: 12px; font-weight: 700; color: #475569; text-transform: uppercase;'>Line Total</th>" +
                                        "</tr>" +
                                    "</thead>" +
                                    "<tbody>" +
                                        itemsHtml.toString() +
                                    "</tbody>" +
                                "</table>" +

                                "<div style='background: #f8fafc; border-radius: 8px; padding: 16px 20px; max-width: 280px; margin-left: auto; border: 1px solid #e2e8f0; margin-bottom: 24px;'>" +
                                    "<table style='width: 100%;'>" +
                                        "<tr>" +
                                            "<td style='color: #64748b; font-size: 13px; padding-bottom: 6px;'>Subtotal</td>" +
                                            "<td style='text-align: right; font-weight: 600; color: #1e293b; font-size: 13px; padding-bottom: 6px;'>Rs. " + String.format("%,.2f", subtotal) + "</td>" +
                                        "</tr>" +
                                        "<tr>" +
                                            "<td style='color: #64748b; font-size: 13px; padding-bottom: 6px;'>Shipping Fee</td>" +
                                            "<td style='text-align: right; font-weight: 600; color: #1e293b; font-size: 13px; padding-bottom: 6px;'>Rs. " + String.format("%,.2f", shippingCharges) + "</td>" +
                                        "</tr>" +
                                        "<tr><td colspan='2'><hr style='border: none; border-top: 1px solid #e2e8f0; margin: 6px 0;'></td></tr>" +
                                        "<tr>" +
                                            "<td style='font-weight: 700; font-size: 15px; color: #1e293b;'>Grand Total</td>" +
                                            "<td style='text-align: right; font-weight: 800; font-size: 16px; color: #2563eb;'>Rs. " + String.format("%,.2f", grandTotal) + "</td>" +
                                        "</tr>" +
                                    "</table>" +
                                "</div>" +

                                "<div style='text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #f1f5f9;'>" +
                                    "<a href='" + invoiceUrl + "' style='background-color: #2563eb; color: #ffffff; text-decoration: none; padding: 12px 28px; font-size: 14px; font-weight: 700; border-radius: 50px; display: inline-block;'>View / Print Full Invoice Online</a>" +
                                "</div>" +
                            "</div>" +

                            "<div style='background-color: #f8fafc; padding: 16px; text-align: center; border-top: 1px solid #e2e8f0; color: #94a3b8; font-size: 12px;'>" +
                                "Thank you for choosing ElectroZone! | Colombo 03, Sri Lanka" +
                            "</div>" +
                        "</div>";

                        String mailSubject = "Invoice #000" + oId + " - Payment Confirmation | ElectroZone";
                        lk.jiat.ElectroZone.mail.InvoiceMail invoiceMail = new lk.jiat.ElectroZone.mail.InvoiceMail(recipientEmail, mailSubject, emailHtml);
                        lk.jiat.ElectroZone.provider.MailServiceProvider.getInstance().sendMail(invoiceMail);
                    }
                } catch (Exception ex) {
                    System.out.println("Email send notice: " + ex.getMessage());
                }

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
