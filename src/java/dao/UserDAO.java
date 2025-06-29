/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import model.User;

/**
 *
 * @author Huytayto
 */
public class UserDAO {
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static User signUpUser(User user) {
        DBContext db = DBContext.getInstance();
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(
                "INSERT INTO Users (FullName, DateOfBirth, CCCD, Email, PhoneNumber, Password, Role, ProvinceID, DistrictID, WardID, AddressDetail, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getDateOfBirth());
            statement.setString(3, user.getCCCD());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getPhoneNumber());
            statement.setString(6, hashPassword(user.getPassword()));
            statement.setString(7, user.getRole());
            statement.setInt(8, user.getProvinceID());
            statement.setInt(9, user.getDistrictID());
            statement.setInt(10, user.getWardID());
            statement.setString(11, user.getAddressDetail());
            statement.setString(12, user.getStatus());

            int rs = statement.executeUpdate();
            return rs > 0 ? user : null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean isValidCCCD(String cccd) {
        return cccd.matches("\\d{12}") && !isCCCDExists(cccd);
    }

    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return Pattern.matches(emailRegex, email) && !isEmailExists(email);
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber.matches("\\d{10}") && !isPhoneNumberExists(phoneNumber);
    }

    public static boolean isPasswordConfirmed(String password, String confirmPassword) {
        return password.equals(confirmPassword);
    }

