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
public class HouseholdMember {
    private int memberID;
    private int householdID;
    private int userID;
    private String relationship;

    private User user;
    private Household household;

    public Household getHousehold() {
        return household;
    }

    public void includingHousehold() {
        this.household = HouseholdDAO.getHouseholdByHouseholdID(householdID);
    }
    
    

    public void includingUser() {
        this.user = UserDAO.getUserByUserID(userID);
    }

    public User getUser() {
        return user;
    }
    public HouseholdMember() {
    }

    public HouseholdMember(int memberID, int householdID, int userID, String relationship) {
        this.memberID = memberID;
        this.householdID = householdID;
        this.userID = userID;
        this.relationship = relationship;
    }

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public int getHouseholdID() {
        return householdID;
    }

    public void setHouseholdID(int householdID) {
        this.householdID = householdID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }
    
}
