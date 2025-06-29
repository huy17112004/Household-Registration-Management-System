<%-- 
    Document   : householdChild
    Created on : Mar 15, 2025, 4:10:54 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="topnavChild.jsp"/>
        <h1>Đăng kí cho người thân</h1>
        <table>
        <tr>
                <td>Đăng kí thường trú</td>
                <td>
                    <input type="button" value="Chọn" onclick="location.href='Household?action=permanent&childID=${childID}'">
                </td>
            </tr>
            <tr>
                <td>Đăng kí tạm trú</td>
                <td>
                    <input type="button" value="Chọn" onclick="location.href='Household?action=temporary&childID=${childID}'">
                </td>
            </tr>
            <tr>
                <td>Đăng kí tạm vắng</td>
                <td>
                    <input type="button" value="Chọn" onclick="location.href='Household?action=temporaryStay&childID=${childID}'">
                </td>
            </tr>
            </table>
                <input type="button" value="Quay lại" onclick="location.href = 'User?action=childManagement'">
    </body>
</html>