    public static boolean isEmailExists(String email) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isCCCDExists(String cccd) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Users WHERE CCCD = ?";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, cccd);
            ResultSet rs = statement.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isPhoneNumberExists(String phoneNumber) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Users WHERE PhoneNumber = ?";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, phoneNumber);
            ResultSet rs = statement.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static User getAccountByCCCD(String cccd) {
        DBContext db = DBContext.getInstance();
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(
                "SELECT FullName, DateOfBirth, CCCD, Email, PhoneNumber, Password, Role, "
                + "ProvinceID, DistrictID, WardID, AddressDetail, Status "
                + "FROM Users WHERE CCCD = ?")) {
            statement.setString(1, cccd);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<User> getPendingUsers(int wardId) {
        List<User> pendingUsers = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Users WHERE Role = 'citizen' AND Status = 'pending' AND WardID = ?";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, wardId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                pendingUsers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingUsers;
    }

    public static boolean approveUser(String cccd) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Users SET Status = 'approved' WHERE CCCD = ?";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, cccd);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi duyệt tài khoản: " + e.getMessage());
            return false;
        }
    }

    // Từ chối tài khoản dựa trên CCCD
    public static boolean rejectUser(String cccd) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Users SET Status = 'rejected' WHERE CCCD = ?";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, cccd);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi từ chối tài khoản: " + e.getMessage());
            return false;
        }
    }

    public static List<User> getChildrenByParentCCCD(String parentCCCD) {
        List<User> children = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT FullName, DateOfBirth, CCCD, Role, ProvinceID, DistrictID, WardID, AddressDetail, Status "
                + "FROM Users WHERE CCCD LIKE ? AND Role = 'citizen'";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, parentCCCD + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                User child = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        null, // Email
                        null, // PhoneNumber
                        null, // Password
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                children.add(child);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return children;
    }
    
    public static boolean updateChildInfo(User child, String oldCCCD) {
    DBContext db = DBContext.getInstance();
    String sql = "UPDATE Users SET CCCD = ?, Email = ?, PhoneNumber = ?, Password = ? WHERE CCCD = ?";
    try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
        statement.setString(1, child.getCCCD());
        statement.setString(2, child.getEmail());
        statement.setString(3, child.getPhoneNumber());
        statement.setString(4, hashPassword(child.getPassword()));
        statement.setString(5, oldCCCD); // Dùng CCCD cũ để tìm bản ghi cần cập nhật

        int rowsAffected = statement.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    
//    public static boolean updateChildInfo(User child, String oldCCCD) {
//        DBContext db = DBContext.getInstance();
//        String sql = "UPDATE Users SET FullName = ?, DateOfBirth = ?, CCCD = ?, Email = ?, PhoneNumber = ?, Password = ?, "
//                + "ProvinceID = ?, DistrictID = ?, WardID = ?, AddressDetail = ? WHERE CCCD = ?";
//        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
//            statement.setString(1, child.getFullName());
//            statement.setString(2, child.getDateOfBirth());
//            statement.setString(3, child.getCCCD());
//            statement.setString(4, child.getEmail());
//            statement.setString(5, child.getPhoneNumber());
//            statement.setString(6, hashPassword(child.getPassword()));
//            statement.setInt(7, child.getProvinceID());
//            statement.setInt(8, child.getDistrictID());
//            statement.setInt(9, child.getWardID());
//            statement.setString(10, child.getAddressDetail());
//            statement.setString(11, oldCCCD); // Dùng CCCD cũ để tìm bản ghi cần cập nhật
//
//            int rowsAffected = statement.executeUpdate();
//            return rowsAffected > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
    public static User getUserByCCCDAndPassword(String CCCD, String password) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT *
                         FROM Users
                         Where CCCD = ? AND password = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, CCCD);
            statement.setString(2, hashPassword(password));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (users.isEmpty()) return null;
        else return users.get(0);
    }
    public static ArrayList<User> getAreaLeaderByWardID(int wardID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT * 
                         FROM Users 
                         WHERE WardID = ? AND Role LIKE '%AreaLeader%';
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, wardID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (users.isEmpty()) return null;
        else return users;
    }
    
    public static User getUserByCCCD(String CCCD) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT *
                         FROM Users
                         Where CCCD = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, CCCD);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (users.isEmpty()) return null;
        else return users.get(0);
    }
    public static ArrayList<User> getUserByParentCCCD(String parentCCCD) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT * 
                         FROM Users 
                         WHERE CCCD LIKE ? + '%'
                         AND LEN(CCCD) > LEN(?);
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, parentCCCD);
            statement.setString(2, parentCCCD);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (users.isEmpty()) return null;
        else return users;
    }
    public static User getUserByUserID(int userID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT *
                         FROM Users
                         Where UserID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (users.isEmpty()) return null;
        else return users.get(0);
    }
    public static void addChildUser(String fullName, String dateOfBirth, String CCCD, int provinceID, int districtID, int wardID, String addressDetail) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         INSERT INTO Users(FullName, DateOfBirth, CCCD, Email, PhoneNumber, Password, Role, ProvinceID, DistrictID, WardID, AddressDetail, Status)
                         VALUES(?,?,?,null,null,null,'Citizen',?,?,?,?,'pending')
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setString(1, fullName);
            statment.setString(2, dateOfBirth);
            statment.setString(3, CCCD);
            statment.setInt(4, provinceID);
            statment.setInt(5, districtID);
            statment.setInt(6, wardID);
            statment.setString(7, addressDetail);
            rs = statment.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public static boolean updatePassword(String cccd, String newPassword) {
    DBContext db = DBContext.getInstance();
    String sql = "UPDATE Users SET Password = ? WHERE CCCD = ?";
    try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
        // Mã hóa mật khẩu mới bằng SHA-256
        String hashedPassword = hashPassword(newPassword);
        if (hashedPassword == null) {
            return false; // Nếu mã hóa thất bại
        }
        
        statement.setString(1, hashedPassword);
        statement.setString(2, cccd);
        int rowsAffected = statement.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Lỗi cập nhật mật khẩu: " + e.getMessage());
        return false;
    }
}
    
    
    public static ArrayList<User> getUsers() {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT  * 
                         FROM Users
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }

        if (users.isEmpty()) {
            return null;
        } else {
            return users;
        }
    }

    public static User getUserById(int userId) {
        DBContext db = DBContext.getInstance();
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         select *
                         from Users
                         where UserID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, userId);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return null;
        }
        if (users.isEmpty()) {
            return null;
        } else {
            return users.get(0);
        }
    }

    public static ArrayList<User> getUsersByName(String nameSearch) {
        DBContext db = DBContext.getInstance();
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT *
                         FROM Users
                         WHERE FullName LIKE ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            String searchPattern = "%" + nameSearch + "%";

            statment.setString(1, searchPattern);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return users;
        }
        return users;
    }

    public static ArrayList<User> getUsersByPhoneNumber(String phoneNumber) {
        DBContext db = DBContext.getInstance();
        ArrayList<User> users = new ArrayList<User>();
        try {
            String sql = """
                         SELECT *
                         FROM Users
                         WHERE PhoneNumber LIKE ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            String searchPattern = "%" + phoneNumber + "%";

            statment.setString(1, searchPattern);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("DateOfBirth"),
                        rs.getString("CCCD"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("Status")
                );
                users.add(user);
            }
        } catch (Exception e) {
            return users;
        }
        return users;
    }

    public static User deleteUser(User user) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         EXEC DeleteUser @UserID = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, user.getUserID());

            rs = statment.executeUpdate();

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return user;
        }
    }

    public static User updateUser(User user) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                              EXEC UpdateUserInfo 
                                           @UserID = ?,
                                           @FullName = ?,
                                           @DateOfBirth = ?,
                                           @CCCD = ? ,
                                           @Email = ? ,
                                           @PhoneNumber = ? ,
                                           @Password = ? ,
                                           @Role = ? ,
                                           @ProvinceID = ? ,
                                           @DistrictID = ?,
                                           @WardID = ? ,
                                           @AddressDetail = ?,
                                           @Status = ? ;
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setInt(1, user.getUserID());
            statment.setString(2, user.getFullName());
            statment.setString(3, user.getDateOfBirth());
            statment.setString(4, user.getCCCD());
            statment.setString(5, user.getEmail());
            statment.setString(6, user.getPhoneNumber());
            statment.setString(7, user.getPassword());
            statment.setString(8, user.getRole());
            statment.setInt(9, user.getProvinceID());
            statment.setInt(10, user.getDistrictID());
            statment.setInt(11, user.getWardID());
            statment.setString(12, user.getAddressDetail());
            statment.setString(13, user.getStatus());
            

            rs = statment.executeUpdate();

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return user;
        }
    }
    
    
    
    
    public static User updateEmailOrPhoneNumber(User user, String email, String phoneNumber) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                             UPDATE Users
                              SET Email = ? , PhoneNumber = ?
                              WHERE UserID = ? 
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setString(1, email);
            statment.setString(2, phoneNumber);
            statment.setInt(3, user.getUserID());
            rs = statment.executeUpdate();

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return user;
        }
    }
    
    public static User updatePassword(User user, String password) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                             UPDATE Users
                              SET  Password = ?
                              WHERE UserID = ? 
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setString(1, password);
            
            statment.setInt(2, user.getUserID());
            rs = statment.executeUpdate();

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return user;
        }
    }
    public static void addHighUser(String fullName,String CCCD, String password, String role, int proviceID, int districtID, int wardID, String addressDetail) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                             INSERT INTO Users(FullName,DateOfBirth,CCCD,Password,Role,ProvinceID,DistrictID,WardID,AddressDetail,Status)
                              VALUES(?,'1111-11-11',?,?,?,?,?,?,?,'approved')
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setString(1, fullName);
            statment.setString(2, CCCD);
            statment.setString(3, hashPassword(password));
            statment.setString(4, role);
            statment.setInt(5, proviceID);
            statment.setInt(6, districtID);
            statment.setInt(7, wardID);
            statment.setString(8, addressDetail);
            rs = statment.executeUpdate();

        } catch (Exception e) {
        }
    }
}
