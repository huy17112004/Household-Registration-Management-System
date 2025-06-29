<%-- 
    Document   : policeViewMember
    Created on : Mar 16, 2025, 3:22:52 PM
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
        <link rel="stylesheet" href="css/mycss.css">
        <title>JSP Page</title>
    </head>
    <body class="sub_page">
        <jsp:include page="topnavPolice.jsp"/>
        <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Household?action=policeViewHousehold'">
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Mã hộ khẩu: ${household.getHouseholdCode()}
                    </h2>
                </div>
                <div class="member-card-style">
                    <c:forEach var="hhm" items="${householdMembers}">
                        <div class="member-card">
                            <h3>${hhm.getUser().getFullName()}</h3>
                            <p><strong>CCCD:</strong> ${hhm.getUser().getCCCD()}</p>
                            <p><strong>Ngày sinh:</strong> ${hhm.getUser().getDateOfBirth()}</p>
                            <p><strong>Mối quan hệ:</strong> ${hhm.getRelationship()}</p>
                        </div>
                    </c:forEach>
                </div>            
            </div>
        </section>
                    <jsp:include page="footer.jsp"/>
    </body>
</html>
