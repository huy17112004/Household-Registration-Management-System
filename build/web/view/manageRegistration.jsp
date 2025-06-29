<%-- 
    Document   : manageRegistration
    Created on : Mar 13, 2025, 9:40:48 AM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Registration</title>
    </head>
    <body>
        
        <div>
            <% Registration registration = (Registration)(request.getAttribute("registration"));%>
            <form action="Registration" method="POST">

                <input type="hidden" name="action" value="manage">
                <input type="hidden" name="RegistrationID" value="${registration.getRegistrationID()}">
                <table>
                    <tr>
                        <td>Registration ID :</td>
                        <td> 
                            <input type="text" name="RegistrationID" 
                                   value="<c:out value='${registration.getRegistrationID()}' />" 
                                   readonly> 
                        </td>
                    </tr>

                    <tr>
                        <td>Registration Code :</td>
                        <td> <input type="text" name="RegistrationCode" value="<c:out value="${registration.getRegistrationCode()}" ></c:out>" </td>
                        </tr>
                        <tr>
                            <td>User ID :</td>
                            <td> 
                                <input type="text" name="UserID" 
                                       value="<c:out value='${registration.getUserID()}' />" 
                                readonly> 
                        </td>
                    </tr>

                    <tr>
                        <td>Registration Type :</td>
                        <td>
                            <select name="RegistrationType">
                                <option value="Permanent"  ${registration.getRegistrationType().equals("Permanent") ? "selected" : ""} >Permanent</option>
                                <option value="Temporary"  ${registration.getRegistrationType().equals("Temporary") ? "selected" : ""} >Temporary</option>
                                <option value="TemporaryStay" ${registration.getRegistrationType().equals("TemporaryStay") ? "selected" : ""}  >TemporaryStay</option>
                                
                            </select>
                        </td>
                    </tr>
                    
                    
                        <tr>
                            <td>House hold ID :</td>
                            <td> <input type="text" name="HouseholdID" value="<c:out value="${registration.getHouseholdID()}" ></c:out>" </td>
                        </tr>
                        <tr>
                            <td>Start Date :</td>
                            <td> <input type="date" name="StartDate" value="<c:out value="${registration.getStartDate()}" ></c:out>" </td>
                        </tr>
                        <tr>
                            <td>End Date :</td>
                            <td> <input type="date" name="EndDate" value="<c:out value="${registration.getEndDate()}" ></c:out>" </td>
                        </tr>
                        
                    <tr>
                        <td>Status</td>
                        <td>
                            <select name="Status">
                                <option value="Pending"  ${registration.getStatus().equals("Pending") ? "selected" : ""} >Pending</option>
                                <option value="PreApproved"  ${registration.getStatus().equals("PreApproved") ? "selected" : ""} >PreApproved</option>
                                <option value="Approved" ${registration.getStatus().equals("Approved") ? "selected" : ""}  >Approved</option>
                                <option value="Rejected" ${registration.getStatus().equals("Rejected") ? "selected" : ""}  >Rejected</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>Approved By :</td>
                        <td> <input type="text" name="ApprovedBy" value="<c:out value="${registration.getApproveBy()}" ></c:out>" </td>
                        </tr>
                        <tr>
                            <td>Commnets :</td>
                            <td> <input type="text" name="Commnets" value="<c:out value="${registration.getComment()}" ></c:out>" </td>
                        </tr>
                        <tr>
                            <td>Relationship :</td>
                            <td> <input type="text" name="Relationship" value="<c:out value="${registration.getRelationship()}" ></c:out>" </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Edit Registration"></td>
                    </tr>

                </table>
            </form>
        </div>
    </body>
</html>
