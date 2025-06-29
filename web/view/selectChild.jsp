<%-- 
    Document   : selectChild
    Created on : Mar 14, 2025, 2:44:25 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chọn con để chỉnh sửa</title>
        <style>
            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            .child-form {
                display: flex;
                flex-direction: column;
                gap: 10px;
                max-width: 400px;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            select {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 100%;
            }
            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }
            button:hover {
                background-color: #0056b3;
            }
            .no-child {
                text-align: center;
                margin-top: 20px;
                font-size: 16px;
            }
            .no-child a {
                display: inline-block;
                margin-top: 10px;
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }
            .no-child a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Chọn Con Để Chỉnh Sửa Thông Tin
                    </h2>
                </div>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <p><%= request.getAttribute("error") %></p>
                    </div>
                <% } %>
                <% List<User> children = (List<User>) request.getAttribute("children"); %>
                <% if (children != null && !children.isEmpty()) { %>
                    <form class="child-form" action="RegisterChildServlet" method="get">
                        <input type="hidden" name="action" value="editChild">
                        <select name="childCCCD" required>
                            <% for (User child : children) { %>
                                <option value="<%= child.getCCCD() %>">
                                    <%= child.getFullName() %> (CCCD: <%= child.getCCCD() %>)
                                </option>
                            <% } %>
                        </select>
                        <button type="submit">Chỉnh sửa</button>
                    </form>
                <% } else { %>
                    <div class="no-child">
                        <p>Chưa có con nào được đăng ký với CCCD của bố/mẹ này.</p>
                        <a href="RegisterChildServlet">Quay lại</a>
                    </div>
                <% } %>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
