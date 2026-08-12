package lk.jiat.ElectroZone;

public class Main {
    public static void main(String[] args) {
        System.out.println("ElectroZone Backend initialized.");
        try {
            lk.jiat.ElectroZone.util.HibernateUtil.getSessionFactory();
            System.out.println("Hibernate Initialized Successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
