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

        int oId = Integer.parseInt(orderId.replaceAll(Validator.NON_DIGIT_PATTERN, ""));
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        Order order = hibernateSession.find(Order.class, oId);
        if (order == null) {
            message = "Incorrect order details. Please check credentials!";
        } else {
            if (order.getStatus().getValue().equals(String.valueOf(Status.Type.COMPLETED))) {
                InvoiceDTO invoiceDTO = new InvoiceDTO();
                invoiceDTO.setInvoiceNo("000" + order.getId());
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
                invoiceDTO.setInvoiceDate(formatter.format(order.getCreatedAt()));

                User user = order.getUser();
                invoiceDTO.setBuyerName(user.getFirstName() + " " + user.getLastName());
                Address address = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=true", Address.class)
                        .setParameter("user", user)
                        .getSingleResult();
                invoiceDTO.setAddress(address.getLineOne() +
                        (address.getLineTwo() != null && !address.getLineTwo().isBlank() ? ", " + address.getLineTwo() : ""));
                invoiceDTO.setCityName(address.getCity().getName());
                invoiceDTO.setCountryName("Sri Lanka");
                invoiceDTO.setEmail(user.getEmail());

                List<InvoiceItemDTO> itemDTOS = new ArrayList<>();
                DeliveryType withinCity = hibernateSession.createNamedQuery("DeliveryType.findByName", DeliveryType.class)
                        .setParameter("name", String.valueOf(DeliveryType.Value.WITHIN_CITY)).getSingleResult();
                DeliveryType outOfCity = hibernateSession.createNamedQuery("DeliveryType.findByName", DeliveryType.class)
                        .setParameter("name", String.valueOf(DeliveryType.Value.OUT_OF_CITY)).getSingleResult();
                double shippingCharges = 0;
                for (OrderItem orderItem : order.getOrderItems()) {
                    InvoiceItemDTO itemDTO = new InvoiceItemDTO();
                    itemDTO.setItemName(orderItem.getStock().getProduct().getTitle());
                    itemDTO.setItemQty(orderItem.getQty());
                    itemDTO.setItemPrice(orderItem.getStock().getPrice());
                    itemDTOS.add(itemDTO);

                    /// Calculate shipping cost
                    User seller = orderItem.getSeller().getUser();
                    Address sellerAddress = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=true", Address.class)
                            .setParameter("user", seller)
                            .getSingleResult();
                    if (address.getCity().getName().equals(sellerAddress.getCity().getName())) {
                        shippingCharges += withinCity.getPrice();
                    } else {
                        shippingCharges += outOfCity.getPrice();
                    }
                }
                invoiceDTO.setShippingCharges(shippingCharges);
                invoiceDTO.setInvoiceItemDTOList(itemDTOS);
                invoiceDTO.setInvoiceStatus(InvoiceService.INVOICE_PAID_STATUS);

                status = true;
                responseObject.add("invoiceData", AppUtil.GSON.toJsonTree(invoiceDTO));
            }
        }
        hibernateSession.close();

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
