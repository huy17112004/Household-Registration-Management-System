/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Log;

/**
 *
 * @author Huytayto
 */
public class LogDAO {
    public static Log getLatestLogByUserID(int userID, String registrationType) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Log> logs = new ArrayList<Log>();
        try {
            String sql = """
                         SELECT TOP 1 *
                         FROM Logs
                         WHERE UserID = ?
                             AND RegistrationType = ?
                             AND EndDate > GETDATE()
                         ORDER BY Timestamp DESC;
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            statement.setString(2, registrationType);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Log log = new Log(
                        rs.getInt("LogID"),
                        rs.getInt("UserID"),
                        rs.getString("Timestamp"),
                        rs.getInt("HouseholdID"),
                        rs.getString("RegistrationType"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate")
                );
                logs.add(log);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (logs.isEmpty()) return null;
        else return logs.get(0);
    }
    public static Log getLogByLogID(int logID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Log> logs = new ArrayList<Log>();
        try {
            String sql = """
                         SELECT *
                         FROM Logs
                         WHERE LogID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, logID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Log log = new Log(
                        rs.getInt("LogID"),
                        rs.getInt("UserID"),
                        rs.getString("Timestamp"),
                        rs.getInt("HouseholdID"),
                        rs.getString("RegistrationType"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate")
                );
                logs.add(log);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (logs.isEmpty()) return null;
        else return logs.get(0);
    }
    
    public static ArrayList<Log> getLogsNotificate(int wardID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Log> logs = new ArrayList<Log>();
        try {
            String sql = """
                         SELECT * 
                         FROM Logs l
                         LEFT JOIN Users u ON l.UserID = u.UserID
                         WHERE RegistrationType = 'Temporary'
                         AND EndDate >= GETDATE()
                         AND DATEDIFF(DAY, GETDATE(), EndDate) < 7
                         AND u.WardID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, wardID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Log log = new Log(
                        rs.getInt("LogID"),
                        rs.getInt("UserID"),
                        rs.getString("Timestamp"),
                        rs.getInt("HouseholdID"),
                        rs.getString("RegistrationType"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate")
                );
                log.includingHousehold();
                log.includingUser();
                logs.add(log);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (logs.isEmpty()) return null;
        else return logs;
    }
    public static Log getTemporaryByUserID(int userID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Log> logs = new ArrayList<Log>();
        try {
            String sql = """
                         SELECT TOP 1 * FROM Logs
                         WHERE UserID = ? AND RegistrationType = 'Temporary' AND EndDate >= GETDATE()
                         ORDER BY LogID DESC
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Log log = new Log(
                        rs.getInt("LogID"),
                        rs.getInt("UserID"),
                        rs.getString("Timestamp"),
                        rs.getInt("HouseholdID"),
                        rs.getString("RegistrationType"),
                        rs.getString("StartDate"),
                        rs.getString("EndDate")
                );
                log.includingHousehold();
                logs.add(log);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (logs.isEmpty()) return null;
        else return logs.get(0);
    }
}
