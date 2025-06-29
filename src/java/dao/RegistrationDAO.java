/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.stream.Collectors;
import model.Registration;
import model.User;

/**
 *
 * @author Huytayto
 */
public class RegistrationDAO {

    public static void addRegistration(int userID,String registrationType, int householdID, String startDate,String endDate, int approveBy, String comment, String relationship) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO Registrations (UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship) 
            VALUES (?, ?, ?, ?, ?, 'Pending', ?, ?, ?);
        """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setString(2, registrationType);
            if (householdID != 0) {
                ps.setInt(3, householdID);
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setString(4, startDate);
            ps.setString(5, endDate);
            ps.setInt(6, approveBy);
            ps.setString(7, comment);
            ps.setString(8, relationship);
            ps.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void updateStatusRegistrationByRegistrationID(int registrationID,String status) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE Registrations
            SET Status=?
            WHERE RegistrationID = ?
        """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, registrationID);
            ps.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Registration getLatestRegistrationByUserID(int userID) {
        DBContext db = DBContext.getInstance();
        Registration registration = null;

        String sql = """
        SELECT TOP 1 RegistrationID, RegistrationCode, UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship
        FROM Registrations 
        WHERE UserID = ?
        ORDER BY RegistrationID DESC;
    """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    registration = new Registration(
                            rs.getInt("RegistrationID"),
                            rs.getString("RegistrationCode"),
                            rs.getInt("UserID"),
                            rs.getString("RegistrationType"),
                            rs.getInt("HouseholdID"),
                            rs.getString("StartDate"),
                            rs.getString("EndDate"),
                            rs.getString("Status"),
                            rs.getInt("ApprovedBy"),
                            rs.getString("Comments"),
                            rs.getString("Relationship")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registration;
    }
    
    public static ArrayList<Registration> getRegistrationForAreaLeader(int areaLeaderID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();

        String sql = """
            SELECT * FROM Registrations
            WHERE ApprovedBy = ? AND Status='Pending'
            ORDER BY RegistrationID DESC
        """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, areaLeaderID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Registration registration = new Registration(
                            rs.getInt("RegistrationID"),
                            rs.getString("RegistrationCode"),
                            rs.getInt("UserID"),
                            rs.getString("RegistrationType"),
                            rs.getInt("HouseholdID"),
                            rs.getString("StartDate"),
                            rs.getString("EndDate"),
                            rs.getString("Status"),
                            rs.getInt("ApprovedBy"),
                            rs.getString("Comments"),
                            rs.getString("Relationship")
                    );
                    registrations.add(registration);
                }
            }
        } catch (Exception e) {
            return null;
        }
        if (registrations.isEmpty()) return null;
        else return registrations;
    }
    public static ArrayList<Registration> getRegistrationForCitizen(int userID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();

        String sql = """
            SELECT * 
            FROM Registrations
            WHERE UserID = ?
            ORDER BY RegistrationID DESC
        """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Registration registration = new Registration(
                            rs.getInt("RegistrationID"),
                            rs.getString("RegistrationCode"),
                            rs.getInt("UserID"),
                            rs.getString("RegistrationType"),
                            rs.getInt("HouseholdID"),
                            rs.getString("StartDate"),
                            rs.getString("EndDate"),
                            rs.getString("Status"),
                            rs.getInt("ApprovedBy"),
                            rs.getString("Comments"),
                            rs.getString("Relationship")
                    );
                    registration.includingHousehold();
                    registrations.add(registration);
                }
            }
        } catch (Exception e) {
            return null;
        }
        if (registrations.isEmpty()) return null;
        else return registrations;
    }
    
    public static ArrayList<Registration> getRegistrationForPolice(User police) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        ArrayList<User> areaLeadersOnWard = UserDAO.getAreaLeaderByWardID(police.getWardID());
        if (areaLeadersOnWard.isEmpty() || areaLeadersOnWard == null) {
        return null; // Trả về danh sách rỗng nếu không có areaLeader nào
    }
        String placeholders = areaLeadersOnWard.stream()
        .map(u -> "?")
        .collect(Collectors.joining(", "));

    String sql = "SELECT * FROM Registrations WHERE Status='PreApproved' AND ApprovedBy IN (" + placeholders + ") ORDER BY RegistrationID DESC";

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
        // Gán giá trị cho từng dấu ?
        for (int i = 0; i < areaLeadersOnWard.size(); i++) {
            ps.setInt(i + 1, areaLeadersOnWard.get(i).getUserID());
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        return null; // Trả về null nếu có lỗi
    }

    return registrations.isEmpty() ? null : registrations;
    }
    
    public static Registration getRegistrationByRegistrationID(String registrationID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();

        String sql = """
            SELECT * FROM Registrations
            WHERE RegistrationID = ?
        """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, registrationID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Registration registration = new Registration(
                            rs.getInt("RegistrationID"),
                            rs.getString("RegistrationCode"),
                            rs.getInt("UserID"),
                            rs.getString("RegistrationType"),
                            rs.getInt("HouseholdID"),
                            rs.getString("StartDate"),
                            rs.getString("EndDate"),
                            rs.getString("Status"),
                            rs.getInt("ApprovedBy"),
                            rs.getString("Comments"),
                            rs.getString("Relationship")
                    );
                    registrations.add(registration);
                }
            }
        } catch (Exception e) {
            return null;
        }
        if (registrations.isEmpty()) return null;
        else return registrations.get(0);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public static ArrayList<Registration> getRegistrations() {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT  * 
                         FROM Registrations
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return null;
        }

        if (registrations.isEmpty()) {
            return null;
        } else {
            return registrations;
        }
    }

    public static Registration getRegistrationById(int RegistrationID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM  Registrations
                         WHERE RegistrationID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, RegistrationID);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return null;
        }
        if (registrations.isEmpty()) {
            return null;
        } else {
            return registrations.get(0);
        }
    }

    public static Registration updateRegistration(Registration registration) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                              EXEC UpdateRegistration
                             @RegistrationID = ?,  
                             @RegistrationCode = ?,  
                             @UserID = ?,  
                             @RegistrationType = ?,  
                             @HouseholdID = ?,  
                             @StartDate = ?,  
                             @EndDate = ?,  
                             @Status = ?,  
                             @ApprovedBy = ?,  
                             @Comments = ?,  
                             @Relationship = ?;
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setInt(1, registration.getRegistrationID());
            statment.setString(2, registration.getRegistrationCode());
            statment.setInt(3, registration.getUserID());
            statment.setString(4, registration.getRegistrationType());
            statment.setInt(5, registration.getHouseholdID());
            statment.setString(6, registration.getStartDate());
            statment.setString(7, registration.getEndDate());
            statment.setString(8, registration.getStatus());
            statment.setInt(9, registration.getApproveBy());
            statment.setString(10, registration.getComment());          
            statment.setString(11, registration.getRelationship());

            rs = statment.executeUpdate();

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return registration;
        }
    }
    
    public static ArrayList<Registration> getRegistrationByType(String typeSearch) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM Registrations
                         WHERE RegistrationType = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            

            statment.setString(1, typeSearch);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return registrations;
        }
        return registrations;
    }
    
    public static ArrayList<Registration> getRegistrationByUserIDAndType(int userID, String typeSearch) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM Registrations
                         WHERE RegistrationType = ? AND UserID = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            

            statment.setString(1, typeSearch);
        statment.setInt(2, userID);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return registrations;
        }
        return registrations;
    }
    public static ArrayList<Registration> getRegistrationByStatus(String statusSearch) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM Registrations
                         WHERE Status = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            

            statment.setString(1, statusSearch);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return registrations;
        }
        return registrations;
    }
    
     public static ArrayList<Registration> getRegistrationByUserIDByStatus(int userID, String statusSearch) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM Registrations
                         WHERE Status = ? AND UserID = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            

            statment.setString(1, statusSearch);
            statment.setInt(2, userID);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return registrations;
        }
        return registrations;
    }
     
     
     public static ArrayList<Registration>  getRegistrationByUserId(int UserID) {
       DBContext db = DBContext.getInstance();
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try {
            String sql = """
                         SELECT * 
                         FROM Registrations
                         WHERE  UserID = ?
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            

            statment.setInt(1, UserID);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Registration registration = new Registration(
                        rs.getInt("RegistrationID"),
                        rs.getString("RegistrationCode"),
                        rs.getInt("UserID"),
                        rs.getString("RegistrationType"),
                        rs.getInt("HouseholdID"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate"),
                        rs.getString("Status"),
                        rs.getInt("ApprovedBy"),
                        rs.getString("Comments"),
                        rs.getString("Relationship")
                );
                registrations.add(registration);
            }
        } catch (Exception e) {
            return registrations;
        }
        return registrations;
     }
}
