package lk.jiat.ElectroZone.controller.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.entity.City;
import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

@Path("/seed")
public class SeedController {
    @GET
    @Path("/cities")
    public Response seedCities() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            String[] cities = {"Colombo", "Kandy", "Galle", "Kurunegala", "Gampaha", "Matara", "Jaffna", "Negombo", "Anuradhapura", "Ratnapura", "Badulla", "Matale", "Kalutara", "Nuwara Eliya", "Batticaloa", "Trincomalee", "Ampara", "Puttalam", "Polonnaruwa", "Moneragala", "Kegalle", "Vavuniya", "Mannar", "Kilinochchi", "Mullaitivu"};
            for (String cityName : cities) {
                City city = new City();
                city.setName(cityName);
                session.persist(city);
            }
            transaction.commit();
            return Response.ok("Cities seeded").build();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            return Response.serverError().entity(e.getMessage()).build();
        } finally {
            session.close();
        }
    }

    @GET
    @Path("/delivery")
    public Response seedDeliveryTypes() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            lk.jiat.ElectroZone.entity.DeliveryType withinCity = new lk.jiat.ElectroZone.entity.DeliveryType();
            withinCity.setName(lk.jiat.ElectroZone.entity.DeliveryType.Value.WITHIN_CITY.name());
            withinCity.setPrice(500.0);
            session.persist(withinCity);

            lk.jiat.ElectroZone.entity.DeliveryType outOfCity = new lk.jiat.ElectroZone.entity.DeliveryType();
            outOfCity.setName(lk.jiat.ElectroZone.entity.DeliveryType.Value.OUT_OF_CITY.name());
            outOfCity.setPrice(1000.0);
            session.persist(outOfCity);

            transaction.commit();
            return Response.ok("Delivery types seeded").build();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            return Response.serverError().entity(e.getMessage()).build();
        } finally {
            session.close();
        }
    }
    
    @GET
    @Path("/fix-images")
    public Response fixImages() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            java.util.List<lk.jiat.ElectroZone.entity.ProductImage> images = session.createQuery("FROM ProductImage WHERE imageUrl LIKE 'roduct_uploads%'", lk.jiat.ElectroZone.entity.ProductImage.class).getResultList();
            int count = 0;
            for (lk.jiat.ElectroZone.entity.ProductImage pi : images) {
                pi.setImageUrl("p" + pi.getImageUrl());
                session.merge(pi);
                count++;
            }
            transaction.commit();
            return Response.ok("Fixed " + count + " images").build();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            return Response.serverError().entity(e.getMessage()).build();
        } finally {
            session.close();
        }
    }
}
