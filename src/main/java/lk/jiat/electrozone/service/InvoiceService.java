package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.dto.InvoiceDTO;
import lk.jiat.ElectroZone.dto.InvoiceItemDTO;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.Session;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class InvoiceService {
    private static final String INVOICE_PAID_STATUS = "PAID";

    public String getInvoiceData(String orderId) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        if (orderId == null || orderId.trim().isEmpty()) {
            responseObject.addProperty("status", false);
            responseObject.addProperty("message", "Invalid order ID");
            return AppUtil.GSON.toJson(responseObject);
        }

        try {
            int oId = Integer.parseInt(orderId.replaceAll(Validator.NON_DIGIT_PATTERN, ""));

            try {
                OrderService orderService = new OrderService();
                orderService.completeOrder(orderId);
            } catch (Exception e) {

                System.out.println("Auto-complete in InvoiceService notice: " + e.getMessage());
            }

            try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
                Order order = hibernateSession.find(Order.class, oId);
                if (order == null) {
                    message = "Order not found for ID: " + orderId;
                } else {
                    InvoiceDTO invoiceDTO = new InvoiceDTO();
                    invoiceDTO.setInvoiceNo("000" + order.getId());
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
                    invoiceDTO.setInvoiceDate(formatter.format(order.getCreatedAt()));

                    User user = order.getUser();
                    if (user != null) {
                        invoiceDTO.setBuyerName(user.getFirstName() + " " + (user.getLastName() != null ? user.getLastName() : ""));
                        invoiceDTO.setEmail(user.getEmail());

                        List<Address> userAddresses = hibernateSession.createQuery(
                                "FROM Address a WHERE a.user=:user ORDER BY a.isPrimary DESC", Address.class)
                                .setParameter("user", user)
                                .getResultList();

                        Address userAddress = userAddresses.isEmpty() ? null : userAddresses.get(0);
                        if (userAddress != null) {
                            invoiceDTO.setAddress(userAddress.getLineOne() +
                                    (userAddress.getLineTwo() != null && !userAddress.getLineTwo().isBlank() ? ", " + userAddress.getLineTwo() : ""));
                            invoiceDTO.setCityName(userAddress.getCity() != null ? userAddress.getCity().getName() : "Colombo");
                        } else {
                            invoiceDTO.setAddress("Customer Address");
                            invoiceDTO.setCityName("Colombo");
                        }
                    } else {
                        invoiceDTO.setBuyerName("Customer");
                        invoiceDTO.setEmail("");
                        invoiceDTO.setAddress("Customer Address");
                        invoiceDTO.setCityName("Colombo");
                    }
                    invoiceDTO.setCountryName("Sri Lanka");

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
                    } catch (Exception e) {
                        System.out.println("Could not load delivery types, using defaults: " + e.getMessage());
                    }

                    List<InvoiceItemDTO> itemDTOS = new ArrayList<>();
                    double shippingCharges = 0;

                    List<OrderItem> orderItems = hibernateSession.createQuery(
                            "FROM OrderItem oi WHERE oi.order=:order", OrderItem.class)
                            .setParameter("order", order)
                            .getResultList();

                    for (OrderItem orderItem : orderItems) {
                        InvoiceItemDTO itemDTO = new InvoiceItemDTO();
                        String title = "Product";
                        double price = 0;

                        if (orderItem.getStock() != null) {
                            price = orderItem.getStock().getPrice();
                            if (orderItem.getStock().getProduct() != null) {
                                title = orderItem.getStock().getProduct().getTitle();
                            }
                        }

                        itemDTO.setItemName(title);
                        itemDTO.setItemQty(orderItem.getQty());
                        itemDTO.setItemPrice(price);
                        itemDTOS.add(itemDTO);

                        try {
                            if (orderItem.getSeller() != null && orderItem.getSeller().getUser() != null) {
                                User seller = orderItem.getSeller().getUser();
                                List<Address> sellerAddresses = hibernateSession.createQuery(
                                        "FROM Address a WHERE a.user=:user ORDER BY a.isPrimary DESC", Address.class)
                                        .setParameter("user", seller)
                                        .getResultList();

                                if (!sellerAddresses.isEmpty() && invoiceDTO.getCityName() != null &&
                                        sellerAddresses.get(0).getCity() != null &&
                                        invoiceDTO.getCityName().equalsIgnoreCase(sellerAddresses.get(0).getCity().getName())) {
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
                    }

                    invoiceDTO.setShippingCharges(shippingCharges);
                    invoiceDTO.setInvoiceItemDTOList(itemDTOS);
                    invoiceDTO.setInvoiceStatus(InvoiceService.INVOICE_PAID_STATUS);

                    status = true;
                    responseObject.add("invoiceData", AppUtil.GSON.toJsonTree(invoiceDTO));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error loading invoice: " + e.getMessage();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
