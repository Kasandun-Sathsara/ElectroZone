<%@ page import="lk.jiat.ElectroZone.entity.*, lk.jiat.ElectroZone.util.HibernateUtil, org.hibernate.Session, java.util.List" %>
<%
    try (Session s = HibernateUtil.getSessionFactory().openSession()) {
        List<Product> products = s.createQuery("FROM Product p", Product.class).getResultList();
        for (Product p : products) {
            out.println("Product: " + p.getId() + " - " + p.getTitle() + "<br>");
            out.println("ElementCollection images: " + p.getImages() + "<br>");
            List<ProductImage> pi = s.createQuery("FROM ProductImage p WHERE p.product=:p", ProductImage.class).setParameter("p", p).getResultList();
            out.println("ProductImage entities: ");
            for(ProductImage pimg : pi) {
                out.print(pimg.getImageUrl() + ", ");
            }
            out.println("<hr>");
        }
    }
%>
