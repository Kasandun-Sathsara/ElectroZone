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
}
