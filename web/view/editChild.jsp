<%-- 
    Document   : editChild
    Created on : Mar 15, 2025, 12:54:33 PM
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
        <title>Chỉnh sửa thông tin con</title>
        <style>
            .form {
                max-width: 500px;
                margin: auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .input-box {
                margin-bottom: 15px;
            }
            .input-box label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .input-box input,
            .select-box select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .select-box {
                margin-bottom: 15px;
            }
            button {
                width: 100%;
                padding: 10px;
                background: #007bff;
                border: none;
                color: white;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background: #0056b3;
            }
            .error-message {
                color: red;
                font-weight: bold;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Chỉnh Sửa Thông Tin Con
                    </h2>
                </div>
            <form action="RegisterChildServlet" method="post" class="form">
                <input type="hidden" name="action" value="updateChild">
                <input type="hidden" name="oldChildCCCD" value="${child.getCCCD()}">
                <input type="hidden" name="status" value="${child.getStatus()}">

                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <div class="input-box">
                    <label>CCCD (có thể thay đổi)</label>
                    <input type="text" name="childCCCD" value="${child.getCCCD()}" placeholder="Nhập số CCCD" required pattern="\d{12,}" title="CCCD phải là ít nhất 12 chữ số" />
                </div>

                <div class="input-box">
                    <label>Họ và tên</label>
                    <input type="text" name="fullname" value="${child.getFullName()}" readonly />
                </div>

                <div class="input-box">
                    <label>Ngày sinh</label>
                    <input type="date" name="dateofbirth" value="${child.getDateOfBirth()}" readonly />
                </div>

                <div class="input-box">
                    <label>Email</label>
                    <input type="email" name="email" value="${child.getEmail()}" placeholder="Nhập địa chỉ email" />
                </div>

                <div class="input-box">
                    <label>Số điện thoại</label>
                    <input type="text" name="phonenumber" value="${child.getPhoneNumber()}" placeholder="Nhập số điện thoại" pattern="\d{10}" title="Số điện thoại phải là 10 chữ số" />
                </div>

                <div class="input-box" style="position: relative;">
                    <label>Mật khẩu</label>
                    <input type="password" id="password" name="password" value="${child.getPassword()}" placeholder="Nhập mật khẩu" required />
                    
                </div>

                <div class="input-box address">
                    <label>Địa chỉ</label>
                    <div class="select-box">
                        <select id="province" disabled>
                            <option value="" hidden>Chọn Tỉnh/Thành phố</option>
                            <c:forEach var="province" items="${provinces}">
                                <option value="${province.get('code')}" ${province.get('code') == (child != null ? child.getProvinceID() : 0) || province.get('code') == (param.provinceid != null ? Integer.parseInt(param.provinceid) : 0) ? 'selected' : ''}>${province.get('name')}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="provinceid" value="${child.getProvinceID()}">
                    </div>

                    <div class="select-box">
                        <select id="district" disabled>
                            <option value="" hidden>Chọn Quận/Huyện</option>
                            <c:forEach var="district" items="${districts}">
                                <option value="${district.get('code')}" ${district.get('code') == (child != null ? child.getDistrictID() : 0) || district.get('code') == (param.districtid != null ? Integer.parseInt(param.districtid) : 0) ? 'selected' : ''}>${district.get('name')}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="districtid" value="${child.getDistrictID()}">
                    </div>

                    <div class="select-box">
                        <select id="ward" disabled>
                            <option value="" hidden>Chọn Xã/Phường</option>
                            <c:forEach var="ward" items="${wards}">
                                <option value="${ward.get('code')}" ${ward.get('code') == (child != null ? child.getWardID() : 0) || ward.get('code') == (param.wardid != null ? Integer.parseInt(param.wardid) : 0) ? 'selected' : ''}>${ward.get('name')}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="wardid" value="${child.getWardID()}">
                    </div>

                    <input type="text" name="addressdetail" value="${child.getAddressDetail()}" readonly />
                </div>
                <button type="submit">Cập nhật</button>
            </form>
            </div>
        </section>
<jsp:include page="footer.jsp"/>
    </body>
</html>
