<%-- 
    Document   : addChild
    Created on : Mar 15, 2025, 3:22:38 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>JSP Page</title>
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
        <jsp:include page="topnav.jsp"/>
        <form action="User" method="POST">
            <input type="hidden" name="suffix" value="${suffix}">
            <input type="hidden" name="action" value="addChild">
            <h1>Thêm người thân</h1>
            <table>
                <tr>
                    <td>Họ và tên:</td>
                    <td>
                        <input type="text" name="fullName">
                    </td>
                </tr>
                <tr>
                    <td>Ngày sinh:</td>
                    <td>
                        <input type="date" name="dateOfBirth">
                    </td>
                </tr>
                <tr>
                    <td><b>Quê quán:</b></td>
                </tr>
                <tr>
                    <td>Tỉnh/Thành phố:</td>
                    <td>
                        <select id="province" name="provinceID">
                            <option value="">-- Chọn Tỉnh --</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Quận/Huyện:</td>
                    <td>
                        <select id="district" name="districtID" disabled>
                            <option value="">-- Chọn Huyện --</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Phường/Xã:</td>
                    <td>
                        <select id="ward" name="wardID" disabled>
                            <option value="">-- Chọn Xã --</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ cụ thể:</td>
                    <td><input type="text" name="addressDetail"></td>
                </tr>
            </table>
            <input type="submit" value="Thêm người thân">
        </form>
        <input type="button" value="Quay lại" onclick="location.href = 'User?action=childManagement'">
    </body>
</html>
