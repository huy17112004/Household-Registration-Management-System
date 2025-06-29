<%-- 
    Document   : userEdit
    Created on : Mar 2, 2025, 9:54:38 PM
    Author     : GIGABYTE
--%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    if (session.getAttribute("user") == null) { 
        response.sendRedirect(request.getContextPath() + "/signIn"); // Chuyển hướng về trang đăng nhập
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<%@page import="model.LocationService" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    </head>
    


    <body class="sub_page">
         <% User userneed = (User)(request.getAttribute("userneed"));%>
        <div>  <jsp:include page="topnavAdmin.jsp"/> </div>
        
        <br>
        


            <div class="container"> 


                <h2>Edit User</h2>
                <form action="User" method="POST">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="userID" value="${userneed.getUserID()}">

                    <div class="form-group">
                        <label>Full Name:</label>
                        <input type="text" class="form-control" name="fullname" value="<%= userneed.getFullName() %>">
                    </div>

                    <div class="form-group">
                        <label>Date Of Birth:</label>
                        <input type="date" class="form-control" name="dateofbirth" value="<%= userneed.getDateOfBirth() %>">
                    </div>

                    <div class="form-group">
                        <label>CCCD:</label>
                        <input type="text" class="form-control" name="cccd" value="<%= userneed.getCCCD() %>">
                    </div>

                    <div class="form-group">
                        <label>Email:</label>
                        <input type="text" class="form-control" name="email" value="<%= userneed.getEmail() %>">
                    </div>

                    <div class="form-group">
                        <label>Phone Number:</label>
                        <input type="text" class="form-control" name="phonenumber" value="<%= userneed.getPhoneNumber() %>">
                    </div>

                    <div class="form-group">
                        <label>Role:</label>
                        <select class="form-control" name="role">
                            <option value="Admin" <%= userneed.getRole().equals("Admin") ? "selected" : "" %>>Admin</option>
                            <option value="Citizen" <%= userneed.getRole().equals("Citizen") ? "selected" : "" %>>Citizen</option>
                            <option value="Police" <%= userneed.getRole().equals("Police") ? "selected" : "" %>>Police</option>
                            <option value="AreaLeader" <%= userneed.getRole().equals("AreaLeader") ? "selected" : "" %>>AreaLeader</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Province:</label>
                        <select id="province" class="form-control" name="provinceId">
                            <option value="">-- Chọn Tỉnh --</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>District:</label>
                        <select id="district" class="form-control" name="districtId" disabled>
                            <option value="">-- Chọn Huyện --</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Ward:</label>
                        <select id="ward" class="form-control" name="wardId" disabled>
                            <option value="">-- Chọn Xã --</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Address Detail:</label>
                        <input type="text" class="form-control" name="address" value="<%= userneed.getAddressDetail() %>">
                    </div>

                    <div class="form-group">
                        <label>Status:</label>
                        <select class="form-control" name="status">
                            <option value="Pending" <%= userneed.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="PreApproved" <%= userneed.getStatus().equals("PreApproved") ? "selected" : "" %>>PreApproved</option>
                            <option value="Approved" <%= (userneed.getStatus().equals("Approved")  || userneed.getStatus().equals("approved")) ? "selected" : "" %>>Approved</option>
                            <option value="Rejected" <%= userneed.getStatus().equals("Rejected") ? "selected" : "" %>>Rejected</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Edit User</button>
                </form>
            </div>




            <br>
            <div><jsp:include page="footer.jsp"/></div> 
        

        <script>
            $(document).ready(function () {
                let selectedProvince = "<%= userneed.getProvinceID() %>";
                let selectedDistrict = "<%= userneed.getDistrictID() %>";
                let selectedWard = "<%= userneed.getWardID() %>";

                $.get("https://provinces.open-api.vn/api/?depth=1", function (data) {
                    $.each(data, function (index, item) {
                        $('#province').append(new Option(item.name, item.code, false, item.code == selectedProvince));
                    });

                    if (selectedProvince) {
                        loadDistricts(selectedProvince, selectedDistrict, selectedWard);
                    }
                });

                $('#province').change(function () {
                    let provinceCode = $(this).val();
                    $('#district').html('<option value="">-- Chọn Huyện --</option>').prop('disabled', true);
                    $('#ward').html('<option value="">-- Chọn Xã --</option>').prop('disabled', true);

                    if (provinceCode) {
                        loadDistricts(provinceCode, "", "");
                    }
                });

                function loadDistricts(provinceCode, districtCode, wardCode) {
                    $.get("https://provinces.open-api.vn/api/p/" + provinceCode + "?depth=2", function (data) {
                        $.each(data.districts, function (index, item) {
                            $('#district').append(new Option(item.name, item.code, false, item.code == districtCode));
                        });
                        $('#district').prop('disabled', false);

                        if (districtCode) {
                            loadWards(districtCode, wardCode);
                        }
                    });
                }

                $('#district').change(function () {
                    let districtCode = $(this).val();
                    $('#ward').html('<option value="">-- Chọn Xã --</option>').prop('disabled', true);

                    if (districtCode) {
                        loadWards(districtCode, "");
                    }
                });

                function loadWards(districtCode, wardCode) {
                    $.get("https://provinces.open-api.vn/api/d/" + districtCode + "?depth=2", function (data) {
                        $.each(data.wards, function (index, item) {
                            $('#ward').append(new Option(item.name, item.code, false, item.code == wardCode));
                        });
                        $('#ward').prop('disabled', false);
                    });
                }
            });


            $(document).ready(function () {
                $("form").submit(function (event) {
                    let isValid = true;

                    // Kiểm tra họ và tên (chỉ chứa chữ cái và khoảng trắng)
                    let fullname = $("input[name='fullname']").val().trim();
                    let nameRegex = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/;
                    if (fullname === "" || !nameRegex.test(fullname)) {
                        alert("Họ và tên không hợp lệ. Chỉ được nhập chữ cái và khoảng trắng.");
                        isValid = false;
                    }

                    // Kiểm tra ngày sinh (phải nhỏ hơn ngày hiện tại)
                    let dob = new Date($("input[name='dateofbirth']").val());
                    let today = new Date();
                    if (isNaN(dob.getTime()) || dob >= today) {
                        alert("Ngày sinh không hợp lệ. Vui lòng chọn ngày sinh hợp lệ.");
                        isValid = false;
                    }

                    // Kiểm tra CCCD (chỉ chứa số, đủ 12 chữ số)
                    let cccd = $("input[name='cccd']").val().trim();
                    let cccdRegex = /^\d{12}$/;
                    if (!cccdRegex.test(cccd)) {
                        alert("CCCD không hợp lệ. Vui lòng nhập đúng 12 chữ số.");
                        isValid = false;
                    }

                    // Kiểm tra email (định dạng email hợp lệ)
                    let email = $("input[name='email']").val().trim();
                    let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email)) {
                        alert("Email không hợp lệ. Vui lòng nhập đúng định dạng email.");
                        isValid = false;
                    }

                    // Kiểm tra số điện thoại (10 chữ số, bắt đầu bằng số 0)
                    let phone = $("input[name='phonenumber']").val().trim();
                    let phoneRegex = /^0\d{9}$/;
                    if (!phoneRegex.test(phone)) {
                        alert("Số điện thoại không hợp lệ. Phải có 10 chữ số và bắt đầu bằng số 0.");
                        isValid = false;
                    }

                    

                    // Kiểm tra chọn tỉnh/thành phố, quận/huyện, phường/xã
                    if ($("#province").val() === "") {
                        alert("Vui lòng chọn tỉnh/thành phố.");
                        isValid = false;
                    }
                    if ($("#district").val() === "") {
                        alert("Vui lòng chọn quận/huyện.");
                        isValid = false;
                    }
                    if ($("#ward").val() === "") {
                        alert("Vui lòng chọn phường/xã.");
                        isValid = false;
                    }

                    // Kiểm tra địa chỉ cụ thể
                    let address = $("input[name='address']").val().trim();
                    if (address === "") {
                        alert("Vui lòng nhập địa chỉ cụ thể.");
                        isValid = false;
                    }

                    // Nếu có lỗi, ngăn form gửi đi
                    if (!isValid) {
                        event.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>