<%-- 
    Document   : deleteUser
    Created on : Mar 3, 2025, 11:04:08 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<%@page import="model.LocationService" %>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    if (session.getAttribute("user") == null) { 
        response.sendRedirect(request.getContextPath() + "/signIn"); // Chuyển hướng về trang đăng nhập
        return;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete User</title>
        
    </head>
    <body class="sub_page">
        
        <% User userneed = (User)(request.getAttribute("userneed"));
           if(userneed == null) {
        %>
        <h3>Deleting user failed!</h3>
        <% } else { %> 
        <h3>Deleted user: </h3>
        <h4>User Id: ${userneed.getUserID()}</h4>
        <h4>Full Name :  ${userneed.getFullName()} </h4>
        <h4>Date of birth : ${userneed.getDateOfBirth()} </h4>
        <h4>CCCD : ${userneed.getCCCD()} </h4>
        <h4>Email  : ${userneed.getEmail()} </h4>
        <h4>Phone Number : ${userneed.getPhoneNumber()} </h4>
        <h4>PassWord : ${userneed.getPassword()} </h4>
        <h4>Role  : ${userneed.getRole()} </h4>
        <h4>Province Id: ${LocationService.getProvinceName(userneed.getProvinceID())} </h4>
        <h4>District Id : ${LocationService.getDistrictName(userneed.getDistrictID())} </h4>
        <h4>Ward Id : ${LocationService.getWardName(userneed.getDistrictID(), userneed.getWardID())} </h4>
        <h4>Address Detail : ${userneed.getAddressDetail()} </h4>
        <h4>Status Detail : ${userneed.getStatus()} </h4>
        <% } %>
    </body>
</html>
