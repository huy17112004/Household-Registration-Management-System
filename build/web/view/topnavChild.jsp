<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Site Metas -->
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link rel="shortcut icon" href="images/favicon.png" type="image/png">

        <title> Feane </title>

        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link href="css/font-awesome.min.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />

        <!-- Added custom CSS for dropdown hover -->
        <style>
            /* Đảm bảo dropdown hiển thị khi hover */
            .navbar-nav .dropdown:hover .dropdown-menu {
                display: block;
            }

            .navbar-nav .dropdown-menu {
                background-color: #f8f9fa;  /* Chỉnh màu nền của menu */
                border-radius: 5px;          /* Bo góc cho menu */
            }

            .navbar-nav .dropdown-item:hover {
                background-color: #ddd; /* Màu nền khi hover trên các item */
            }
        </style>
    </head>
    <body>
        <div class="hero_area">
            <div class="bg-box">
                <img src="images/hinh-nen-co-viet-nam-hieu-ung-dep.jpg" alt="">
            </div>
            <!-- header section starts -->
            <header class="header_section">
                <div class="container">
                    <nav class="navbar navbar-expand-lg custom_nav-container">
                        <a class="navbar-brand" href="index.jsp">
                            <span> HHK </span>
                        </a>

                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class=""> </span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mx-auto">

                                <!-- Dropdown menu for Viết Đơn -->
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Viết Đơn Cho Người Thân
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="Household?action=permanent&childID=${childID}">Đăng Kí Thường Trú</a>
                                        <a class="dropdown-item" href="Household?action=temporary&childID=${childID}">Đăng Kí Tạm Trú</a>
                                        <a class="dropdown-item" href="Household?action=temporaryStay&childID=${childID}">Đăng Kí Tạm Vắng</a>
                                    </div>
                                </li>
                            </ul>

                            <div class="user_option">
                                    <a href="Household" class="order_online">Trở lại tài khoản chính</a>
                            </div>
                        </div>
                    </nav>
                </div>
            </header>

            <!-- end header section -->
        </div>

        <!-- jQuery and Bootstrap JS (Bootstrap requires jQuery) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
