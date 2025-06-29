<%-- 
    Document   : logList
    Created on : Mar 18, 2025, 8:34:39 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="css/mycss.css">
        <title>JSP Page</title>
    </head>
    <body class="sub_page">
        <jsp:include page="topnavPolice.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        CÁC ĐƠN SẮP HẾT HẠN TẠM TRÚ
                    </h2>
                </div>
                <c:if test="${logs == null}">
                    <b>Chưa có đơn nào đến hạn cần thông báo</b>
                </c:if>
                <c:if test="${logs != null}">
                    <div class="log-card-style">
                        <c:forEach var="log" items="${logs}">
                            <div class="log-card">
                                <h3>${log.getUser().getFullName()}</h3>
                                <p><strong>CCCD:</strong> ${log.getUser().getCCCD()}</p>
                                <p><strong>Mã hộ khẩu:</strong> ${log.getHousehold().getHouseholdCode()}</p>
                                <p><strong>Địa chỉ:</strong> ${log.getHousehold().getAddressDetail()}</p>
                                <p><strong>Ngày bắt đầu:</strong> ${log.getStartDate()}</p>
                                <p><strong>Ngày kết thúc:</strong> ${log.getEndDate()}</p>
                                <button onclick="location.href = 'Registration?action=sendReport&logID=${log.getLogID()}'">Gửi thông báo</button>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div><!-- comment -->
        </section>
         <jsp:include page="footer.jsp"/>
    </body>
</html>
