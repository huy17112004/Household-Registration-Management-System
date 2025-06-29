/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dao.HouseholdDAO;
import dao.UserDAO;

/**
 *
 * @author Huytayto
 */
public class Log {
    private int logID;
    private int userID;
    private String timestamp;
    private int householdID;
    private String registrationType;
    private String startDate;
    private String endDate;
    
    private Household household;
    private User User;
    public Log() {
    }

    public Log(int logID, int userID, String timestamp, int householdID, String registrationType, String startDate, String endDate) {
        this.logID = logID;
        this.userID = userID;
        this.timestamp = timestamp;
        this.householdID = householdID;
        this.registrationType = registrationType;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public void includingUser() {
        this.User = UserDAO.getUserByUserID(userID);
    }

    public User getUser() {
        return User;
    }

    public Household getHousehold() {
        return household;
    }

    public void includingHousehold() {
        this.household = HouseholdDAO.getHouseholdByHouseholdID(householdID);
    }
    
    

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getHouseholdID() {
        return householdID;
    }

    public void setHouseholdID(int householdID) {
        this.householdID = householdID;
    }

    public String getRegistrationType() {
        return registrationType;
    }

    public void setRegistrationType(String registrationType) {
        this.registrationType = registrationType;
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
    
}
