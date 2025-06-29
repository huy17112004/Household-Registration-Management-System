<%-- 
    Document   : editUserResult
    Created on : Mar 4, 2025, 10:07:05 PM
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
       <meta charset="utf-8" />
        <title> Feane </title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" /> 
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="js/jquery-3.4.1.min.js"></script>
    </head>
    

    </style>
    <body>
         <body>
    <jsp:include page="topnavAdmin.jsp"/> 
    <br>
    <div class="container">
        <%
            User usernew = (User)request.getAttribute("usernew");
            if(usernew == null) {
        %>
        <h3>Chỉnh sửa thông tin thất bại!</h3>
        <% } else { %> 
        <h3>Chỉnh sửa thông tin thành công! </h3>
        <div class="user-info">
            <h4>User Id: ${usernew.getUserID()}</h4>
            <h4>Full Name :  ${usernew.getFullName()} </h4>
            <h4>Date of birth : ${usernew.getDateOfBirth()} </h4>
            <h4>CCCD : ${usernew.getCCCD()} </h4>
            <h4>Email  : ${usernew.getEmail()} </h4>
            <h4>Phone Number : ${usernew.getPhoneNumber()} </h4>
            <h4>Role  : ${usernew.getRole()} </h4>
            <h4>Province : ${LocationService.getProvinceName(usernew.getProvinceID())} </h4>
            <h4>District : ${LocationService.getDistrictName(usernew.getDistrictID())} </h4>
            <h4>Ward : ${LocationService.getWardName(usernew.getDistrictID(), usernew.getWardID())} </h4>
            <h4>Address Detail : ${usernew.getAddressDetail()} </h4>
            <h4>Status : ${usernew.getStatus()} </h4>
        </div>
        <% } %>
    </div>

    <br>
    <jsp:include page="footer.jsp"/>
</body>

    </body>
</html>
