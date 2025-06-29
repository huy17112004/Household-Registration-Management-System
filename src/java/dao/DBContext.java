/**
 *
 * @author Huytayto
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext { // singletone pattern
//    private static DBContext instance = new DBContext();
//    Connection connection;
//    
//    public static DBContext getInstance() {
//        return instance;
//    }
//
//    public Connection getConnection() {
//        return connection;
//    }
//    
//    private DBContext() {
//        try {
//            if (connection == null || connection.isClosed()) {
//                String user = "sa";
//                String password = "123";
//                String url = "jdbc:sqlserver://localhost:1433;databaseName=ASSPRJ";
//                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//                connection = DriverManager.getConnection(url, user, password);
//            }
//        } catch (Exception e) {
//            connection = null;
//        }
//    }
    
    private static DBContext instance = new DBContext();
    private String user = "sa";
    private String password = "123";
    private String url = "jdbc:sqlserver://localhost:1433;databaseName=ASSPRJ";

    public static DBContext getInstance() {
        return instance;
    }

    // Không lưu connection như một biến instance
    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, user, password);
            System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
            return connection;
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy driver JDBC: " + e.getMessage());
            throw new SQLException("Không tìm thấy driver JDBC", e);
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
            throw e;
        }
    }

    private DBContext() {
        // Constructor rỗng, không khởi tạo kết nối ở đây
    }
}
