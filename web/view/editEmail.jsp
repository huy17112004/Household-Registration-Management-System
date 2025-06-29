<%-- 
    Document   : editEmail
    Created on : Mar 18, 2025, 4:30:05 PM
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
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>CHỈNH SỬA EMAIL, SỐ ĐIỆN THOẠI</h2>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form_container">
                            <form action="User" method="GET">
                                <input type="hidden" name="action" value="editok">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                                <label>Email:</label>
                                                <input type="text" name="email" value="${email}" class="form-control"/>
                                        </div>
                                        <div class="mb-3">
                                                <label>Số điện thoại:</label>
                                                <input type="text" name="phonenumber" value="${phonenumber}" class="form-control"/>
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
