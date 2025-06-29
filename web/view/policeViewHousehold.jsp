<%-- 
    Document   : policeViewHousehold
    Created on : Mar 16, 2025, 2:43:30 PM
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
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        CÁC HỘ KHẨU TRONG XÃ
                    </h2>
                </div>
                <c:if test="${households == null}">
                    <b>Không có hộ khẩu nào trong huyện</b>
                </c:if>
                <c:if test="${households != null}">
                    <div class="household-card-style">
                        <c:forEach var="hh" items="${households}">
                            <div class="household-card">
                                <h3>${hh.getHeadOfHousehold().getFullName()}</h3>
                                <p><strong>Mã hộ khẩu:</strong> ${hh.getHouseholdCode()}</p>
                                <p><strong>CCCD chủ hộ:</strong> ${hh.getHeadOfHousehold().getCCCD()}</p>
                                <p><strong>Địa chỉ:</strong> ${hh.getAddressDetail()}</p>
                                <p><strong>Ngày tạo:</strong> ${hh.getCreatedDate()}</p>
                                <a class="view-members" href="Household?action=viewMember&householdID=${hh.getHouseholdID()}">Xem thành viên</a>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </section>
    </body>
</html>
