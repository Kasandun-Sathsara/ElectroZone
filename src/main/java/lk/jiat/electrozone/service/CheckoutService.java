package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.constraints.NotNull;
import lk.jiat.ElectroZone.dto.*;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.Env;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.util.PayHereUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;

public class CheckoutService {
    private final OrderService orderService = new OrderService();

    public String processCheckout(CheckoutRequestDTO requestDTO, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            message = "Session expired. Please login again and try!";
        } else {
            User dbUser = hibernateSession.find(User.class, sessionUser.getId());
            if (requestDTO.isCurrentAddress()) {
                Address address = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=:primary", Address.class)
                        .setParameter("user", dbUser)
                        .setParameter("primary", requestDTO.isCurrentAddress())
                        .getSingleResultOrNull();
                if (address == null) {
                    message = "Address not found. Please check again!";
                } else {
                    // Order pending method call here
                    Order pendingOrder = orderService.createPendingOrder(dbUser, hibernateSession);
                    PayHereDTO paymentDetails = createPaymentDetails(hibernateSession, pendingOrder);
                    responseObject.add("paymentDetails",AppUtil.GSON.toJsonTree(paymentDetails));
                    status = true;
                }
            } else {
                if (requestDTO.getFirstName().isBlank()) {
                    message = "First Name is required!";
                } else if (requestDTO.getLastName().isBlank()) {
                    message = "Last Name is required!";
                } else if (requestDTO.getCityId() == AppUtil.DEFAULT_SELECTOR_VALUE) {
                    message = "Please select a city!";
                } else if (requestDTO.getLineOne().isBlank()) {
                    message = "Address line one is required!";
                } else if (requestDTO.getPostalCode().isBlank()) {
                    message = "Postal code is required!";
                } else if (!requestDTO.getPostalCode().matches(Validator.POSTAL_CODE_VALIDATION)) {
                    message = "Enter a valid postal code!";
                } else if (requestDTO.getMobile().isBlank()) {
                    message = "Mobile number is required!";
                } else if (!requestDTO.getMobile().matches(Validator.MOBILE_VALIDATION)) {
                    message = "Enter a valid mobile number!";
                } else {
                    City city = hibernateSession.find(City.class, requestDTO.getCityId());
                    if (city == null) {
                        message = "City not found. Select correct city!";
                    } else {
                        Address existingPrimary = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=:primary", Address.class)
                                .setParameter("user", dbUser)
                                .setParameter("primary", true)
                                .getSingleResultOrNull();
                        if (existingPrimary != null) { // primary address already exists.
                            existingPrimary.setPrimary(false);
                            hibernateSession.merge(existingPrimary);
                        }
                        Address address = new Address();
                        address.setPrimary(true);
                        address.setLineOne(requestDTO.getLineOne());
                        address.setLineTwo(requestDTO.getLineTwo());
                        address.setPostalCode(requestDTO.getPostalCode());
                        address.setMobile(requestDTO.getMobile());
                        address.setCity(city);
                        address.setUser(dbUser);
                        hibernateSession.persist(address);
                        // Order pending method call here
                        Order pendingOrder = orderService.createPendingOrder(dbUser, hibernateSession);
                        PayHereDTO paymentDetails = createPaymentDetails(hibernateSession, pendingOrder);
                        responseObject.add("paymentDetails",AppUtil.GSON.toJsonTree(paymentDetails));
                        status = true;
                    }
                }
            }
        }
        hibernateSession.beginTransaction().commit();
        hibernateSession.close();

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    private PayHereDTO createPaymentDetails(Session hibernateSession, Order o) {
        String orderId = "000" + o.getId();
        String returnURL = Env.get("app.public.url") + "/api/payments/return";
        String cancelURL = Env.get("app.public.url") + "/api/payments/cancel";
        String notifyURL = Env.get("app.public.url") + "/api/payments/notify";

        Order order = hibernateSession.find(Order.class, o.getId());
        User user = hibernateSession.find(User.class, order.getUser().getId());
        Address address = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=:primary", Address.class)
                .setParameter("user", user)
                .setParameter("primary", true)
                .getSingleResult();

        StringBuilder userAddress = new StringBuilder(address.getLineOne());
        if (!address.getLineTwo().isBlank()) {
            userAddress.append(",").append(address.getLineTwo());
        }

        StringBuilder items = new StringBuilder();
        double amount = 0;
        List<OrderItem> orderItems = hibernateSession.createQuery("FROM OrderItem oi WHERE oi.order=:order", OrderItem.class)
                .setParameter("order", order)
                .getResultList();

        DeliveryType withinCity = hibernateSession.createNamedQuery("DeliveryType.findByName", DeliveryType.class)
                .setParameter("name", String.valueOf(DeliveryType.Value.WITHIN_CITY)).setMaxResults(1).getSingleResult();
        DeliveryType outOfCity = hibernateSession.createNamedQuery("DeliveryType.findByName", DeliveryType.class)
                .setParameter("name", String.valueOf(DeliveryType.Value.OUT_OF_CITY)).setMaxResults(1).getSingleResult();

        for (OrderItem orderItem : orderItems) {
            if (items.length() > 0) {
                items.append(",");
            }
            items.append(orderItem.getStock().getProduct().getTitle())
                    .append(" x ")
                    .append(orderItem.getQty());
            amount += orderItem.getStock().getPrice() * orderItem.getQty();
            User seller = null;
            if (orderItem.getSeller() != null) {
                seller = orderItem.getSeller().getUser();
            } else if (orderItem.getStock() != null && orderItem.getStock().getProduct() != null && orderItem.getStock().getProduct().getSeller() != null) {
                seller = orderItem.getStock().getProduct().getSeller().getUser();
            }

            if (seller != null) {
                Address sellerAddress = hibernateSession.createQuery("FROM Address a WHERE a.user=:user AND a.isPrimary=true", Address.class)
                        .setParameter("user", seller)
                        .setMaxResults(1)
                        .getSingleResultOrNull();
                if (sellerAddress != null) {
                    if (address.getCity().getName().equals(sellerAddress.getCity().getName())) {
                        amount += withinCity.getPrice();
                    } else {
                        amount += outOfCity.getPrice();
                    }
                } else {
                    amount += withinCity.getPrice(); // fallback
                }
            } else {
                amount += withinCity.getPrice(); // fallback
            }
        }
//
        String hashValue = PayHereUtil.generateHash(orderId, amount);
        PayHereDTO payHereDTO = new PayHereDTO();
        payHereDTO.setSandbox(true);
        payHereDTO.setMerchant_id(PayHereUtil.getMerchantId());
        payHereDTO.setReturn_url(returnURL);
        payHereDTO.setCancel_url(cancelURL);
        payHereDTO.setNotify_url(notifyURL);
        payHereDTO.setOrder_id(orderId);
        payHereDTO.setItems(items.toString());
        payHereDTO.setAmount(String.valueOf(amount));
        payHereDTO.setCurrency(PayHereUtil.APP_CURRENCY);
        payHereDTO.setHash(hashValue);
        payHereDTO.setFirst_name(user.getFirstName());
        payHereDTO.setLast_name(user.getLastName());
        payHereDTO.setEmail(user.getEmail());
        payHereDTO.setPhone(address.getMobile());
        payHereDTO.setAddress(userAddress.toString());
        payHereDTO.setCity(address.getCity().getName());
        payHereDTO.setCountry(PayHereUtil.APP_COUNTRY);
        return payHereDTO;
    }

