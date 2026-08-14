<%@ page import="lk.jiat.ElectroZone.util.HibernateUtil" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%
    Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
    Transaction tx = hibernateSession.beginTransaction();
    try {
        hibernateSession.createNativeQuery("SET FOREIGN_KEY_CHECKS = 0").executeUpdate();
        
        String[] tables = {
            "wishlist",
            "product_images_list",
            "product_images",
            "product_image_entities",
            "cart",
            "order_items",
            "stock",
            "product"
        };
        
        for (String t : tables) {
            try {
                hibernateSession.createNativeQuery("TRUNCATE TABLE " + t).executeUpdate();
            } catch (Exception ignored) {
                try {
                    hibernateSession.createNativeQuery("DELETE FROM " + t).executeUpdate();
                } catch (Exception ignored2) {}
            }
        }
        
        hibernateSession.createNativeQuery("SET FOREIGN_KEY_CHECKS = 1").executeUpdate();
        tx.commit();
        out.println("<div style='font-family:sans-serif;padding:30px;'><h2 style='color:#16a34a;'>All Products & Stocks Data Cleared Successfully! 🎉</h2><p><a href='admin/products.jsp'>Go to Admin Products</a></p></div>");
    } catch(Exception e) {
        if(tx != null && tx.isActive()) tx.rollback();
        out.println("<h2 style='color:red;font-family:sans-serif;'>Error: " + e.getMessage() + "</h2>");
    } finally {
        hibernateSession.close();
    }
%>
