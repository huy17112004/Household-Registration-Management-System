<%-- 
    Document   : householdCreate
    Created on : Mar 12, 2025, 11:31:43 PM
    Author     : Huytayto
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
        <link rel="stylesheet" href="css/mycss.css">

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                    let areaLeaderSelect = document.querySelector("select[name='areaLeaderID']");
                    let errorMsg = document.querySelector("#areaLeaderError");

                    // Xóa các option cũ
                    areaLeaderSelect.innerHTML = "";
                    let defaultOption = document.createElement("option");
                    defaultOption.value = "";
                    defaultOption.textContent = "-- Chọn tổ trưởng khu phố --";
                    areaLeaderSelect.appendChild(defaultOption);
                    $('#areaLeaderID').prop('disabled', true);

                    if (errorMsg) {
                        errorMsg.textContent = ""; // Xóa thông báo lỗi nếu có
                        errorMsg.style.display = "none";
                    }
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
                    let areaLeaderSelect = document.querySelector("select[name='areaLeaderID']");
                    let errorMsg = document.querySelector("#areaLeaderError");

                    // Xóa các option cũ
                    areaLeaderSelect.innerHTML = "";
                    let defaultOption = document.createElement("option");
                    defaultOption.value = "";
                    defaultOption.textContent = "-- Chọn tổ trưởng khu phố --";
                    areaLeaderSelect.appendChild(defaultOption);
                    $('#areaLeaderID').prop('disabled', true);

                    if (errorMsg) {
                        errorMsg.textContent = ""; // Xóa thông báo lỗi nếu có
                        errorMsg.style.display = "none";
                    }
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
                $('#ward').change(function () {
                    let wardID = $(this).val();
                    let areaLeaderSelect = document.querySelector("select[name='areaLeaderID']");
                    let errorMsg = document.querySelector("#areaLeaderError");

                    // Xóa các option cũ
                    areaLeaderSelect.innerHTML = "";
                    let defaultOption = document.createElement("option");
                    defaultOption.value = "";
                    defaultOption.textContent = "-- Chọn tổ trưởng khu phố --";
                    areaLeaderSelect.appendChild(defaultOption);
                    $('#areaLeaderID').prop('disabled', true);

                    if (errorMsg) {
                        errorMsg.textContent = ""; // Xóa thông báo lỗi nếu có
                        errorMsg.style.display = "none";
                    }

                    if (wardID) {
                        fetch("Household?action=getAreaLeaderByWardID&wardID=" + wardID)
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error("Lỗi khi gọi API");
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    if (data.wardSuccess && data.areaLeaders.length > 0) {
                                        data.areaLeaders.forEach(leader => {
                                            let option = document.createElement("option");
                                            option.value = leader.userID;
                                            option.textContent = leader.fullName + " - " + leader.addressDetail;
                                            areaLeaderSelect.appendChild(option);
                                        });
                                        errorMsg.style.display = "none"; // Ẩn lỗi nếu có dữ liệu
                                        $('#areaLeaderID').prop('disabled', false);
                                    } else {
                                        errorMsg.textContent = "Không có tổ trưởng dân phố nào trong khu vực!";
                                        errorMsg.style.display = "block"; // Hiện lỗi
                                        $('#areaLeaderID').prop('disabled', true);
                                    }
                                })
                                .catch(error => {
                                    console.error("Lỗi: ", error);
                                    errorMsg.textContent = "Không có tổ trưởng dân phố nào trong khu vực!";
                                    errorMsg.style.display = "block"; // Hiện lỗi nếu có vấn đề API
                                    $('#areaLeaderID').prop('disabled', true);
                                });
                    }
                });
            });
            function validateFiles(input) {
                const maxFiles = 5;
                const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/webp'];

                let isValid = true;

                if (input.files.length > maxFiles) {
                    alert("Bạn chỉ được chọn tối đa " + maxFiles + " ảnh.");
                    isValid = false;
                } else {
                    for (let file of input.files) {
                        if (!allowedTypes.includes(file.type)) {
                            alert("Chỉ được tải lên file hình ảnh (JPG, PNG, GIF, BMP, WEBP).");
                            isValid = false;
                            break;
                        }
                    }
                }

                if (!isValid) {
                    input.value = ""; // Reset input nếu có lỗi
                }

                validateForm(); // Kiểm tra điều kiện sau khi chọn file
            }
            function validateForm() {
                let areaLeaderSelected = document.getElementById("areaLeaderID").value !== "";
                let dateStartSelected = document.getElementById("startDate").value !== "";
                let addressDetailInput = document.getElementById("addressDetail").value !== "";
                let idCardFiles = document.querySelector("input[name='personalDocuments']").files.length > 0;
                let residenceProofFiles = document.querySelector("input[name='residenceDocuments']").files.length > 0;

                let submitBtn = document.getElementById("submitBtn");
                submitBtn.disabled = !(areaLeaderSelected && idCardFiles && residenceProofFiles & dateStartSelected & addressDetailInput);
            }
        </script>
    </head>
    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    if (session.getAttribute("user") == null) { 
        response.sendRedirect(request.getContextPath() + "/signIn"); // Chuyển hướng về trang đăng nhập
        return;
    }