    public String getCheckoutData(HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            message = "Please login first!";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Address primaryAddress = hibernateSession.createQuery("FROM Address a WHERE a.user.id=:userId AND a.isPrimary=:primary", Address.class)
                    .setParameter("userId", sessionUser.getId())
                    .setParameter("primary", true)
                    .setMaxResults(1)
                    .getSingleResultOrNull();
                    
            if (primaryAddress != null) {
                AddressDTO addressDTO = getAddressDTO(primaryAddress);
                responseObject.add("userPrimaryAddress", AppUtil.GSON.toJsonTree(addressDTO));
            }
            
            List<Cart> cartList = hibernateSession.createQuery("FROM Cart c WHERE c.user.id=:userId", Cart.class)
                    .setParameter("userId", sessionUser.getId())
                    .getResultList();
                    
            if (cartList.isEmpty()) {
                message = "Your cart is empty. Please add items first!";
            } else {
                List<CartDTO> cartDTOList = new CartService().generateCartDTOs(cartList);
                List<SellerDTO> sellerDTOList = new ArrayList<>();
                for (Cart c : cartList) {
                    SellerDTO sellerDTO = getSellerDTO(c);
                    sellerDTOList.add(sellerDTO);
                }
                List<DeliveryTypeDTO> deliveryTypeDTOList = new ArrayList<>();
                List<DeliveryType> deliveryTypeList = hibernateSession.createQuery("FROM DeliveryType d", DeliveryType.class).getResultList();
                for (DeliveryType deliveryType : deliveryTypeList) {
                    DeliveryTypeDTO typeDTO = new DeliveryTypeDTO();
                    typeDTO.setId(deliveryType.getId());
                    typeDTO.setName(deliveryType.getName());
                    typeDTO.setPrice(deliveryType.getPrice());
                    deliveryTypeDTOList.add(typeDTO);
                }
                status = true;
                responseObject.add("cartList", AppUtil.GSON.toJsonTree(cartDTOList));
                responseObject.add("sellerList", AppUtil.GSON.toJsonTree(sellerDTOList));
                responseObject.add("deliveryTypes", AppUtil.GSON.toJsonTree(deliveryTypeDTOList));
            }
            hibernateSession.close();
        }


        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    private SellerDTO getSellerDTO(Cart c) {
        Seller seller = c.getStock().getProduct().getSeller();
        SellerDTO sellerDTO = new SellerDTO();
        sellerDTO.setId(0);

        CityDTO cityDTO = new CityDTO();
        if (seller != null && seller.getUser() != null) {
            sellerDTO.setFirstName(seller.getUser().getFirstName());
            sellerDTO.setLastName(seller.getUser().getLastName());

            boolean hasPrimary = false;
            if (seller.getUser().getAddresses() != null) {
                for (Address address : seller.getUser().getAddresses()) {
                    if (address.isPrimary()) {
                        cityDTO.setId(address.getCity().getId());
                        cityDTO.setName(address.getCity().getName());
                        hasPrimary = true;
                        break;
                    }
                }
            }
            if (hasPrimary) {
                sellerDTO.setCityDTO(cityDTO);
            }
        } else {
            sellerDTO.setFirstName("Unknown");
            sellerDTO.setLastName("Seller");
        }
        
        return sellerDTO;
    }

    private AddressDTO getAddressDTO(Address primaryAddress) {
        AddressDTO addressDTO = new AddressDTO();
        addressDTO.setId(primaryAddress.getId());
        addressDTO.setFirstName(primaryAddress.getUser().getFirstName());
        addressDTO.setLastName(primaryAddress.getUser().getLastName());
        addressDTO.setLineOne(primaryAddress.getLineOne());
        addressDTO.setLineTwo(primaryAddress.getLineTwo());
        addressDTO.setPostalCode(primaryAddress.getPostalCode());
        addressDTO.setMobile(primaryAddress.getMobile());
        addressDTO.setPrimary(primaryAddress.isPrimary());
        CityDTO cityDTO = new CityDTO();
        cityDTO.setId(primaryAddress.getCity().getId());
        cityDTO.setName(primaryAddress.getCity().getName());
        addressDTO.setCityDTO(cityDTO);
        return addressDTO;
    }
}
