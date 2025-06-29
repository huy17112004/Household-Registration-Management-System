<%-- 
    Document   : registrationList
    Created on : Mar 12, 2025, 4:33:35 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Registration" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <body class="sub_page">
         <jsp:include page="topnavAdmin.jsp"/>
    <div class="container-fluid mt-4">
        <h1 class="text-center">List of Registrations</h1>
        <% ArrayList<Registration> registrations = (ArrayList<Registration>) request.getAttribute("registrations"); %>
        <% if (registrations == null || registrations.isEmpty()) { %>
        <h2 class="text-center text-danger">There are no registrations</h2>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="thead-dark">
                    <tr>
                        <th>Registration ID</th>
                        <th>Registration Code</th>
                        <th>User ID</th>
                        <th>Registration Type</th>
                        <th>Household ID</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Approved By</th>
                        <th>Comments</th>
                        <th>Relationship</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Registration reg : registrations) { %>
                    <tr>
                        <td><%= reg.getRegistrationID() %></td>
                        <td><%= reg.getRegistrationCode() %></td>
                        <td><%= reg.getUserID() %></td>
                        <td><%= reg.getRegistrationType() %></td>
                        <td><%= reg.getHouseholdID() %></td>
                        <td><%= reg.getStartDate() %></td>
                        <td><%= reg.getEndDate() %></td>
                        <td><%= reg.getStatus() %></td>
                        <td><%= reg.getApproveBy() %></td>
                        <td><%= reg.getComment() %></td>
                        <td><%= reg.getRelationship() %></td>
                        <td>
                            <a href="Household?action=registrationView&registrationID=<%= reg.getRegistrationID() %>" class="btn btn-info btn-sm">Manage</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>

        <br>

        
        <div class="mt-4">
            <h3 class="text-center">Search</h3>

            <!-- Search by Registration Type -->
            <form action="Registration" method="GET" class="form-inline justify-content-center mb-3">
                <input type="hidden" name="action" value="searchRegByType">
                <label class="mr-2">Registration Type:</label>
                <select name="RegistrationType" class="form-control mr-2">
                    <option value="Permanent" ${RegistrationType.equals("Permanent") ? "selected" : ""}>Permanent</option>
                    <option value="Temporary" ${RegistrationType.equals("Temporary") ? "selected" : ""}>Temporary</option>
                    <option value="TemporaryStay" ${RegistrationType.equals("TemporaryStay") ? "selected" : ""}>Temporary Stay</option>
                </select>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <!-- Search by Status -->
            <form action="Registration" method="GET" class="form-inline justify-content-center">
                <input type="hidden" name="action" value="searchRegByStatus">
                <label class="mr-2">Status:</label>
                <select name="Status" class="form-control mr-2">
                    <option value="Pending" ${Status.equals("Pending") ? "selected" : ""}>Pending</option>
                    <option value="PreApproved" ${Status.equals("PreApproved") ? "selected" : ""}>Pre Approved</option>
                    <option value="Approved" ${Status.equals("Approved") ? "selected" : ""}>Approved</option>
                    <option value="Rejected" ${Status.equals("Rejected") ? "selected" : ""}>Rejected</option>
                </select>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>
    </div>
                            <br>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
