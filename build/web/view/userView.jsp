<%-- 
    Document   : userView
    Created on : Mar 18, 2025, 3:49:57 PM
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/mycss.css">
    </head>
    <body class="sub_page">
        <c:if test="${user.getRole() eq 'AreaLeader'}">
            <jsp:include page="topnavAreaLeader.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'Citizen'}">
            <jsp:include page="topnav.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'Police'}">
            <jsp:include page="topnavPolice.jsp"/>
        </c:if>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>THÔNG TIN CÁ NHÂN</h2>
                </div>
                <div class="personal-info-container">
            <table class="info-table">
                <tr><td>Họ và tên:</td><td>${user.getFullName()}</td></tr>
                <tr><td>Ngày sinh:</td><td>${user.getDateOfBirth()}</td></tr>
                <tr><td>CCCD:</td><td>${user.getCCCD()}</td></tr>
                <tr><td>Email:</td><td>${user.getEmail()}</td></tr>
                <tr><td>Số điện thoại:</td><td>${user.getPhoneNumber()}</td></tr>
                <tr><td>Tỉnh/Thành Phố:</td><td>${provinceName}</td></tr>
                <tr><td>Quận/Huyện:</td><td>${districtName}</td></tr>
                <tr><td>Xã/Phường:</td><td>${wardName}</td></tr>
                <tr><td>Địa Chỉ Cụ Thể:</td><td>${user.getAddressDetail()}</td></tr>
            </table>
            
            <div class="button-container">
                <c:if test="${user.getRole() eq 'Citizen'}">
                <input type="button" value="Chỉnh sửa Email và Số điện thoại" onclick="location.href = 'User?action=editEmail'">
                </c:if>
                <input type="button" value="Thay đổi mật khẩu" onclick="location.href = 'User?action=editPassword'">
            </div>
        </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
