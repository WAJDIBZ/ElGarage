package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SingletonConnex {
    private static Connection connection;


    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";


    private static final String DB_URL = "jdbc:mysql://localhost:3306/gestion_location";

   
    static {
        try {
            Class.forName(DRIVER); 
            connection = DriverManager.getConnection(DB_URL, "root",""); 
            System.out.println("✅ Connected to: " + DB_URL);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Error connecting to the database!");
        }
    }


    public static Connection getConnection() {
        return connection;
    }


    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                connection = null; 
                System.out.println("✅ Database Connection Closed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
