<%-- 
    Document   : notificationView
    Created on : Mar 18, 2025, 4:47:59 PM
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
        <title>Thông báo</title>
        <link rel="stylesheet" href="css/mycss.css">
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container"> 
                    <h2>THÔNG BÁO</h2>
                </div>
            </div>
            <c:if test="${notifications == null}">
                <b>Không có thông báo nào gửi đến bạn</b>
                <br>
            </c:if>
            <c:if test="${notifications != null}">
                <div class="child-card-container">
                    <c:forEach var="noti" items="${notifications}">
                        <div class="child-card noti-card
                             <c:if test='${noti.isIsRead()}'>read</c:if>
                             <c:if test='${!noti.isIsRead()}'>unread</c:if>">
                                 <h3>Thông báo</h3>
                                 <p><strong>Nội dung:</strong> ${noti.getMessage()}</p>
                             <p><strong>Ngày gửi:</strong> ${noti.getSentDate()}</p>
                             <p><strong>Trạng thái:</strong> 
                                 <c:if test="${noti.isIsRead()}">Đã đọc</c:if>
                                 <c:if test="${!noti.isIsRead()}">Chưa đọc</c:if>
                                 </p>
                             </div>
                    </c:forEach>
                </div>
            </c:if>
            
        </section>
<jsp:include page="footer.jsp"/>
    </body>
</html>