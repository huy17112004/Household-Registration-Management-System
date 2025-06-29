<%-- 
    Document   : permanentSelfRegistration
    Created on : Mar 12, 2025, 11:18:28 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>JSP Page</title>
        <script>
            function resetHouseholdInfo() {
                document.getElementById("headFullName").value = "";
                document.getElementById("householdCode").value = "";
                document.getElementById("addressDetail").value = "";
                document.getElementById("householdID").value = null;

                let areaLeaderSelect = document.querySelector("select[name='areaLeaderID']");
                areaLeaderSelect.innerHTML = ""; // Xóa các option cũ
                let defaultOption = document.createElement("option");
                defaultOption.value = "";
                defaultOption.textContent = "-- Chọn tổ trưởng khu phố --";
                areaLeaderSelect.appendChild(defaultOption);
                $('#areaLeaderID').prop('disabled', true);

                document.getElementById("householdMessage").textContent = "";
                document.getElementById("householdMessage").style.display = "none";
            }
            function fetchHouseholdInfo() {
                var headCCCD = document.getElementById("headCCCD").value.trim();
                var householdMessage = document.getElementById("householdMessage");

                if (headCCCD === "") {
                    resetHouseholdInfo();
                    return;
                }

                fetch("Household?action=getHouseholdByCCCD&headCCCD=" + headCCCD)
                        .then(response => response.json())
                        .then(data => {
                            if (data.isHouseholdHead) {
                                document.getElementById("headFullName").value = data.headFullName;
                                document.getElementById("householdCode").value = data.householdCode;
                                document.getElementById("addressDetail").value = data.addressDetail;
                                document.getElementById("householdID").value = data.householdID;

                                householdMessage.style.display = "none"; // Ẩn thông báo lỗi

                                let areaLeaderSelect = document.querySelector("select[name='areaLeaderID']");
                                areaLeaderSelect.innerHTML = ""; // Xóa các option cũ
                                let defaultOption = document.createElement("option");
                                defaultOption.value = "";
                                defaultOption.textContent = "-- Chọn tổ trưởng khu phố --";
                                areaLeaderSelect.appendChild(defaultOption);
                                $('#areaLeaderID').prop('disabled', false);
                                if (data.areaLeaders && data.areaLeaders.length > 0) {
                                    data.areaLeaders.forEach(leader => {
                                        let option = document.createElement("option");
                                        option.value = leader.userID;
                                        option.textContent = leader.fullName + ", " + leader.addressDetail;
                                        areaLeaderSelect.appendChild(option);
                                    });
                                }
                            } else {
                                resetHouseholdInfo();
                                $('#areaLeaderID').prop('disabled', true);
                                householdMessage.textContent = "Không tìm thấy chủ hộ khẩu này!";
                                householdMessage.style.display = "block";
                            }
                        })
                        .catch(error => {
                            resetHouseholdInfo();
                        });
            }
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
                let personalDocuments = document.querySelector("input[name='personalDocuments']").files.length > 0;
