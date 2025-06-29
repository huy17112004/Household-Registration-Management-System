<%-- 
    Document   : userList
    Created on : Mar 2, 2025, 10:41:07 AM
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
<%@page import="java.util.ArrayList" %>
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
            <h1 class="text-center">Danh sách người dùng</h1>
            <% ArrayList<User> users = (ArrayList<User>) request.getAttribute("users"); %>
            <% if (users.isEmpty()) { %>
            <h2 class="text-center text-danger">Không có người dùng nào</h2>
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
                        <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getUserID() %></td>
                            <td><%= user.getFullName() %></td>
                            <td><%= user.getDateOfBirth() %></td>
                            <td><%= user.getCCCD() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPhoneNumber() %></td>
                            <td><%= user.getRole() %></td>
                            <td><%= LocationService.getProvinceName(user.getProvinceID()) %></td>
                            <td><%= LocationService.getDistrictName(user.getDistrictID()) %></td>
                            <td><%= LocationService.getWardName(user.getDistrictID(), user.getWardID()) %></td>
                            <td><%= user.getAddressDetail() %></td>
                            <td><%= user.getStatus() %></td>
                            <td>
                                <a href="User?action=view&userID=<%= user.getUserID() %>" class="btn btn-info btn-sm">View</a>
                                <a href="User?action=edit&userID=<%= user.getUserID() %>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="User?action=delete&userID=<%= user.getUserID() %>" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>

            <!-- Search Forms -->
            <div class="mt-4">
                <h3 class="text-center">Tìm kiếm</h3>

                <!-- Search by Name -->
                <form action="User" method="GET" class="form-inline justify-content-center mb-3">
                    <input type="hidden" name="action" value="searchByName">
                    <label class="mr-2">Tìm kiếm bằng tên:</label>
                    <input type="text" name="nameSearch" class="form-control mr-2">
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>

                <!-- Search by Phone Number -->
                <form action="User" method="GET" class="form-inline justify-content-center">
                    <input type="hidden" name="action" value="searchByPhoneNumber">
                    <label class="mr-2">Tìm kiếm bằng số điện thoại:</label>
                    <input type="text" name="phoneNumberSearch" class="form-control mr-2">
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
            </div>
        </div>
        <br>
        <jsp:include page="footer.jsp"/>
    </body>

</body>

</html>
