package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=quiz_practicing_system;encrypt=true;trustServerCertificate=true";
        String username = "sa";
        String password = "123";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error: " + ex.toString());
        }
    }
}