//                let residenceDocuments = document.querySelector("input[name='residenceDocuments']").files.length > 0;

                let submitBtn = document.getElementById("submitBtn");
                let dateStartSelected = document.getElementById("startDate").value !== "";
                let relationshipSelected = document.getElementById("relationship").value !== "";
                submitBtn.disabled = !(areaLeaderSelected && personalDocuments & dateStartSelected & relationshipSelected);
            }
            window.onload = function () {
                let registrationType = "${registrationType}";
                if (registrationType === "TemporaryStay") {
                    fetchHouseholdInfo();
                }
            };
        </script>
    </head>
    <body class="sub_page">
        <c:if test="${childID == null}">
            <jsp:include page="topnav.jsp"/>
        </c:if>
        <c:if test="${childID != null}">
            <jsp:include page="topnavChild.jsp"/>
        </c:if>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <c:if test="${registrationType eq 'Permanent'}">
                        <h2>ĐƠN ĐĂNG KÍ THƯỜNG TRÚ</h2>
                    </c:if>
                    <c:if test="${registrationType eq 'Temporary'}">
                        <h2>ĐƠN ĐĂNG KÍ TẠM TRÚ</h2>
                    </c:if>
                    <c:if test="${registrationType eq 'TemporaryStay'}">
                        <h2>ĐƠN ĐĂNG KÍ TẠM VẮNG</h2>
                    </c:if>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form_container">
                            <form action="Household" method="POST"  enctype="multipart/form-data">
                                <input type="hidden" name="action" value="registration">
                                <input type="hidden" name="registrationType" value="${registrationType}">
                                <input type="hidden" id="householdID" name="householdID">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-user"></i> Thông tin cá nhân
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Họ và tên:</label>
                                                <input type="text" id="fullName" class="form-control" value="${sender.getFullName()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Ngày sinh:</label>
                                                <input type="date" id="dob" class="form-control" value="${sender.getDateOfBirth()}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <c:if test="${childID == null}">
                                                <div class="mb-3">
                                                    <label>Số CCCD:</label>
                                                    <input type="text" id="cccd" class="form-control" value="${sender.getCCCD()}" readonly/>
                                                </div>
                                            </c:if>
                                            <c:if test="${childID != null}">
                                                <input type="hidden" name="childID" value="${childID}">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label>Tên người giám hộ:</label>
                                                        <input type="text" value="${user.getFullName()}" class="form-control" readonly>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label>Số CCCD của người giám hộ:</label>
                                                        <input type="text" value="${user.getCCCD()}" class="form-control" readonly>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <div class="mb-3">
                                                <label>Quê quán:</label>
                                                <input type="text" id="address" class="form-control" value="${addressDetailMoreSelf}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${householdMember != null and registrationType ne 'TemporaryStay'}">
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
                                <c:if test="${temporaryLog != null}">
                                    <input type="hidden" name="temporaryLogID" value="${temporaryLog.getLogID()}">
                                    <div class="border rounded p-3 mb-4">
                                        <h4 class="section-title">
                                            <i class="fas fa-house-user"></i> Thông tin về hộ khẩu đang tạm trú
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
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label>Ngày bắt đầu:</label>
                                                        <input type="text" value="${temporaryLog.getStartDate()}" class="form-control" readonly>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label>Ngày kết thúc:</label>
                                                        <input type="text" value="${temporaryLog.getEndDate()}" class="form-control" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house"></i> Thông tin về hộ khẩu
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label>Số CCCD chủ hộ:</label>
                                                <input type="text" id="headCCCD" <c:if test="${registrationType ne 'TemporaryStay'}">onkeyup="fetchHouseholdInfo()"</c:if> <c:if test="${registrationType eq 'TemporaryStay'}">value="${head.getCCCD()}" readonly</c:if> class="form-control">
                                                    <p id="householdMessage" style="color: red; display: none; margin: 0;"></p>
                                                </div>
                                                <div class="mb-3">
                                                    <label>Chủ hộ:</label>
                                                    <input type="text" id="headFullName" readonly class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <label>Mã hộ khẩu:</label>
                                                    <input type="text" id="householdCode" readonly class="form-control">
                                                </div>
                                                <div class="mb-3">
                                                    <label>Mối quan hệ với chủ hộ:</label>
                                                        <input type="text" id="relationship" name="relationship" class="form-control" onchange="validateForm()" <c:if test="${registrationType eq 'TemporaryStay'}">value="${householdMember.getRelationship()}" readonly</c:if>>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                            <c:if test="${registrationType eq 'Permanent'}">
                                                <div class="mb-3">
                                                    <label>Ngày bắt đầu:</label>
                                                    <input type="date" id="startDate" name="startDate" class="form-control" onchange="validateForm()">
                                                </div>
                                            </c:if>
                                            <c:if test="${registrationType ne 'Permanent'}">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label>Ngày bắt đầu:</label>
                                                        <input type="date" id="startDate" name="startDate" class="form-control" onchange="validateForm()">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label>Ngày kết thúc:</label>
                                                        <input type="date" name="endDate" class="form-control">
                                                    </div>
                                                </div>
                                            </c:if>
                                            <div class="mb-3">
                                                <label>Tổ trưởng khu phố:</label>
                                                <select name="areaLeaderID" id="areaLeaderID" onchange="validateForm()" class="form-control nice-select wide" disabled>
                                                    <option value="" disabled selected>-- Chọn tổ trưởng khu phố --</option>
                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <div>
                                        <label>Địa chỉ:</label>
                                        <input type="text" id="addressDetail" readonly  class="form-control">
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
                                    <c:if test="${registrationType ne 'TemporaryStay'}">
                                        <div>
                                            <label>Giấy tờ chứng minh cư trú:</label>
                                            <input type="file" name="residenceDocuments" accept="image/*" multiple onchange="validateFiles(this)" class="form-control">
                                        </div>
                                    </c:if>
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
                                    <input type="submit" id="submitBtn" onclick="alert('Gửi đơn đăng ký hộ khẩu thành công!');" value="Gửi yêu cầu" disabled class="form-control">
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
