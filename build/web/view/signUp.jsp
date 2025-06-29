<%-- 
    Document   : signUp
    Created on : Mar 4, 2025, 8:57:45 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Site Metas -->
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link rel="shortcut icon" href="images/favicon.png" type="">

        <title> Đăng Kí Tài Khoản </title>

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
/* Căn giữa section trên toàn bộ trang */
.book_section {
    padding: 0; /* Bỏ padding để không tạo khoảng cách thừa */
    min-height: 100vh; /* Đảm bảo section chiếm toàn bộ chiều cao màn hình */
    display: flex;
    justify-content: center; /* Căn giữa theo chiều ngang */
    align-items: center; /* Căn giữa theo chiều dọc */
    box-sizing: border-box;
}

/* Hiệu ứng xuất hiện mềm mại */
@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Tăng độ nổi bật cho form và làm to hơn */
.form_container {
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15); /* Bóng đổ nhẹ */
    padding: 30px; /* Tăng padding để form rộng rãi hơn */
    border-radius: 12px; /* Bo góc form */
    background-color: rgba(255, 255, 255, 0.95); /* Nền trắng nhẹ */
    transform: translateY(15px);
    opacity: 0;
    animation: fadeInUp 0.7s forwards; /* Hiệu ứng xuất hiện */
    max-width: 600px; /* Tăng chiều rộng tối đa của form (trước là 500px) */
    margin: 0 auto; /* Căn giữa form trong container */
}

/* Hiệu ứng cho tiêu đề */
.heading_container {
    text-align: center;
    margin-bottom: 40px;
}

.heading_container h2 {
    position: relative;
    display: inline-block;
    padding-bottom: 5px;
    font-size: 2.8rem; /* Tăng kích thước font tiêu đề (trước là 2.5rem) */
    color: #333;
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
    background-color: #6c757d; /* Màu xám */
    transition: 0.5s ease;
}

.heading_container:hover h2::after {
    width: 60%; /* Hiệu ứng mở rộng gạch chân khi hover */
}

/* Tùy chỉnh các input */
.form_container input[type="text"],
.form_container input[type="email"],
.form_container input[type="password"],
.form_container input[type="date"] {
    width: 100%;
    padding: 12px 18px; /* Tăng padding để ô nhập liệu lớn hơn */
    margin: 10px 0; /* Tăng khoảng cách giữa các ô */
    border: 1px solid #ccc;
    border-radius: 5px; /* Bo góc nhẹ */
    font-size: 1.1rem; /* Tăng kích thước font (trước là 1rem) */
    transition: 0.3s ease-in-out;
    background-color: #fff;
}

.form_container input:focus {
    outline: none;
    border: 1px solid #ccc; /* Giữ viền xám khi focus */
    box-shadow: 0 0 6px rgba(0, 0, 0, 0.1); /* Bóng nhẹ khi focus */
}

/* Tùy chỉnh select */
.form_container .select-box select {
    width: 100%;
    padding: 12px 18px; /* Tăng padding */
    margin: 10px 0; /* Tăng khoảng cách */
    border: 1px solid #ccc;
    border-radius: 5px; /* Bo góc nhẹ */
    font-size: 1.1rem; /* Tăng kích thước font */
    background-color: #fff;
    appearance: none; /* Xóa giao diện mặc định của select */
    cursor: pointer;
    transition: 0.3s ease-in-out;
}

.form_container .select-box {
    position: relative;
}

.form_container .select-box::after {
    content: '▼';
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #666;
    font-size: 0.8rem; /* Giảm kích thước mũi tên (trước là kích thước mặc định) */
    pointer-events: none;
}

.form_container select:focus {
    outline: none;
    border: 1px solid #ccc; /* Giữ viền xám khi focus */
    box-shadow: 0 0 6px rgba(0, 0, 0, 0.1); /* Bóng nhẹ khi focus */
}

/* Tùy chỉnh nhãn (placeholder bên ngoài) */
.form_container label, /* Nếu bạn thêm thẻ label */
.form_container input::placeholder,
.form_container select::placeholder {
    font-size: 1.1rem; /* Tăng kích thước font của nhãn */
    color: #666;
}

