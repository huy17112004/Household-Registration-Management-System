/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Notification;

/**
 *
 * @author Huytayto
 */
public class NotificationDAO {
    
    public static ArrayList<Notification> getNotificationsByUserID(int userID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<Notification> notifications = new ArrayList<Notification>();
        try {
            String sql = """
                         SELECT *
                         FROM Notifications
                         Where UserID = ?
                         ORDER BY SentDate DESC
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // (6)
                Notification notification = new Notification(
                        rs.getInt("NotificationID"),
                        rs.getInt("UserID"),
                        rs.getString("Message"),
                        rs.getString("SentDate"),
                        rs.getBoolean("IsRead")
                );
                notifications.add(notification);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (notifications.isEmpty()) return null;
        else return notifications;
    }
    public static void updateIsReadByUserID(int userID) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         UPDATE Notifications
                         SET IsRead = 1
                         WHERE UserID = ?
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            rs = statement.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public static void addNotification(int userID, String message) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         INSERT INTO Notifications(UserID,Message,SentDate)
                         VALUES(?,?,GETDATE())
                         """; // (2)
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, userID);
            statement.setString(2, message);
            rs = statement.executeUpdate();
        } catch (Exception e) {
        }
    }
}