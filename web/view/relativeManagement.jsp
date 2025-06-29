<%-- 
    Document   : relativeManagement
    Created on : Mar 15, 2025, 10:39:37 AM
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
        <jsp:include page="topnav.jsp"/>
        <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Household'">
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>TÀI KHOẢN NGƯỜI THÂN</h2>
                </div>
                <c:if test="${childList != null}">
                    <div class="child-card-container">
                        <c:forEach var="child" items="${childList}">
                            <div class="child-card">
                                <h3>${child.getFullName()}</h3>
                                <p><strong>Ngày sinh:</strong> ${child.getDateOfBirth()}</p>
                                <p><strong>Quê quán:</strong> ${child.getAddressDetail()}</p>
                                <p><strong>Trạng thái:</strong> 
                                    <c:if test="${child.getStatus() eq 'pending'}">Đang chờ</c:if>
                                    <c:if test="${child.getStatus() ne 'pending'}">Đã duyệt</c:if>
                                    </p>
                                <c:if test="${child.getStatus() ne 'pending'}">
                                    <button onclick="location.href = 'Household?action=registrationChild&childID=${child.getUserID()}'">
                                        Chọn
                                    </button>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <div class="button-container">
                    <input type="button" value="Thêm người thân" onclick="location.href = 'User?action=addChild'">
                </div>
            </div>

        </section>
        <jsp:include page="footer.jsp"/>

    </body>
</html>
