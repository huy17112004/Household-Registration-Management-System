<%-- 
    Document   : registerChildSuccess
    Created on : Mar 14, 2025, 2:46:28 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký thành công</title>
    </head>
    <body>
    <h2>Thông báo</h2>
    <p style="color: green;"><%= request.getAttribute("message") %></p>
    <a href="RegisterChildServlet">Quay lại đăng ký cho con</a>
     <form action="home" method="get">
            <input type="submit" value="Quay lại trang chủ">
        </form>
</body>
</html>
