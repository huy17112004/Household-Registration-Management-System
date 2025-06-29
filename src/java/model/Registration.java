/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dao.HouseholdDAO;

/**
 *
 * @author Huytayto
 */
public class Registration {
    private int registrationID;
    private String registrationCode;
    private int userID;
    private String registrationType;
    private int householdID;
    private String startDate;
    private String endDate;
    private String status;
    private int approveBy;
    private String comment;
    private String relationship;
    
    private Household household;

    public Household getHousehold() {
        return household;
    }

    public void includingHousehold() {
        this.household = HouseholdDAO.getHouseholdByHouseholdID(householdID);
    }
    
    

    public Registration() {
    }

    public Registration(int registrationID, String registrationCode, int userID, String registrationType, int householdID, String startDate, String endDate, String status, int approveBy, String comment, String relationship) {
        this.registrationID = registrationID;
        this.registrationCode = registrationCode;
        this.userID = userID;
        this.registrationType = registrationType;
        this.householdID = householdID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.approveBy = approveBy;
        this.comment = comment;
        this.relationship = relationship;
    }

    

    

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public String getRegistrationCode() {
        return registrationCode;
    }

    public void setRegistrationCode(String registrationCode) {
        this.registrationCode = registrationCode;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getRegistrationType() {
        return registrationType;
    }

    public void setRegistrationType(String registrationType) {
        this.registrationType = registrationType;
    }

    public int getHouseholdID() {
        return householdID;
    }

    public void setHouseholdID(int householdID) {
        this.householdID = householdID;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getApproveBy() {
        return approveBy;
    }

    public void setApproveBy(int approveBy) {
        this.approveBy = approveBy;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    
    
    
}
