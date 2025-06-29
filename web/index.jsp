<%-- 
    Document   : index
    Created on : Mar 5, 2025, 10:46:23 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>index</h1>
        <% response.sendRedirect(request.getContextPath() + "/Login"); %>
    </body>
</html>
