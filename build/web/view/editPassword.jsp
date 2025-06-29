<%-- 
    Document   : editPassword
    Created on : Mar 18, 2025, 5:08:57 PM
    Author     : GIGABYTE
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
                    <h2>THAY ĐỔI MẬT KHẨU</h2>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form_container">
                            <form action="User" method="GET">
                                <input type="hidden" name="action" value="editpassword">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                                <label>Nhập lại mật khẩu cũ:</label>
                                                <input type="password" name="oldpass" class="form-control"/>
                                        <c:if test="${error1 != null}"> <i style="color: red">${error1}</i></c:if>
                                        </div>
                                        <div class="mb-3">
                                                <label>Nhập mật khẩu mới:</label>
                                                <input type="password" name="newpass" class="form-control"/>
                                        </div>
                                        <div class="mb-3">
                                                <label>Xác nhận mật khẩu mới:</label>
                                                <input type="password" name="xacnhan" class="form-control"/>
                                                <c:if test="${error2 != null}"> <i style="color: red">${error2}</i></c:if>
                                        </div>
                                        <input type="submit" value="Chỉnh sửa">
                                        <input type="button" value="Quay lại" onclick="location.href = 'User?action=viewSelf'">
                                    </div>
                                        
                                </div>
                                    
                                       
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </section>
                                        <jsp:include page="footer.jsp"/>
    </body>
</html>
