<%-- 
    Document   : resetPassword
    Created on : Mar 18, 2025, 10:03:04 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
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
        <link rel="shortcut icon" href="images/favicon.png" type="">

        <title> Đặt lại mật khẩu </title>

        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

        <!--owl slider stylesheet -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
        <!-- nice select  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
        <!-- font awesome style -->
        <link href="css/font-awesome.min.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="css/responsive.css" rel="stylesheet" />
    </head>
    <body  class="sub_page">
        <div class="hero_area">
            <div class="bg-box">
                <img src="images/" alt="">
            </div>
            <!-- header section strats -->
            <jsp:include page="topnav.jsp"/>
            <!-- end header section -->

            <style>
                /* Tăng độ nổi bật cho form quên mật khẩu */
                .form_container {
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
                    padding: 25px;
                    border-radius: 12px;
                    background-color: rgba(255, 255, 255, 0.95);
                    transform: translateY(15px);
                    opacity: 0;
                    animation: fadeInUp 0.7s forwards;
                }

                /* Hiệu ứng xuất hiện mềm mại */
                @keyframes fadeInUp {
                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                /* Tối ưu input */
                .input-group {
                    position: relative;
                    margin-bottom: 18px;
                }

                .input-group i {
                    position: absolute;
                    left: 14px;
                    top: 12px;
                    color: #ffbe33;
                }

                .form-control {
                    padding-left: 42px;
                    border-radius: 25px;
                    border: 1px solid #ccc;
                    transition: 0.3s ease-in-out;
                }

                .form-control:focus {
                    box-shadow: 0 0 6px rgba(255, 190, 51, 0.4);
                    border-color: #ffbe33;
                }

                /* Cải thiện nút bấm */
                .btn_box button {
                    transition: 0.3s;
                    border-radius: 25px;
                    padding: 5px 20px;
                    /*                    font-weight: bold;*/
                }

                .btn_box button:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                }

                /* Hiệu ứng cho tiêu đề */
                .heading_container h2 {
                    position: relative;
                    display: inline-block;
                    padding-bottom: 5px;
                    font-weight: bold;
                }

                .heading_container h2::after {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    width: 40%;
                    height: 3px;
                    background-color: #ffbe33;
                    transition: 0.5s ease;
                }

                .heading_container:hover h2::after {
                    width: 100%;
                }

                /* Cải thiện giao diện bản đồ */
                .map_container {
                    position: relative;
                    overflow: hidden;
                    border-radius: 12px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    transform: translateY(15px);
                    opacity: 0;
                    animation: fadeInUp 0.9s 0.3s forwards;
                }

                .map_container img {
                    transition: 4s ease;
                    width: 100% !important;
                    height: auto !important;
                }

                .map_container:hover img {
                    transform: scale(1.03);
                }

                /* Điểm nhấn trên bản đồ */
                .map_point {
                    position: absolute;
                    width: 12px;
                    height: 12px;
                    background-color: #ffbe33;
                    border-radius: 50%;
                    animation: pulse 1.8s infinite;
                }

                .map_point:nth-child(1) {
                    top: 25%;
                    left: 40%;
                }
                .map_point:nth-child(2) {
                    top: 40%;
                    left: 60%;
                }
                .map_point:nth-child(3) {
                    top: 60%;
                    left: 45%;
                }

                /* Hiệu ứng chớp nháy */
                @keyframes pulse {
                    0% {
                        transform: scale(0.8);
                        box-shadow: 0 0 0 0 rgba(255, 190, 51, 0.6);
                    }
                    70% {
                        transform: scale(1);
                        box-shadow: 0 0 0 8px rgba(255, 190, 51, 0);
                    }
                    100% {
                        transform: scale(0.8);
                    }
                }

                /* Hiệu ứng badge nhỏ */
                .auth-badge {
                    display: inline-block;
                    padding: 5px 12px;
                    margin-top: 15px;
                    background-color: #f8f9fa;
                    border-radius: 18px;
                    font-size: 0.85rem;
                    color: #6c757d;
                    border: 1px solid #e9ecef;
                }

                .auth-badge i {
                    margin-right: 4px;
                    color: #28a745;
                }

                /* Loader khi tải */
                .loader {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.7);
                    z-index: 9999;
                    justify-content: center;
                    align-items: center;
                }

                .loader-content {
                    width: 50px;
                    height: 50px;
                    border: 5px solid #f3f3f3;
                    border-top: 5px solid #ffbe33;
                    border-radius: 50%;
                    animation: spin 2s linear infinite;
                }

                @keyframes spin {
                    0% {
                        transform: rotate(0deg);
                    }
                    100% {
                        transform: rotate(360deg);
                    }
                }

            </style>  
            <body>
                <section class="book_section layout_padding">
                    <div class="container">
                        <div class="heading_container">
                            <h2>
                                Đặt lại mật khẩu
                            </h2>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form_container">
                                    <c:if test="${not empty error}">
                                        <p style="color: red">${error}</p>
                                    </c:if>
                                        <c:if test="${not empty message}">
                            <div class="success" style="color: green; text-align: center;">
                                ${message}
                            </div>
                             </c:if>
                                    <form action="${pageContext.request.contextPath}/resetPassword" method="post">

                                        <div>
                                          
                                            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
                                        </div>
                                        <div>
                                           
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required>
                                        </div>
                                        <div class="btn_box">
                                            <button type="submit">
                                                Cập Nhật Mật Khẩu
                                            </button>
                                        </div>    
                                        <br>
                                        <a href="signIn">Quay lại đăng nhập ?</a>
                                        <br><!-- comment -->
                                    </form>

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="map_container">
                                    <img src="images/BDVN.png" alt="Bản đồ" style="width: 69%; height: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <jsp:include page="footer.jsp"/>
            </body>
</html>
