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

        <title> Nhận OTP </title>

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
    <body class="sub_page">

      
            <jsp:include page="topnav.jsp"/>
     
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
                    max-width: 400px; /* Giới hạn chiều rộng form */
                    margin: 0 auto; /* Căn giữa form */
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
                    text-align: center; /* Căn giữa tiêu đề */
                    width: 100%;
                }

                .heading_container h2::after {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 50%;
                    transform: translateX(-50%);
                    width: 40%;
                    height: 3px;
                    background-color: #ffbe33;
                    transition: 0.5s ease;
                }

                .heading_container:hover h2::after {
                    width: 60%;
                }

                /* Căn giữa các phần tử trong form */
                .btn_box, .form_container a {
                    text-align: center;
                    display: block;
                }
            </style>
            <body>
                <section class="book_section layout_padding">
                    <div class="container">
                        <div class="heading_container">
                            <h2>
                                Xác nhận OTP
                            </h2>
                        </div>
                        <div class="row">
                            <div class="col-md-12"> <!-- Sử dụng full width và căn giữa bằng CSS -->
                                <div class="form_container">
                                    <c:if test="${not empty message}">
                                        <p style="color: green; text-align: center;">${message}</p>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <p style="color: red; text-align: center;">${error}</p>
                                    </c:if>
                                    <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
                                        <div>
                                            <input type="hidden" name="action" value="verifyOTP">
                                            <input type="text" id="otp" name="otp" class="form-control" placeholder="Nhập Mã OTP" required>
                                        </div>
                                        <div class="btn_box">
                                            <button type="submit">
                                                Xác nhận
                                            </button>
                                        </div>    
                                        <br>
                                        <a href="forgotPassword">Yêu cầu OTP mới</a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <jsp:include page="footer.jsp"/>
                <%-- <div>
                    <h2>Xác nhận OTP</h2>
                    <c:if test="${not empty message}">
                        <p style="color: green">${message}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red">${error}</p>
                    </c:if>
                    <form action="forgotPassword" method="post">
                        <input type="hidden" name="action" value="verifyOTP">
                        <label for="otp">Nhập mã OTP:</label>
                        <input type="text" id="otp" name="otp" required><br>
                        <button type="submit">Xác nhận</button>
                    </form>
                    <a href="forgotPassword">Yêu cầu OTP mới</a>
                </div> --%>
            </body>
</html>