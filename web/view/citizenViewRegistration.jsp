<%-- 
    Document   : citizenViewRegistration
    Created on : Mar 19, 2025, 9:14:18 AM
    Author     : Huytayto
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
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/mycss.css">
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>LỊCH SỬ CÁC ĐƠN CỦA BẠN</h2>
                </div>

                <c:if test="${registrations == null}">
                    <b>Không có đơn nào!</b>
                </c:if>
                <c:if test="${registrations != null}">
                    <div class="registration-card-container">
                        <c:forEach var="regis" items="${registrations}">
                            <div class="registration-card">
                                <h3>Mã đơn: ${regis.getRegistrationCode()}</h3>
                                <p><strong>Loại đơn:</strong>
                                    <c:if test="${regis.getHouseholdID() == 0}">Đơn xin tạo hộ khẩu</c:if>
                                    <c:if test="${regis.getHouseholdID() != 0 and regis.getRegistrationType() eq 'Permanent'}">Đơn đăng kí thường trú</c:if>
                                    <c:if test="${regis.getRegistrationType() eq 'Temporary'}">Đơn đăng kí tạm trú</c:if>
                                    <c:if test="${regis.getRegistrationType() eq 'TemporaryStay'}">Đơn đăng kí tạm vắng</c:if>
                                    </p>
                                    <p><strong>Mã hộ khẩu:</strong> ${regis.getHousehold().getHouseholdCode()}</p>
                                <p><strong>Ngày bắt đầu:</strong> ${regis.getStartDate()}</p>
                                <p><strong>Ngày kết thúc:</strong> 
                                    <c:if test="${regis.getEndDate() != null}">${regis.getEndDate()}</c:if>
                                    <c:if test="${regis.getEndDate() == null}">Không có</c:if>
                                    </p>
                                    <p><strong>Ghi chú:</strong> ${regis.getComment()}</p>
                                <p><strong>Mối quan hệ:</strong> ${regis.getRelationship()}</p>
                                <p><strong>Trạng thái:</strong>
                                    <c:if test="${regis.getStatus().equals('Pending')}">Chờ</c:if>
                                    <c:if test="${regis.getStatus().equals('PreApproved')}">Đã Sơ duyệt</c:if>
                                    <c:if test="${regis.getStatus().equals('Approved')}">Chấp nhận</c:if>
                                    </p>
                                    <button onclick="location.href = 'Household?action=registrationView&registrationID=${regis.getRegistrationID()}'">Xem</button>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

            </div>
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