%>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        TẠO HỘ KHẨU
                    </h2>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form_container">
                            <form action="Household" method="POST"  enctype="multipart/form-data">
                                <input type="hidden" name="action" value="householdCreate">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-user"></i> Thông tin cá nhân
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Họ và tên:</label>
                                                <input type="text" id="fullName" class="form-control" value="${user.getFullName()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Ngày sinh:</label>
                                                <input type="date" id="dob" class="form-control" value="${user.getDateOfBirth()}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Số CCCD:</label>
                                                <input type="text" id="cccd" class="form-control" value="${user.getCCCD()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Quê quán:</label>
                                                <input type="text" id="address" class="form-control" value="${addressDetailMoreSelf}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${householdMember != null}">
                                    <input type="hidden" name="householdMemberID" value="${householdMember.getMemberID()}">
                                    <div class="border rounded p-3 mb-4">
                                        <h4 class="section-title">
                                            <i class="fas fa-house-user"></i> Thông tin về hộ khẩu đang thường trú
                                        </h4>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label>Tên chủ hộ khẩu:</label>
                                                    <input type="text" value="${oldHead.getFullName()}" class="form-control" readonly>
                                                </div>
                                                <div class="mb-3">
                                                    <label>Mã hộ khẩu:</label>
                                                    <input type="text" value="${oldHousehold.getHouseholdCode()}" class="form-control" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label>Địa chỉ:</label>
                                                    <input type="text" value="${addressDetailMoreOfOldHousehold}" class="form-control" readonly>
                                                </div>
                                                <div class="mb-3">
                                                    <label>Mối quan hệ với chủ hộ:</label>
                                                    <input type="text" value="${householdMember.getRelationship()}" class="form-control" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house"></i> Thông tin về hộ khẩu mới
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div>
                                                <label>Tỉnh/Thành phố:</label>
                                                <select id="province" name="provinceID" class="form-control nice-select wide">
                                                    <option value="" disabled selected>-- Chọn Tỉnh --</option>
                                                </select>
                                            </div>
                                            <div>
                                                <label>Quận/Huyện:</label>
                                                <select id="district" name="districtID" disabled class="form-control nice-select wide">
                                                    <option value="" disabled selected>-- Chọn Huyện --</option>
                                                </select>
                                            </div>
                                            <div>
                                                <label>Phường/Xã:</label>
                                                <select id="ward" name="wardID" disabled class="form-control nice-select wide">
                                                    <option value="" disabled selected>-- Chọn Xã --</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div>
                                                <label>Địa chỉ cụ thể:</label>
                                                <input type="text" id="addressDetail" name="addressDetail" class="form-control" onchange="validateForm()">
                                            </div>
                                            <div>
                                                <label>Tổ trưởng khu phố:</label><span id="areaLeaderError" style="color: red; font-style: italic"></span>
                                                <select id="areaLeaderID" name="areaLeaderID" disabled onchange="validateForm()" class="form-control nice-select wide">
                                                    <option value="" disabled selected>-- Chọn tổ trưởng khu phố --</option>
                                                </select>
                                            </div>
                                            <div>
                                                <label>Ngày bắt đầu:</label>
                                                <input type="date" id="startDate" name="startDate" class="form-control" onchange="validateForm()">
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-file-alt"></i> Giấy tờ đi kèm
                                    </h4>
                                    <div>
                                        <label>Giấy tờ nhân thân:</label>
                                        <input type="file" name="personalDocuments" accept="image/*" multiple onchange="validateFiles(this)" class="form-control">
                                    </div>
                                    <div>
                                        <label>Giấy tờ chứng minh cư trú:</label>
                                        <input type="file" name="residenceDocuments" accept="image/*" multiple onchange="validateFiles(this)" class="form-control">
                                    </div>
                                    <div>
                                        <label>Giấy tờ khác(nếu cần):</label>
                                        <input type="file" name="otherDocs" accept="image/*" multiple onchange="validateFiles(this)" class="form-control">
                                    </div>
                                    <div>
                                        <label>Ghi chú về đơn:</label>
                                        <input type="text" name="comments" class="form-control">
                                    </div>
                                </div>
                                <div class="btn_box">
                                    <input type="submit" id="submitBtn" onclick="alert('Gửi đơn đăng ký hộ khẩu thành công!');" value="Gửi yêu cầu" disabled  class="form-control">
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
