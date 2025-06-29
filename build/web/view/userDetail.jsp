<%-- 
    Document   : userDetail
    Created on : Mar 2, 2025, 10:56:53 AM
    Author     : GIGABYTE
--%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    if (session.getAttribute("user") == null) { 
        response.sendRedirect(request.getContextPath() + "/signIn"); // Chuyển hướng về trang đăng nhập
        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<%@page import="model.LocationService" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title> Feane </title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" /> 
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="js/jquery-3.4.1.min.js"></script>
    </head>
    <body>
        <body>
            <body class="sub_page">
    <jsp:include page="topnavAdmin.jsp"/>

    <div class="container-fluid mt-4">
        <h1 class="text-center">Chi tiết người dùng</h1>

        <% User userneed = (User)(request.getAttribute("userneed")); %>
        <% if(userneed == null) { %>
            <h2 class="text-center text-danger">Không có thông tin người dùng</h2>
        <% } else { %>

        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="thead-dark">
                    <tr>
                        <th>UserId</th>
                        <th>FullName</th>
                        <th>DateOfBirth</th>
                        <th>CCCD</th>
                        <th>Email</th>
                        <th>Phone Number</th>               
                        <th>Role</th>
                        <th>Province</th>
                        <th>District</th>
                        <th>Ward</th>
                        <th>Address Detail</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= userneed.getUserID() %></td>
                        <td><%= userneed.getFullName() %></td>
                        <td><%= userneed.getDateOfBirth() %></td>
                        <td><%= userneed.getCCCD() %></td>
                        <td><%= userneed.getEmail() %></td>
                        <td><%= userneed.getPhoneNumber() %></td>    
                        <td><%= userneed.getRole() %></td>
                        <td><%= LocationService.getProvinceName(userneed.getProvinceID()) %></td>
                        <td><%= LocationService.getDistrictName(userneed.getDistrictID()) %></td>
                        <td><%= LocationService.getWardName(userneed.getDistrictID(), userneed.getWardID()) %></td>
                        <td><%= userneed.getAddressDetail() %></td>
                        <td><%= userneed.getStatus() %></td>
                        <td>
                            <a href="User?action=edit&userID=<%= userneed.getUserID() %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="User?action=delete&userID=<%= userneed.getUserID() %>" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <% } %>

    </div>

        <br>
    <jsp:include page="footer.jsp"/>
</body>

    </body>
</html>
