package util;


import java.sql.Connection;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        System.out.println("🔄 Testing database connection...");

  
        Connection conn = SingletonConnex.getConnection();

        if (conn != null) {
            System.out.println("✅ Connection to MySQL successful!");

            try {
                if (conn.isValid(2)) {
                    System.out.println("✅ Connection is valid!");
                } else {
                    System.out.println("❌ Connection is not valid!");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        } else {
            System.out.println("❌ Failed to connect to MySQL.");
        }

     
        SingletonConnex.closeConnection();
    }
}