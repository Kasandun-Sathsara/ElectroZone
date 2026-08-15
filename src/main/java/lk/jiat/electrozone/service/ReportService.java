package lk.jiat.ElectroZone.service;

import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.Session;
import java.util.HashMap;
import java.util.Map;

public class ReportService {

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            Double revenue = session.createQuery("SELECT SUM(total) FROM Order WHERE status = 'DELIVERED'", Double.class).uniqueResult();
            stats.put("totalRevenue", revenue != null ? revenue : 0.0);

            Long orders = session.createQuery("SELECT COUNT(o) FROM Order o", Long.class).uniqueResult();
            stats.put("totalOrders", orders != null ? orders : 0L);

            Long products = session.createQuery("SELECT COUNT(p) FROM Product p", Long.class).uniqueResult();
            stats.put("totalProducts", products != null ? products : 0L);

            Long customers = session.createQuery("SELECT COUNT(u) FROM User u WHERE role = 'USER'", Long.class).uniqueResult();
            stats.put("totalCustomers", customers != null ? customers : 0L);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}
