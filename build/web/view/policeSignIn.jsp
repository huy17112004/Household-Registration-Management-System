<%-- 
    Document   : policeSignIn
    Created on : Mar 10, 2025, 6:00:14 PM
    Author     : Dell
--%>

<%@page import="model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <title>Police Dashboard</title>
        <script>
            function processUser(cccd, action) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "userAction?cccd=" + encodeURIComponent(cccd) + "&action=" + action, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var response = xhr.responseText;
                        var statusCell = document.getElementById("status-" + cccd);
                        var actionCell = document.getElementById("action-" + cccd);
                        if (response === "approved" || response === "approved_no_email") {
                            statusCell.innerHTML = "Đã duyệt";
                            actionCell.innerHTML = "Đã xử lý";
                            if (response === "approved_no_email") {
                                alert("Tài khoản đã được duyệt nhưng không gửi được email vì thiếu địa chỉ email.");
                            }
                        } else if (response === "rejected" || response === "rejected_no_email") {
                            statusCell.innerHTML = "Đã từ chối";
                            actionCell.innerHTML = "Đã xử lý";
                            if (response === "rejected_no_email") {
                                alert("Tài khoản đã bị từ chối nhưng không gửi được email vì thiếu địa chỉ email.");
                            }
                        } else {
                            statusCell.innerHTML = "Lỗi: " + response;
                            alert("Có lỗi xảy ra: " + response);
                        }
                    }
                };
                xhr.send();
            }
        </script>
    </head>
    <body class="sub_page">
        <jsp:include page="topnavPolice.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        DUYỆT NGƯỜI DÙNG TRONG XÃ
                    </h2>
                </div>
                <c:if test="${not empty error}">
                    <p style="color: red">${error}</p>
                </c:if>
                <c:if test="${empty pendingUsers}">
                    <b>Không có tài khoản nào đang chờ duyệt trong xã của bạn.</b>
                </c:if>
                <c:if test="${not empty pendingUsers}">
                    <div class="police-user-container">
                        <c:forEach items="${pendingUsers}" var="pUser">
                            <div class="police-user-card">
                                <h3>${pUser.fullName}</h3>
                                <p><strong>Ngày sinh:</strong> ${pUser.dateOfBirth}</p>
                                <p><strong>CCCD:</strong> 
                                    <c:choose>
                                        <c:when test="${fn:length(pUser.getCCCD()) > 12}">
                                            ${fn:substring(pUser.getCCCD(), 0, 12)}
                                            <br><span style="color: red;">(Đăng kí theo bố mẹ)</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${pUser.getCCCD()}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p><strong>Email:</strong> ${pUser.email}</p>
                                <p><strong>SĐT:</strong> ${pUser.phoneNumber}</p>
                                <p><strong>Địa chỉ:</strong> ${pUser.addressDetail}</p>
                                <p><strong>Trạng thái:</strong> <span class="status" id="status-${pUser.CCCD}">${pUser.status}</span></p>
                                <div>
                                    <button class="btn-action btn-approve" onclick="processUser('${pUser.CCCD}', 'approve')">Duyệt</button>
                                    <button class="btn-action btn-reject" onclick="processUser('${pUser.CCCD}', 'reject')">Từ chối</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div><!-- comment -->
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>