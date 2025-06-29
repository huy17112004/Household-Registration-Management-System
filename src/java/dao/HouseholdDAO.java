/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Household;

/**
 *
 * @author Huytayto
 */
public class HouseholdDAO {
    public static Household getHouseholdByHeadOfHouseholdID(int headID, boolean status) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT *
                         FROM Households
                         Where HeadOfHouseholdID = ? AND Status = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, headID);
            statement.setBoolean(2, status);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (households.isEmpty()) return null;
        else return households.get(0);
    }
    public static Household getHouseholdByRegistrationID(int registrationID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT *
                         FROM Households
                         WHERE HouseholdCode LIKE '%_' + CAST(? AS NVARCHAR);
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, registrationID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (households.isEmpty()) return null;
        else return households.get(0);
    }
    public static Household getHouseholdByHouseholdID(int householdID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT *
                         FROM Households
                         Where HouseholdID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, householdID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (households.isEmpty()) return null;
        else return households.get(0);
    }
    
    public static ArrayList<Household> getHouseholdsByWardIDIncludeHeadOfHousehold(int wardID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT *
                         FROM Households
                         WHERE WardID = ? AND Status = 1
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, wardID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                household.includingHeadOfHousehold();
                households.add(household);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (households.isEmpty()) return null;
        else return households;
    }
    
    public static void addHousehold(int headOfHousehold,int provinceID,int districtID,int wardID, String addressDetail,String createdDate) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         INSERT INTO Households(HeadOfHouseholdID, ProvinceID, DistrictID,WardID,AddressDetail,CreatedDate)
                         VALUES(?,?,?,?,?,?)
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, headOfHousehold);
            statment.setInt(2, provinceID);
            statment.setInt(3, districtID);
            statment.setInt(4, wardID);
            statment.setString(5, addressDetail);
            statment.setString(6, createdDate);
            
            rs = statment.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public static ArrayList<Household> getHouseholds() {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT  * 
                         FROM Households
                         WHERE Status = 1
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return null;
        }

        if (households.isEmpty()) {
            return null;
        } else {
            return households;
        }
    }

    public static ArrayList<Household> getHouseholdByLocation(int ProvinceID, int DistrictID, int WardId) {
        DBContext db = DBContext.getInstance();
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT * 
                         FROM Households 
                         WHERE 
                             ProvinceID = ?
                             AND DistrictID = ?
                             AND WardID = ?;
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setInt(1, ProvinceID);
            statment.setInt(2, DistrictID);
            statment.setInt(3, WardId);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return households;
        }
        return households;
    }

    public static ArrayList<Household> getHouseholdByProvinceID(int ProvinceID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT * 
                         FROM Households 
                         WHERE 
                             ProvinceID = ?
                             
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setInt(1, ProvinceID);

            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return households;
        }
        return households;
    }

    public static ArrayList<Household> getHouseholdByProvinceIDandDistrictID(int ProvinceID, int DistrictID) {
        DBContext db = DBContext.getInstance();
        ArrayList<Household> households = new ArrayList<Household>();
        try {
            String sql = """
                         SELECT * 
                         FROM Households 
                         WHERE 
                         ProvinceID = ?
                         AND DistrictID = ?;
                         
                             
                         """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)

            statment.setInt(1, ProvinceID);
            statment.setInt(2, DistrictID);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                Household household = new Household(
                        rs.getInt("HouseholdID"),
                        rs.getString("HouseholdCode"),
                        rs.getInt("HeadOfHouseholdID"),
                        rs.getInt("ProvinceID"),
                        rs.getInt("DistrictID"),
                        rs.getInt("WardID"),
                        rs.getString("AddressDetail"),
                        rs.getString("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            return households;
        }
        return households;
    }
    public static void deleteHousehold(int householdID) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         UPDATE Households
                         SET Status = 0
                         Where HouseholdID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, householdID);
            
            rs = statment.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public static void updateHeadOfHousehold(int householdID, int headOfHouseholdID) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         UPDATE Households
                         SET HeadOfHouseholdID = ?
                         Where HouseholdID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, headOfHouseholdID);
            statment.setInt(2, householdID);
            rs = statment.executeUpdate();
        } catch (Exception e) {
        }
    }
}
