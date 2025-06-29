/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.HouseholdMember;

/**
 *
 * @author Huytayto
 */
public class HouseholdMemberDAO {
    public static HouseholdMember getHouseholdMemberByUserID(int userID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<HouseholdMember> householdMembers = new ArrayList<HouseholdMember>();
        try {
            String sql = """
                         SELECT *
                         FROM HouseholdMembers
                         Where UserID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                HouseholdMember householdMember = new HouseholdMember(
                        rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"),
                        rs.getInt("UserID"),
                        rs.getString("Relationship")
                );
                householdMembers.add(householdMember);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (householdMembers.isEmpty()) return null;
        else return householdMembers.get(0);
    }
    public static HouseholdMember getHouseholdMemberByMemberID(int memberID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<HouseholdMember> householdMembers = new ArrayList<HouseholdMember>();
        try {
            String sql = """
                         SELECT *
                         FROM HouseholdMembers
                         Where MemberID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, memberID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                HouseholdMember householdMember = new HouseholdMember(
                        rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"),
                        rs.getInt("UserID"),
                        rs.getString("Relationship")
                );
                householdMembers.add(householdMember);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (householdMembers.isEmpty()) return null;
        else return householdMembers.get(0);
    }
    public static ArrayList<HouseholdMember> getHouseholdMemberByHouseholdIDIncludingUser(int householdID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<HouseholdMember> householdMembers = new ArrayList<HouseholdMember>();
        try {
            String sql = """
                         SELECT *
                         FROM HouseholdMembers
                         Where HouseholdID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, householdID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                HouseholdMember householdMember = new HouseholdMember(
                        rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"),
                        rs.getInt("UserID"),
                        rs.getString("Relationship")
                );
                householdMember.includingUser();
                householdMembers.add(householdMember);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (householdMembers.isEmpty()) return null;
        else return householdMembers;
    }
    public static void updateRelationShipHouseholdMember(int memberID, String relationship) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         UPDATE HouseholdMembers
                         SET Relationship = ?
                         Where MemberID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setString(1, relationship);
            statment.setInt(2, memberID);
            
            rs = statment.executeUpdate();
        } catch (Exception e) {
        }
    }
}
