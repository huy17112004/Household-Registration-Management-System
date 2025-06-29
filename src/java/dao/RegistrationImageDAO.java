/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.RegistrationImage;

/**
 *
 * @author Huytayto
 */
public class RegistrationImageDAO {
    public static void addRegistrationImage(int RegistrationID, String ImageURL, String ImageType) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
                         INSERT INTO RegistrationImages(RegistrationID, ImageURL, ImageType)
                         VALUES(?,?,?)
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, RegistrationID);
            statment.setString(2, ImageURL);
            statment.setString(3, ImageType);
            
            rs = statment.executeUpdate();
        } catch (Exception e) {
            
        }
    }
    public static ArrayList<RegistrationImage> getRegistrationImagesByRegistrationID(int registrationID) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<RegistrationImage> registrationImages = new ArrayList<RegistrationImage>();
        try {
            String sql = """
                         select *
                         from RegistrationImages
                         Where RegistrationID = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, registrationID);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                RegistrationImage registrationImage = new RegistrationImage(
                        rs.getInt("ImageID"),
                        rs.getInt("registrationID"),
                        rs.getString("ImageURL"),
                        rs.getString("ImageType"));
                registrationImages.add(registrationImage);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (registrationImages.isEmpty()) return null;
        else return registrationImages;
    }
    
    public static ArrayList<RegistrationImage> getRegistrationImagesByRegistrationIDAndImageType(int registrationID, String imageType) {
        DBContext db = DBContext.getInstance(); // (1)
        ArrayList<RegistrationImage> registrationImages = new ArrayList<RegistrationImage>();
        try {
            String sql = """
                         select *
                         from RegistrationImages
                         Where RegistrationID = ? AND ImageType = ?
                         """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, registrationID);
            statment.setString(2, imageType);
            ResultSet rs = statment.executeQuery();
            while (rs.next()) { // (6)
                RegistrationImage registrationImage = new RegistrationImage(
                        rs.getInt("ImageID"),
                        rs.getInt("registrationID"),
                        rs.getString("ImageURL"),
                        rs.getString("ImageType"));
                registrationImages.add(registrationImage);
            }
        } catch (Exception e) {
            return null;
        }
        
        if (registrationImages.isEmpty()) return null;
        else return registrationImages;
    }
}
