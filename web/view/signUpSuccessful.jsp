<%-- 
    Document   : signUpSuccessful
    Created on : Mar 4, 2025, 10:18:46 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký thành công</title>
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
        <style>
            /* Reset default styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Arial', sans-serif;
            }

            /* Section styling */
            .book_section {
                padding: 100px 0; /* Tăng padding để tránh bị che bởi topnav */
                position: relative; /* Đảm bảo section có vị trí tương đối */
                z-index: 10; /* Đặt z-index cao hơn để hiển thị trên hình nền */
                background: transparent; /* Đảm bảo không có nền che khuất hình nền */
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                text-align: center;
            }

            /* Tăng độ nổi bật cho form */
            .form_container {
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
                padding: 40px 25px;
                border-radius: 12px;
                background-color: rgba(255, 255, 255, 0.95);
                transform: translateY(15px);
                opacity: 0;
                animation: fadeInUp 0.7s forwards;
                max-width: 500px;
                margin: 0 auto;
                min-height: 250px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            /* Hiệu ứng xuất hiện mềm mại */
            @keyframes fadeInUp {
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Cải thiện nút bấm */
            .btn_box button {
                transition: 0.3s;
                border-radius: 25px;
                padding: 10px 30px;
                font-size: 1.2rem;
                font-weight: 600;
                color: #fff;
                background: #28a745; /* Màu xanh lá cho nút "Quay Về Trang Chủ" */
                border: none;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            }

            .btn_box button:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 16px rgba(40, 167, 69, 0.5);
                background: #218838; /* Màu xanh lá đậm hơn khi hover */
            }

            .btn_box button:active {
                transform: translateY(0);
                box-shadow: 0 3px 10px rgba(40, 167, 69, 0.2);
            }

            /* Secondary button (Quay lại trang đăng ký) */
            .btn_box:nth-child(2) button {
                background: #fd7e14; /* Màu cam cho nút "Quay lại trang đăng ký" */
                box-shadow: 0 5px 15px rgba(253, 126, 20, 0.3);
            }

            .btn_box:nth-child(2) button:hover {
                background: #e06c00; /* Màu cam đậm hơn khi hover */
                box-shadow: 0 8px 16px rgba(253, 126, 20, 0.5);
            }

            .btn_box:nth-child(2) button:active {
                box-shadow: 0 3px 10px rgba(253, 126, 20, 0.2);
            }

            /* Hiệu ứng cho tiêu đề */
            .heading_container h2 {
                position: relative;
                display: inline-block;
                padding-bottom: 5px;
                font-weight: bold;
                text-align: center;
                width: 100%;
                font-size: 1.5rem;
                color: #333;
                margin-bottom: 25px;
                line-height: 1.5;
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
            .btn_box {
                text-align: center;
                display: block;
                margin: 15px 0;
            }

            
        </style>
        
    <jsp:include page="topnav.jsp"/>

        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Tài khoản của bạn đã được ghi nhận. Vui lòng đợi được phê duyệt. 
                        Chúng tôi sẽ gửi thông báo đến mail bạn đã đăng kí.
                    </h2>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form_container">
                            <form action="home" method="get">
                                <div class="btn_box">
                                    <button type="submit">
                                        Quay Về Trang Chủ
                                    </button>
                                </div>    
                            </form>
                            <form action="signUp" method="get">
                                <div class="btn_box">
                                    <button type="submit">
                                        Quay lại trang đăng ký
                                    </button>
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