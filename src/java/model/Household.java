/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dao.UserDAO;

/**
 *
 * @author Huytayto
 */
public class Household {
    private int householdID;
    private String householdCode;
    private int headOfHouseholdID;
    private int provinceID;
    private int districtID;
    private int wardID;
    private String addressDetail;
    private String createdDate;
//    
    private User headOfHousehold;

    public Household() {
    }

    public Household(int householdID, String householdCode, int headOfHouseholdID, int provinceID, int districtID, int wardID, String addressDetail, String createdDate) {
        this.householdID = householdID;
        this.householdCode = householdCode;
        this.headOfHouseholdID = headOfHouseholdID;
        this.provinceID = provinceID;
        this.districtID = districtID;
        this.wardID = wardID;
        this.addressDetail = addressDetail;
        this.createdDate = createdDate;
    }

    public int getHouseholdID() {
        return householdID;
    }

    public void setHouseholdID(int householdID) {
        this.householdID = householdID;
    }

    public String getHouseholdCode() {
        return householdCode;
    }

    public void setHouseholdCode(String householdCode) {
        this.householdCode = householdCode;
    }

    public int getHeadOfHouseholdID() {
        return headOfHouseholdID;
    }

    public void setHeadOfHouseholdID(int headOfHouseholdID) {
        this.headOfHouseholdID = headOfHouseholdID;
    }

    public int getProvinceID() {
        return provinceID;
    }

    public void setProvinceID(int provinceID) {
        this.provinceID = provinceID;
    }

    public int getDistrictID() {
        return districtID;
    }

    public void setDistrictID(int districtID) {
        this.districtID = districtID;
    }

    public int getWardID() {
        return wardID;
    }

    public void setWardID(int wardID) {
        this.wardID = wardID;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public User getHeadOfHousehold() {
        return headOfHousehold;
    }

    public void includingHeadOfHousehold() {
        this.headOfHousehold = UserDAO.getUserByUserID(this.headOfHouseholdID);
    }
    
    
}
