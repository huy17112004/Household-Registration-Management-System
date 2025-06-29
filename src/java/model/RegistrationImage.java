/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Huytayto
 */
public class RegistrationImage {
    private int imageID;
    private int registrationID;
    private String imageURL;
    private String imageType;

    public RegistrationImage() {
    }

    public RegistrationImage(int imageID, int registrationID, String imageURL, String imageType) {
        this.imageID = imageID;
        this.registrationID = registrationID;
        this.imageURL = imageURL;
        this.imageType = imageType;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }
    
}