/* Tùy chỉnh thông báo lỗi 
.form_container p[style*="color: red"] {
    font-size: 1rem;  Tăng kích thước font thông báo lỗi 
    margin: 8px 0;
    color: #ff0000;  Giữ màu đỏ cho thông báo lỗi 
    text-align: center;  Căn giữa thông báo lỗi 
}*/

/* Tùy chỉnh nút Đăng Kí */
.btn_box {
    text-align: center;
    margin-top: 25px; /* Tăng khoảng cách với các ô phía trên */
    display: block; /* Đảm bảo căn giữa */
}

.btn_box button {
    background-color: #fff; /* Nền trắng */
    color: #333; /* Chữ màu đen */
    padding: 12px 40px; /* Tăng padding để nút lớn hơn */
    border: 1px solid #6c757d; /* Viền xám */
    border-radius: 25px; /* Bo góc */
    font-size: 1.2rem; /* Tăng kích thước font (trước là 1.1rem) */
    cursor: pointer;
    transition: 0.3s ease; /* Hiệu ứng mượt mà */
}

.btn_box button:hover {
    background-color: #f8f9fa; /* Nền xám nhạt khi hover */
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng khi hover */
}

.btn_box button:active {
    transform: translateY(0);
}

            </style>
            
                <section class="book_section layout_padding">
                    <div class="container">
                        <div class="heading_container">
                            <h2>
                                Đăng Kí Tài Khoản
                            </h2>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form_container">
                                    <c:if test="${not empty message}">
                                            <p style="color: red">${message}</p>
                                        </c:if>
                                        <c:if test="${not empty errors.locationError}">
                                            <p style="color: red">${errors.locationError}</p>
                                        </c:if>
                                    <form action="signUp" method="post">
                                        
                                        <div>
                                            <input type="text" name="fullname" value="${fullname}" placeholder="Họ và Tên" required />

                                        </div>
                                        <div>
                                            <input type="date" name="dateofbirth" value="${dateofbirth}" placeholder="Ngày Tháng Năm Sinh" required />
                                        </div>
                                        <div>
                                            <input type="text" name="cccd" value="${cccd}" placeholder="CCCD" required />
                                            <c:if test="${not empty errors.cccdError}">
                                                <p style="color: red">${errors.cccdError}</p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <input type="email" name="email" value="${email}" placeholder="Email" required />
                                            <c:if test="${not empty errors.emailError}">
                                                <p style="color: red">${errors.emailError}</p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <input type="text" name="phonenumber" value="${phonenumber}" placeholder="Số Điện Thoại" required />
                                            <c:if test="${not empty errors.phoneError}">
                                                <p style="color: red">${errors.phoneError}</p>
                                            </c:if>
                                        </div>
                                        <div>
                                            <input type="password" id="password" name="password" value="${password}" placeholder="Mật Khẩu" required />
                                        </div>
                                        <div>
                                            <input type="password" id="confirmpassword" name="confirmpassword" value="${confirmpassword}" placeholder="Xác Nhận Mật Khẩu" required />
                                            <c:if test="${not empty errors.passwordError}">
                                                <p style="color: red">${errors.passwordError}</p>
                                            </c:if>
                                        </div>
                                        <div class="input-box address">
                                            <div class="select-box">
                                                <select id="province" name="provinceid" onchange="this.form.submit()" required>
                                                    <option value="" hidden>Chọn Tỉnh/Thành phố</option>
                                                    <c:forEach var="province" items="${provinces}">
                                                        <option value="${province.code}" ${province.code == param.provinceid || province.code == requestScope.provinceId ? 'selected' : ''}>${province.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="select-box">
                                                <select id="district" name="districtid" onchange="this.form.submit()" required>
                                                    <option value="" hidden>Chọn Quận/Huyện</option>
                                                    <c:forEach var="district" items="${districts}">
                                                        <option value="${district.code}" ${district.code == param.districtid || district.code == requestScope.districtId ? 'selected' : ''}>${district.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="select-box">
                                                <select id="ward" name="wardid" required>
                                                    <option value="" hidden>Chọn Xã/Phường</option>
                                                    <c:forEach var="ward" items="${wards}">
                                                        <option value="${ward.code}" ${ward.code == param.wardid || ward.code == requestScope.wardId ? 'selected' : ''}>${ward.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div>
                                                <input type="text" name="addressdetail" value="${addressdetail}" placeholder="Địa Chỉ Cụ Thể" required />
                                            </div>
                                            <div class="btn_box">
                                                <button type="submit" name="action" value="register">
                                                    Đăng Kí
                                                </button>
                                            </div>   
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                </section>
                <%--                <section class="container">
                                    <header>Đăng ký tài khoản</header>
                                    <form action="signUp" method="post" class="form">
                                        <c:if test="${not empty message}">
                                            <p style="color: red">${message}</p>
                                        </c:if>
                                        <c:if test="${not empty errors.locationError}">
                                            <p style="color: red">${errors.locationError}</p>
                                        </c:if>

                        <div class="input-box">
                            <label>Họ và tên</label>
                            <input type="text" name="fullname" value="${fullname}" placeholder="Nhập họ và tên" required />
                        </div>

                        <div class="input-box">
                            <label>Ngày sinh</label>
                            <input type="date" name="dateofbirth" value="${dateofbirth}" required />
                        </div>

                        <div class="input-box">
                            <label>CCCD</label>
                            <input type="text" name="cccd" value="${cccd}" placeholder="Nhập số CCCD" required />
                            <c:if test="${not empty errors.cccdError}">
                                <p style="color: red">${errors.cccdError}</p>
                            </c:if>
                        </div>

                        <div class="input-box">
                            <label>Email</label>
                            <input type="email" name="email" value="${email}" placeholder="Nhập địa chỉ email" required />
                            <c:if test="${not empty errors.emailError}">
                                <p style="color: red">${errors.emailError}</p>
                            </c:if>
                        </div>

                        <div class="input-box">
                            <label>Số điện thoại</label>
                            <input type="text" name="phonenumber" value="${phonenumber}" placeholder="Nhập số điện thoại" required />
                            <c:if test="${not empty errors.phoneError}">
                                <p style="color: red">${errors.phoneError}</p>
                            </c:if>
                        </div>

                        <div class="input-box" style="position: relative;">
                            <label>Mật khẩu</label>
                            <input type="password" id="password" name="password" value="${password}" placeholder="Nhập mật khẩu" required />
                            <span onclick="togglePassword('password', this)" style="position:absolute; right:10px; top:70%; transform:translateY(-50%); cursor:pointer;">👁️</span>
                        </div>

                        <div class="input-box" style="position: relative;">
                            <label>Nhập lại mật khẩu</label>
                            <input type="password" id="confirmpassword" name="confirmpassword" value="${confirmpassword}" placeholder="Nhập lại mật khẩu" required />
                            <span onclick="togglePassword('confirmpassword', this)" style="position:absolute; right:10px; top:70%; transform:translateY(-50%); cursor:pointer;">👁️</span>
                            <c:if test="${not empty errors.passwordError}">
                                <p style="color: red">${errors.passwordError}</p>
                            </c:if>
                        </div>

                        <div class="input-box address">
                            <label>Địa chỉ</label>
                            <div class="select-box">
                                <select id="province" name="provinceid" onchange="this.form.submit()" required>
                                    <option value="" hidden>Chọn Tỉnh/Thành phố</option>
                                    <c:forEach var="province" items="${provinces}">
                                        <option value="${province.code}" ${province.code == param.provinceid || province.code == requestScope.provinceId ? 'selected' : ''}>${province.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="select-box">
                                <select id="district" name="districtid" onchange="this.form.submit()" required>
                                    <option value="" hidden>Chọn Quận/Huyện</option>
                                    <c:forEach var="district" items="${districts}">
                                        <option value="${district.code}" ${district.code == param.districtid || district.code == requestScope.districtId ? 'selected' : ''}>${district.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="select-box">
                                <select id="ward" name="wardid" required>
                                    <option value="" hidden>Chọn Xã/Phường</option>
                                    <c:forEach var="ward" items="${wards}">
                                        <option value="${ward.code}" ${ward.code == param.wardid || ward.code == requestScope.wardId ? 'selected' : ''}>${ward.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <input type="text" name="addressdetail" value="${addressdetail}" placeholder="Nhập địa chỉ chi tiết" required />
                        </div>

                        <button type="submit" name="action" value="register">Đăng ký</button>
                    </form>
                </section>--%>
                <jsp:include page="footer.jsp"/>

            </body>
</html>

