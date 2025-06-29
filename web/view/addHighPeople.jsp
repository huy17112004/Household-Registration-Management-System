<%-- 
    Document   : addHighPeople
    Created on : Mar 19, 2025, 3:30:44 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title> Feane </title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" /> 
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="js/jquery-3.4.1.min.js"></script>
        <script>
            $(document).ready(function () {
                // Lấy danh sách tỉnh khi tải trang
                $.get("https://provinces.open-api.vn/api/?depth=1", function (data) {
                    $.each(data, function (index, item) {
                        $('#province').append($('<option>', {
                            value: item.code,
                            text: item.name
                        }));
                    });
                });

                // Khi chọn tỉnh, lấy danh sách huyện
                $('#province').change(function () {
                    let provinceCode = $(this).val();
                    $('#district').html('<option value="">-- Chọn Huyện --</option>').prop('disabled', true);
                    $('#ward').html('<option value="">-- Chọn Xã --</option>').prop('disabled', true);

                    if (provinceCode) {
                        $.get("https://provinces.open-api.vn/api/p/" + provinceCode + "?depth=2", function (data) {
                            $.each(data.districts, function (index, item) {
                                $('#district').append($('<option>', {
                                    value: item.code,
                                    text: item.name
                                }));
                            });
                            $('#district').prop('disabled', false);
                        });
                    }
                });

                // Khi chọn huyện, lấy danh sách xã
                $('#district').change(function () {
                    let districtCode = $(this).val();
                    $('#ward').html('<option value="">-- Chọn Xã --</option>').prop('disabled', true);

                    if (districtCode) {
                        $.get("https://provinces.open-api.vn/api/d/" + districtCode + "?depth=2", function (data) {
                            $.each(data.wards, function (index, item) {
                                $('#ward').append($('<option>', {
                                    value: item.code,
                                    text: item.name
                                }));
                            });
                            $('#ward').prop('disabled', false);
                        });
                    }
                });
            });
        </script>
    </head>
    <body class="sub_page">
        <jsp:include page="topnavAdmin.jsp"/>
        <br>



        <div class="container mt-4">
            <h3 class="mb-3">Thêm người dùng cấp cao</h3>
            <form action="User" method="POST" class="p-4 border rounded shadow-sm bg-light">
                <input type="hidden" name="action" value="addHighPeople">

                <div class="mb-3">
                    <label for="fullName" class="form-label">Tên đầy đủ:</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="userName" class="form-label">Tên tài khoản:</label>
                    <input type="text" id="userName" name="userName" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label">Chức năng:</label>
                    <select id="role" name="role" class="form-select">
                        <option value="AreaLeader">Tổ trưởng khu phố</option>
                        <option value="Police">Công an</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="province" class="form-label">Tỉnh/Thành phố:</label>
                    <select id="province" name="provinceID" class="form-select">
                        <option value="">-- Chọn Tỉnh --</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="district" class="form-label">Quận/Huyện:</label>
                    <select id="district" name="districtID" class="form-select" disabled>
                        <option value="">-- Chọn Huyện --</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="ward" class="form-label">Phường/Xã:</label>
                    <select id="ward" name="wardID" class="form-select" disabled>
                        <option value="">-- Chọn Xã --</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="addressDetail" class="form-label">Địa chỉ cụ thể:</label>
                    <input type="text" id="addressDetail" name="addressDetail" class="form-control">
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Thêm</button>
                </div>
            </form>
        </div>

        <br>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
