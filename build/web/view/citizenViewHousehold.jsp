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
        <title>Thông Tin Hộ Khẩu</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script>
                        function changeHead() {
                            var selectedRadio = document.querySelector('input[name="newHead"]:checked');

                            if (!selectedRadio) {
                                alert('Vui lòng chọn một thành viên để chuyển chủ hộ khẩu!');
                                return;
                            }

                            var newHeadID = selectedRadio.value;
                            var newRelationship;
                            do {
                                newRelationship = prompt('Nhập mối quan hệ với chủ hộ khẩu mới:');
                                if (newRelationship === null) {
                                    alert('Bạn phải nhập mối quan hệ!'); // Hiển thị cảnh báo khi bấm "Hủy"
                                    return;
                                }
                                newRelationship = newRelationship.trim();
                            } while (newRelationship === '');
                            var confirmChange = confirm('Bạn có chắc chắn muốn chuyển chủ hộ khẩu không?');
                            if (confirmChange) {
                                window.location.href = 'Notification?action=changeHead&householdID=${household.getHouseholdID()}&newHeadID=' + newHeadID + '&relationship=' + encodeURIComponent(newRelationship) + '&memberID=${householdMember.getMemberID()}';
                            }
                        }
                        function changeRelationship() {
                            var newRelationship;
                            do {
                                newRelationship = prompt('Nhập mối quan hệ mới (không được để trống):');
                                if (newRelationship === null) {
                                    alert('Bạn phải nhập mối quan hệ!'); // Hiển thị cảnh báo khi bấm "Hủy"
                                    return;
                                }
                                newRelationship = newRelationship.trim();
                            } while (newRelationship === '');

                            window.location.href = 'Notification?action=changeRelationship&relationship=' + newRelationship + "&memberID=${householdMember.getMemberID()}";
                        }
                    </script>
        <style>
            .table-custom {
                width: 100%;
                border-collapse: collapse;
            }
            .table-custom th, .table-custom td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            .table-custom th {
                background-color: #f8f9fa;
            }
            .btn-custom {
                padding: 10px 15px;
                font-size: 14px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-primary-custom {
                background-color: #007bff;
                color: white;
            }
            .btn-primary-custom:hover {
                background-color: #0056b3;
            }
            .btn-danger-custom {
                background-color: #dc3545;
                color: white;
            }
            .btn-danger-custom:hover {
                background-color: #a71d2a;
            }
        </style>
    </head>
    <body class="sub_page">
        <jsp:include page="topnav.jsp"/>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container text-center mb-4">
                    <h2 class="fw-bold text-uppercase">THÔNG TIN VỀ HỘ KHẨU</h2>
                </div>
                <c:if test="${householdMembers == null}">
                    <p class="alert alert-warning">Hiện tại bạn không thường trú tại hộ khẩu nào!</p>
                </c:if>
                <c:if test="${householdMembers != null}">
                    <p class="fw-bold">Đang thường trú tại hộ khẩu <span class="text-primary">${household.getHouseholdCode()}</span></p>
                    <table class="table-custom">
                        <thead>
                            <tr>
                                <th>Họ và tên</th>
                                <th>Căn cước công dân</th>
                                <th>Ngày sinh</th>
                                <th>Mối quan hệ</th>
                                <c:if test="${isHead != null}">
                                    <th>Chọn</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="hhm" items="${householdMembers}">
                                <tr>
                                    <td>${hhm.getUser().getFullName()}</td>
                                    <td>${hhm.getUser().getCCCD()}</td>
                                    <td>${hhm.getUser().getDateOfBirth()}</td>
                                    <td>${hhm.getRelationship()}</td>
                                    <c:if test="${isHead != null and hhm.getRelationship() ne 'Chủ hộ'}">
                                        <td><input type="radio" id="newHead" name="newHead" value="${hhm.getUser().getUserID()}"></td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="mt-3">
                        <c:if test="${isHead != null}">
                            <input type="button" class="btn-custom btn-primary-custom" value="Chuyển chủ hộ khẩu" onclick="changeHead()">
                        </c:if>
                        <c:if test="${isHead == null}">
                            <input type="button" class="btn-custom btn-primary-custom" value="Đổi mối quan hệ" onclick="changeRelationship()">
                        </c:if>
                        <c:if test="${canDelete != null}">
                            <input type="button" class="btn-custom btn-danger-custom" value="Xoá hộ khẩu" onclick="location.href = 'Notification?action=deleteHousehold&householdID=${household.getHouseholdID()}'">
                        </c:if>
                    </div>
                </c:if>

                <br><br><br>

                <c:if test="${log == null}">
                    <p class="alert alert-info">Hiện tại bạn không tạm trú tại hộ khẩu nào!</p>
                </c:if>
                <c:if test="${log != null}">
                    <p class="fw-bold">Bạn đang tạm trú tại hộ khẩu <span class="text-primary">${log.getHousehold().getHouseholdCode()}</span></p>
                    <p class="fw-bold">Thông tin về hộ khẩu:</p>
                    <table class="table-custom">
                        <tr>
                            <td><b>Mã hộ khẩu:</b></td>
                            <td>${log.getHousehold().getHouseholdCode()}</td>
                        </tr>
                        <tr>
                            <td><b>Địa chỉ:</b></td>
                            <td>${addressDetailMoreHousehold}</td>
                        </tr>
                        <tr>
                            <td><b>Tên chủ hộ khẩu:</b></td>
                            <td>${headTemporary.getFullName()}</td>
                        </tr>
                        <tr>
                            <td><b>CCCD chủ hộ:</b></td>
                            <td>${headTemporary.getCCCD()}</td>
                        </tr>
                    </table>

                    <p class="fw-bold">Thời gian tạm trú:</p>
                    <table class="table-custom">
                        <tr>
                            <td><b>Ngày bắt đầu:</b></td>
                            <td>${log.getStartDate()}</td>
                        </tr>
                        <tr>
                            <td><b>Ngày kết thúc:</b></td>
                            <td>${log.getEndDate()}</td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
