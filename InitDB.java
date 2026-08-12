import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class InitDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electrozone_db", "root", "kasandun@2005");
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("ALTER TABLE users MODIFY COLUMN password VARCHAR(255) NOT NULL");
            System.out.println("Column updated successfully.");
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
