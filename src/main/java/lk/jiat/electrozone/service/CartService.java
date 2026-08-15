package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lk.jiat.ElectroZone.dto.CartDTO;
import lk.jiat.ElectroZone.entity.Cart;
import lk.jiat.ElectroZone.entity.Stock;
import lk.jiat.ElectroZone.entity.User;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;

public class CartService {

    public String deleteCartItem(String cartId, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        if (cartId == null || cartId.isBlank()) {
            message = "Invalid ID format!";
        } else if (!cartId.matches(Validator.IS_INTEGER)) {
            message = "Invalid ID format!";
        } else {
            int cId = Integer.parseInt(cartId);
            HttpSession httpSession = request.getSession();
            User sessionUser = (User) httpSession.getAttribute("user");
            if (sessionUser == null) {

                List<Cart> sessionCart = getSessionAttribute(httpSession);
                if (sessionCart != null && !sessionCart.isEmpty()) {
                    sessionCart.removeIf(cart -> cart.getId() == cId);
                    httpSession.setAttribute("sessionCart", sessionCart);
                    status = true;
                    message = "Cart item deleted";
                }
            } else {

                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                Cart existingCart = hibernateSession.createQuery("FROM Cart c WHERE c.id=:cartId AND c.user.id=:userId", Cart.class)
                        .setParameter("cartId", cId)
                        .setParameter("userId", sessionUser.getId())
                        .getSingleResultOrNull();
                if (existingCart == null) {
                    message = "Cart item not found!";
                } else {
                    Transaction transaction = hibernateSession.beginTransaction();
                    try {
                        hibernateSession.remove(existingCart);
                        transaction.commit();
                        status = true;
                        message = "Cart item deleted";
                    } catch (HibernateException e) {
                        transaction.rollback();
                    }
                }
                hibernateSession.close();
            }
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String getAllUserCarts(HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        HttpSession httpSession = request.getSession();
        User sessionUser = (User) httpSession.getAttribute("user");
        if (sessionUser == null) {

            List<Cart> sessionCart = getSessionAttribute(httpSession);
            if (sessionCart == null) {
                message = "Your cart is empty!";
            } else if (sessionCart.isEmpty()) {
                message = "Your cart is empty!";
            } else {

                List<CartDTO> cartDTOList = generateCartDTOs(sessionCart);
                responseObject.add("cartItems", AppUtil.GSON.toJsonTree(cartDTOList));
                status = true;
                message = "Cart items loading success";
            }
        } else {

            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            List<Cart> cartList = hibernateSession.createQuery("FROM Cart c WHERE c.user.id=:id", Cart.class)
                    .setParameter("id", sessionUser.getId())
                    .getResultList();
            if (cartList.isEmpty()) {
                message = "Your cart is empty";
            } else {

                List<CartDTO> cartDTOList = generateCartDTOs(cartList);
                responseObject.add("cartItems", AppUtil.GSON.toJsonTree(cartDTOList));
                status = true;
                message = "Cart items loading success";
            }
            hibernateSession.close();
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public List<CartDTO> generateCartDTOs(List<Cart> cartList) {
        List<CartDTO> cartDTOList = new ArrayList<>();
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        for (Cart cart : cartList) {
            Stock stock = hibernateSession.find(Stock.class, cart.getStock().getId());

            CartDTO cartDTO = new CartDTO();
            cartDTO.setCartId(cart.getId());
            cartDTO.setStockId(stock.getId());
            cartDTO.setProductTitle(stock.getProduct().getTitle());

            List<String> imagePaths = new ArrayList<>();
            List<lk.jiat.ElectroZone.entity.ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", lk.jiat.ElectroZone.entity.ProductImage.class)
                    .setParameter("product", stock.getProduct())
                    .setMaxResults(1)
                    .getResultList();
            if (!pImages.isEmpty()) {
                imagePaths.add(pImages.get(0).getImageUrl());
            } else {
                imagePaths.add("assets/img/default-product.png");
            }
            cartDTO.setImages(imagePaths);

            cartDTO.setQty(cart.getQty());
            cartDTO.setPrice(stock.getPrice());
            cartDTOList.add(cartDTO);
        }
        hibernateSession.close();
        return cartDTOList;
    }

    public void mergeUserCarts(HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        User sessionUser = (User) httpSession.getAttribute("user");
        if (sessionUser != null) {
            List<Cart> sessionCart = getSessionAttribute(httpSession);
            if (sessionCart != null && !sessionCart.isEmpty()) {
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                User dbUser = hibernateSession.find(User.class, sessionUser.getId());
                Transaction transaction = hibernateSession.beginTransaction();
                for (Cart cart : sessionCart) {
                    Stock stock = hibernateSession.find(Stock.class, cart.getStock().getId());
                    Cart existingCart = hibernateSession.createQuery("FROM Cart c WHERE c.user=:user AND c.stock=:stock", Cart.class)
                            .setParameter("user", dbUser)
                            .setParameter("stock", stock)
                            .getSingleResultOrNull();
                    if (existingCart == null) {
                        existingCart = new Cart(); 
                        existingCart.setQty(cart.getQty());
                        existingCart.setUser(dbUser);
                        existingCart.setStock(stock);
                        hibernateSession.persist(existingCart);
                    } else {
                        int newQty = existingCart.getQty() + cart.getQty();
                        if (newQty <= stock.getQty()) {
                            existingCart.setQty(newQty);
                            hibernateSession.merge(existingCart);
                        }
                    }
                }
                transaction.commit();
                hibernateSession.close();
            }
            httpSession.setAttribute("sessionCart", null);
        }
    }

    public String addToCart(String sId, String qty, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        if (sId == null || sId.isBlank()) {
            message = "Product ID not found!";
        } else if (!sId.matches(Validator.IS_INTEGER)) {
            message = "Invalid product Id!";
        } else if (qty == null || qty.isBlank()) {
            message = "Product quantity not found!";
        } else if (!qty.matches(Validator.IS_INTEGER)) {
            message = "Invalid quantity value!";
        } else {
            int stockId = Integer.parseInt(sId);
            int requestQty = Integer.parseInt(qty);
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            try {
                Stock stock = hibernateSession.find(Stock.class, stockId);
                if (stock == null) {
                    message = "Product not found!";
                } else if (stock.getQty() <= 0) {
                    message = "This product is currently out of stock and cannot be added to cart!";
                } else {

                    HttpSession httpSession = request.getSession();
                    User user = (User) httpSession.getAttribute("user");
                    List<Cart> sessionCart = getSessionAttribute(httpSession);
                    if (user == null) {

                        if (sessionCart == null) {

                            return guestUserFirstTime(stock, requestQty, httpSession);
                        } else {

                            return guestUserSecondTime(stock, requestQty, httpSession);
                        }
                    } else {

                        return loggedUserCart(stock, requestQty, httpSession, hibernateSession);
                    }
                }
            } finally {
                if (hibernateSession != null && hibernateSession.isOpen()) {
                    hibernateSession.close();
                }
            }
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    private String loggedUserCart(Stock stock, int requestQty, HttpSession httpSession, Session hibernateSession) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        User sessionUser = (User) httpSession.getAttribute("user");
        if (sessionUser != null) {
            User dbUser = hibernateSession.find(User.class, sessionUser.getId());
            Cart existingCart = hibernateSession.createQuery("FROM Cart c WHERE c.user=:user AND c.stock=:stock", Cart.class)
                    .setParameter("user", dbUser)
                    .setParameter("stock", stock)
                    .getSingleResultOrNull();
            Transaction transaction = hibernateSession.beginTransaction();
            if (existingCart == null) {

                existingCart = new Cart();
                existingCart.setUser(dbUser);
                existingCart.setStock(stock);
                existingCart.setQty(requestQty);
                hibernateSession.persist(existingCart);
                status = true;
                message = "Product add to cart";
            } else {

                int newQty = existingCart.getQty() + requestQty;
                if (newQty > stock.getQty()) {
                    message = "Product quantity exceeded!";
                } else {
                    existingCart.setQty(newQty);
                    hibernateSession.merge(existingCart);
                    status = true;
                    message = "User cart updated";
                }
            }
            transaction.commit();
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    private String guestUserSecondTime(Stock stock, int requestQty, HttpSession httpSession) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        List<Cart> sessionCart = getSessionAttribute(httpSession);
        boolean found = false;
        Cart cart = null;
        for (Cart c : sessionCart) {
            if (c.getStock().getId() == stock.getId()) {
                found = true;
                cart = c;
                break;
            }
        }
        if (found) { 
            int newQty = cart.getQty() + requestQty;
            if (newQty > stock.getQty()) {
                message = "Product quantity exceeded!";
            } else {
                cart.setQty(newQty);
                status = true;
                message = "User cart updated!";
            }
        } else {
            cart = new Cart();
            cart.setId(sessionCart.size() + 1);
            cart.setStock(stock);
            cart.setQty(requestQty);
            cart.setUser(null);
            sessionCart.add(cart);
            httpSession.setAttribute("sessionCart", sessionCart);
            status = true;
            message = "Product add to the cart";
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    private String guestUserFirstTime(Stock stock, int requestQty, HttpSession httpSession) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        if (requestQty > stock.getQty()) {
            message = "Product quantity exceeded!";
        } else {
            List<Cart> cartList = new ArrayList<>();
            Cart cart = new Cart();
            cart.setId(1);
            cart.setStock(stock);
            cart.setQty(requestQty);
            cart.setUser(null);
            cartList.add(cart);
            httpSession.setAttribute("sessionCart", cartList);
            status = true;
            message = "Product add to the cart";
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    @SuppressWarnings("unchecked")
    private <T> T getSessionAttribute(HttpSession httpSession) {
        return (T) httpSession.getAttribute("sessionCart");
    }
}
