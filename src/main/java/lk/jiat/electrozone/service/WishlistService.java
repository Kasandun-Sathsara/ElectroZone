package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lk.jiat.ElectroZone.dto.WishlistDTO;
import lk.jiat.ElectroZone.entity.*;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;

public class WishlistService {

    public String addToWishlist(String stockIdStr, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            User sessionUser = (User) httpSession.getAttribute("user");
            
            try {
                int stockId = Integer.parseInt(stockIdStr);
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                Stock stock = hibernateSession.get(Stock.class, stockId);
                
                if (stock != null) {
                    Product product = stock.getProduct();

                    List<Wishlist> existing = hibernateSession.createQuery("FROM Wishlist w WHERE w.user=:user AND w.product=:product", Wishlist.class)
                            .setParameter("user", sessionUser)
                            .setParameter("product", product)
                            .getResultList();
                            
                    if (existing.isEmpty()) {
                        Transaction transaction = hibernateSession.beginTransaction();
                        try {
                            Wishlist wishlist = new Wishlist(sessionUser, product);
                            hibernateSession.persist(wishlist);
                            transaction.commit();
                            status = true;
                            message = "Product added to wishlist";
                        } catch (HibernateException e) {
                            if (transaction != null) transaction.rollback();
                            message = "Failed to add to wishlist";
                        }
                    } else {
                        status = true;
                        message = "Product is already in wishlist";
                    }
                } else {
                    message = "Product not found";
                }
                hibernateSession.close();
            } catch (Exception e) {
                message = "Invalid stock ID";
            }
        } else {
            message = "Please login first";
            responseObject.addProperty("status_code", 401);
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String loadWishlist(HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            User sessionUser = (User) httpSession.getAttribute("user");
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            
            List<Wishlist> wishlistItems = hibernateSession.createQuery("FROM Wishlist w WHERE w.user=:user", Wishlist.class)
                    .setParameter("user", sessionUser)
                    .getResultList();
                    
            List<WishlistDTO> dtoList = new ArrayList<>();
            for (Wishlist w : wishlistItems) {
                WishlistDTO dto = new WishlistDTO();
                dto.setId(w.getId());
                dto.setProductTitle(w.getProduct().getTitle());

                List<Stock> stocks = hibernateSession.createQuery("FROM Stock s WHERE s.product=:product AND s.qty > 0 ORDER BY s.price ASC", Stock.class)
                        .setParameter("product", w.getProduct())
                        .setMaxResults(1)
                        .getResultList();
                        
                if (!stocks.isEmpty()) {
                    dto.setStockId(stocks.get(0).getId());
                    dto.setCurrentPrice(stocks.get(0).getPrice());
                } else {
                    dto.setStockId(0);
                    dto.setCurrentPrice(0);
                }

                List<String> imagePaths = new ArrayList<>();
                List<ProductImage> pImages = hibernateSession.createQuery("FROM ProductImage p WHERE p.product=:product", ProductImage.class)
                        .setParameter("product", w.getProduct())
                        .setMaxResults(1)
                        .getResultList();
                if (!pImages.isEmpty()) {
                    imagePaths.add(pImages.get(0).getImageUrl());
                } else {
                    imagePaths.add("assets/img/default-product.png");
                }
                dto.setImages(imagePaths);
                
                dtoList.add(dto);
            }
            
            responseObject.add("wishlistItems", AppUtil.GSON.toJsonTree(dtoList));
            status = true;
            message = "Wishlist loaded successfully";
            hibernateSession.close();
        } else {
            message = "Please login first";
            responseObject.addProperty("status_code", 401);
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String removeWishlist(String idStr, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            try {
                Long id = Long.parseLong(idStr);
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                Wishlist wishlist = hibernateSession.get(Wishlist.class, id);
                
                if (wishlist != null) {
                    Transaction transaction = hibernateSession.beginTransaction();
                    try {
                        hibernateSession.remove(wishlist);
                        transaction.commit();
                        status = true;
                        message = "Removed from wishlist";
                    } catch (HibernateException e) {
                        if (transaction != null) transaction.rollback();
                        message = "Failed to remove from wishlist";
                    }
                } else {
                    message = "Item not found";
                }
                hibernateSession.close();
            } catch (Exception e) {
                message = "Invalid ID";
            }
        } else {
            message = "Please login first";
            responseObject.addProperty("status_code", 401);
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
    
    public String clearWishlist(HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";
        
        HttpSession httpSession = request.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            User sessionUser = (User) httpSession.getAttribute("user");
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Transaction transaction = hibernateSession.beginTransaction();
            try {
                int deleted = hibernateSession.createQuery("DELETE FROM Wishlist w WHERE w.user=:user")
                        .setParameter("user", sessionUser)
                        .executeUpdate();
                transaction.commit();
                status = true;
                message = "Wishlist cleared successfully";
            } catch (HibernateException e) {
                if (transaction != null) transaction.rollback();
                message = "Failed to clear wishlist";
            }
            hibernateSession.close();
        } else {
            message = "Please login first";
            responseObject.addProperty("status_code", 401);
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }
}
