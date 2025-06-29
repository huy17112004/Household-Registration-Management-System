<%-- 
    Document   : areaLeaderScreen
    Created on : Mar 15, 2025, 9:25:51 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" href="css/mycss.css">
    </head>
    <body class="sub_page">
        <jsp:include page="topnavAreaLeader.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        QUẢN LÍ ĐƠN TRONG KHU VỰC
                    </h2>
                </div>
                <div class="area-leader-container">
                    <c:forEach var="regis" items="${registrations}">
                        <div class="area-leader-card">
                            <h3>Mã đơn: ${regis.getRegistrationCode()}</h3>
                            <p><strong>Loại đơn:</strong>
                                <c:choose>
                                    <c:when test="${regis.getHouseholdID() == 0}">Đơn xin tạo hộ khẩu</c:when>
                                    <c:when test="${regis.getHouseholdID() != 0 and regis.getRegistrationType() eq 'Permanent'}">Đơn đăng kí thường trú</c:when>
                                    <c:when test="${regis.getRegistrationType() eq 'Temporary'}">Đơn đăng kí tạm trú</c:when>
                                    <c:when test="${regis.getRegistrationType() eq 'TemporaryStay'}">Đơn đăng kí tạm vắng</c:when>
                                </c:choose>
                            </p>
                            <p><strong>Trạng thái:</strong> 
                                <span class="status">
                                    <c:choose>
                                        <c:when test="${regis.getStatus().equals('Pending')}">Chờ</c:when>
                                        <c:when test="${regis.getStatus().equals('PreApproved')}">Đã Sơ duyệt</c:when>
                                        <c:when test="${regis.getStatus().equals('Approved')}">Chấp nhận</c:when>
                                    </c:choose>
                                </span>
                            </p>
                            <a class="btn-view" href="Household?action=registrationView&registrationID=${regis.getRegistrationID()}">Xem đơn</a>
                        </div>
                    </c:forEach>
                </div>
            </div><!-- comment -->
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
