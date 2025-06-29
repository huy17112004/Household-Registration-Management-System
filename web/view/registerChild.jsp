<%-- 
    Document   : registerChild
    Created on : Mar 14, 2025, 2:35:24 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký hộ khẩu cho con</title>
        <style>
            form {
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
            label {
                font-weight: bold;
            }
            input[type="text"] {
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
            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Đăng Ký Hộ Khẩu Cho Con
                    </h2>
                </div>
                <form action="RegisterChildServlet" method="get">
                    <input type="hidden" name="action" value="checkParent">
                    <label for="parentCCCD">CCCD của bố hoặc mẹ:</label>
                    <input type="text" id="parentCCCD" name="parentCCCD" required pattern="\d{12}" title="CCCD phải là 12 chữ số">
                    <button type="submit">Kiểm tra</button>
                </form>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <p><%= request.getAttribute("error") %></p>
                    </div>
                <% } %>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>