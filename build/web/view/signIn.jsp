<%-- 
    Document   : signIn
    Created on : Mar 15, 2025, 12:54:33 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

  <title> Feane </title>

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
      <img src="images/hero-bg.jpg" alt="">
    </div>
    <!-- header section strats -->
    <jsp:include page="topnav.jsp"/>
    <!-- end header section -->
    <style>
            /* Thêm CSS tùy chỉnh cho trang đăng nhập */
            .form_container {
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                padding: 30px;
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0.95);
                transform: translateY(20px);
                opacity: 0;
                animation: fadeInUp 0.8s forwards;
            }
            
            @keyframes fadeInUp {
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .input-group {
                position: relative;
                margin-bottom: 20px;
            }
            
            .input-group i {
                position: absolute;
                left: 15px;
                top: 13px;
                color: #ffbe33;
            }
            
            .form-control {
                padding-left: 40px;
                border-radius: 30px;
                border: 1px solid #ced4da;
                transition: all 0.3s ease;
            }
            
            .form-control:focus {
                box-shadow: 0 0 0 3px rgba(255, 190, 51, 0.3);
                border-color: #ffbe33;
            }
            
            .btn_box button {
                transition: all 0.3s ease;
                border-radius: 30px;
                padding: 5px 20px;
            }
            
            .btn_box button:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            
            .form-links a {
                color: #ffbe33;
                transition: all 0.3s ease;
                text-decoration: none;
            }
            
            .form-links a:hover {
                color: #e69c00;
                text-decoration: underline;
            }
            
            .map_container {
                position: relative;
                overflow: hidden;
                border-radius: 10px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                transform: translateY(20px);
                opacity: 0;
                animation: fadeInUp 1s 0.3s forwards;
            }
            
            .map_container img {
                transition: all 5s ease;
                width: 100% !important;
                height: 100% !important;
            }
            
            .map_container:hover img {
                transform: scale(1.05);
            }
            
            .map_point {
                position: absolute;
                width: 12px;
                height: 12px;
                background-color: #ffbe33;
                border-radius: 50%;
                animation: pulse 2s infinite;
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
            
            @keyframes pulse {
                0% {
                    transform: scale(0.8);
                    box-shadow: 0 0 0 0 rgba(255, 190, 51, 0.7);
                }
                70% {
                    transform: scale(1);
                    box-shadow: 0 0 0 10px rgba(255, 190, 51, 0);
                }
                100% {
                    transform: scale(0.8);
                }
            }
            
            .heading_container h2 {
                position: relative;
                display: inline-block;
                padding-bottom: 10px;
            }
            
            .heading_container h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 40%;
                height: 3px;
                background-color: #ffbe33;
                transition: all 0.5s ease;
            }
            
            .heading_container:hover h2::after {
                width: 100%;
            }
            
            .auth-badge {
                display: inline-block;
                padding: 5px 15px;
                margin-top: 20px;
                background-color: #f8f9fa;
                border-radius: 20px;
                font-size: 0.9rem;
                color: #6c757d;
                border: 1px solid #e9ecef;
            }
            
            .auth-badge i {
                margin-right: 5px;
                color: #28a745;
            }
            
            .custom-shape {
                position: absolute;
                bottom: -50px;
                right: -50px;
                width: 200px;
                height: 200px;
                background-color: rgba(255, 190, 51, 0.1);
                border-radius: 50%;
                z-index: -1;
            }
            
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
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
  </div>

  <!-- book section -->
  <section class="book_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <h2>
          Đăng Nhập
        </h2>
          
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form_container">
              <c:if test="${not empty error}">
                <p style="color: red">${error}</p>
            </c:if>
            <form action="signIn" method="post">
                
              <div>
                  <input type="hidden" name="action" value="login">
                <input type="text" id="userInput" name="userInput" class="form-control" placeholder="Căn Cước Công Dân" value="${requestScope.userInput != null ? requestScope.userInput : ''}"/>
                
              </div>
              <div>
                  <input type="hidden" name="action" value="login">
                  <input type="password" id="password" name="password" class="form-control" placeholder="Mật Khẩu" />
              </div>
              <div class="btn_box">
                <button type="submit">
                  Đăng Nhập
                </button>
              </div>    
                <br>
                <a href="forgotPassword">Quên mật khẩu?</a>
                <br><!-- comment -->
                <br>
                <label>Bạn chưa có tài khoản?</label>  <a href="signUp">Đăng kí ngay</a><br>
                <label>Đăng kí tài khoản theo bố mẹ?</label>  <a href="RegisterChildServlet">Đăng kí ngay</a>
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
  <!-- end book section -->

  <!-- footer section -->
  <jsp:include page="footer.jsp"/>
  <!-- footer section -->

  <!-- jQery -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- isotope js -->
  <script src="https://unpkg.com/isotope-layout@3.0.4/dist/isotope.pkgd.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  <!-- Google Map -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
  </script>
<%-- 
        <div>
            <h2>Đăng nhập</h2>
            <c:if test="${not empty error}">
                <p style="color: red">${error}</p>
            </c:if>
            <form action="signIn" method="post">
                <input type="hidden" name="action" value="login">
                <label for="userInput">Số điện thoại hoặc Email:</label>
                <input type="text" id="userInput" name="userInput" value="${requestScope.userInput != null ? requestScope.userInput : ''}" /><br>
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" /><br>
                <button type="submit">Đăng nhập</button>
            </form>
            <a href="forgotPassword">Quên mật khẩu?</a>
        </div> --%>
    </body>
</html>