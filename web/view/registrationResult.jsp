<%-- 
    Document   : permanentRegistrationResult
    Created on : Mar 9, 2025, 5:51:33 PM
    Author     : Huytayto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
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
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="js/downloadImages.js" defer></script>
        <link rel="stylesheet" href="css/mycss.css">
    </head>
    <body class="sub_page">
        <c:if test="${user.getRole() eq 'Admin'}">
            <jsp:include page="topnavAdmin.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'Police'}">
            <jsp:include page="topnavPolice.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'AreaLeader'}">
            <jsp:include page="topnavAreaLeader.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'Citizen'}">
            <jsp:include page="topnav.jsp"/>
        </c:if>
        <c:if test="${user.getRole() eq 'Admin'}">
            <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Registration?action=listreg'">
        </c:if>
        <c:if test="${user.getRole() eq 'Police'}">
            <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Household?action=policeManager'">
        </c:if>
        <c:if test="${user.getRole() eq 'AreaLeader'}">
            <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Household?action=areaLeaderManager'">
        </c:if>
        <c:if test="${childID == null and user.getRole() eq 'Citizen'}">
            <input type="button" value="Quay lại" class="back-button" onclick="location.href = 'Household?action=citizenViewRegistration'">
        </c:if>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <c:if test="${household == null}">
                        <h2>ĐƠN XIN TẠO HỘ KHẨU</h2>
                    </c:if>
                    <c:if test="${household != null}">
                        <c:if test="${registration.getRegistrationType() eq 'Permanent'}">
                            <h2>ĐƠN ĐĂNG KÍ THƯỜNG TRÚ</h2>
                        </c:if>
                        <c:if test="${registration.getRegistrationType() eq 'Temporary'}">
                            <h2>ĐƠN ĐĂNG KÍ TẠM TRÚ</h2>
                        </c:if>
                        <c:if test="${registration.getRegistrationType() eq 'TemporaryStay'}">
                            <h2>ĐƠN ĐĂNG KÍ TẠM VẮNG</h2>
                        </c:if>

                    </c:if>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form_container">
                            <div class="border rounded p-3 mb-4">
                                <h4 class="section-title">
                                    <i class="fas fa-user"></i> Thông tin về đơn đăng kí
                                </h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label>Mã đơn đăng kí:</label>
                                            <input type="text" class="form-control" value="${registration.getRegistrationCode()}" readonly/>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Người đăng kí:</label>
                                                <input type="text" class="form-control" value="${sender.getFullName()}" readonly/>
                                            </div>
                                            <div class="col-md-6">
                                                <label>Ngày sinh:</label>
                                                <input type="text" class="form-control" value="${sender.getDateOfBirth()}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <c:if test="${childID == null}">
                                            <div class="mb-3">
                                                <label>Số CCCD:</label>
                                                <input type="text" class="form-control" value="${sender.getCCCD()}" readonly/>
                                            </div>
                                        </c:if>
                                        <c:if test="${childID != null}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Người giám hộ hợp pháp:</label>
                                                    <input type="text" class="form-control" value="${guardian.getFullName()}" readonly/>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>CCCD của người giám hộ:</label>
                                                    <input type="text" class="form-control" value="${guardian.getCCCD()}" readonly/>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${registration.getEndDate() != null}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Ngày bắt đầu:</label>
                                                    <input type="text" class="form-control" value="${registration.getStartDate()}" readonly/>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Ngày kết thúc:</label>
                                                    <input type="text" class="form-control" value="${registration.getEndDate()}" readonly/>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${registration.getEndDate() == null}">
                                            <div class="mb-3">
                                                <label>Ngày bắt đầu:</label>
                                                <input type="text" class="form-control" value="${registration.getStartDate()}" readonly/>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${householdMember != null and registration.getRegistrationType() ne 'TemporaryStay'}">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house-user"></i> Thông tin về hộ khẩu đang thường trú
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Mã hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${oldHousehold.getHouseholdCode()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Tên chủ hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${oldHead.getFullName()}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Mối quan hệ với chủ hộ:</label>
                                                <input type="text" class="form-control" value="${householdMember.getRelationship()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Địa chỉ:</label>
                                                <input type="text" class="form-control" value="${addressDetailMoreOfOldHousehold}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${temporaryLog != null}">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house-user"></i> Thông tin về hộ khẩu đang tạm trú
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Tên chủ hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${oldHead.getFullName()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Mã hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${oldHousehold.getHouseholdCode()}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Địa chỉ:</label>
                                                <input type="text" class="form-control" value="${addressDetailMoreOfOldHousehold}" readonly/>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Ngày bắt đầu:</label>
                                                    <input type="text" class="form-control" value="${temporaryLog.getStartDate()}" readonly/>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Ngày kết thúc:</label>
                                                    <input type="text" class="form-control" value="${temporaryLog.getEndDate()}" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${household != null}">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house"></i> Thông tin về hộ khẩu
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Mã hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${household.getHouseholdCode()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Tên của chủ hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${head.getFullName()}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label>Quan hệ với chủ hộ:</label>
                                                <input type="text" class="form-control" value="${registration.getRelationship()}" readonly/>
                                            </div>
                                            <div class="mb-3">
                                                <label>Ngày tạo:</label>
                                                <input type="text" class="form-control" value="${household.getCreatedDate()}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <label>Địa chỉ của hộ khẩu:</label>
                                        <input type="text" class="form-control" value="${addressDetailMoreOfHousehold}" readonly/>
                                    </div>
                                </div> 
                            </c:if>
                            <c:if test="${household == null}">
                                <div class="border rounded p-3 mb-4">
                                    <h4 class="section-title">
                                        <i class="fas fa-house"></i> Thông tin về hộ khẩu mới
                                    </h4>
                                    <div class="row">
                                        <div class="col-md-9">
                                            <div class="mb-3">
                                                <label>Địa chỉ hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${addressDetailMoreOfHousehold}" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label>Ngày nhập hộ khẩu:</label>
                                                <input type="text" class="form-control" value="${registration.getStartDate()}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                            </c:if>

                            <div class="border rounded p-3 mb-4">
                                <h4 class="section-title">
                                    <i class="fas fa-file-alt"></i> Giấy tờ đi kèm
                                </h4>
                                <div>
                                    <label>Giấy tờ nhân thân:</label>
                                    <c:forEach var="img" items="${registrationImages}">
                                        <c:if test="${img.imageType eq 'personalDocuments'}">
                                            <input type="button" value="Tải ảnh" onclick="saveImage('${img.imageURL}')">
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <c:set var="hasResidenceDocuments" value="false" />
                                <c:forEach var="img" items="${registrationImages}">
                                    <c:if test="${img.imageType eq 'residenceDocuments'}">
                                        <c:set var="hasResidenceDocuments" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${hasResidenceDocuments}">
                                    <div>
                                        <label>Giấy tờ chứng minh cư trú:</label>
                                        <c:forEach var="img" items="${registrationImages}">
                                            <c:if test="${img.imageType eq 'residenceDocuments'}">
                                                <input type="button" value="Tải ảnh" onclick="saveImage('${img.imageURL}')">
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:set var="hasOtherDocs" value="false" />
                                <c:forEach var="img" items="${registrationImages}">
                                    <c:if test="${img.imageType eq 'otherDocs'}">
                                        <c:set var="hasOtherDocs" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${hasOtherDocs}">
                                    <div>
                                        <label>Giấy tờ khác(nếu cần):</label>
                                        <c:forEach var="img" items="${registrationImages}">
                                            <c:if test="${img.imageType eq 'otherDocs'}">
                                                <input type="button" value="Tải ảnh" onclick="saveImage('${img.imageURL}')">
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <div>
                                    <label>Ghi chú về đơn:</label>
                                    <input type="text" class="form-control" value="${registration.getComment()}" readonly/>
                                </div>
                                <div>
                                    <label>Ghi chú về đơn:</label>
                                    <c:if test="${registration.getStatus().equals('Pending')}">
                                        <label>Chờ</label>
                                    </c:if>
                                    <c:if test="${registration.getStatus().equals('PreApproved')}">
                                        <label>Đã sơ duyệt</label>
                                    </c:if>
                                    <c:if test="${registration.getStatus().equals('Approved')}">
                                        <label>Chấp nhận</label>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${user.getRole().contains('AreaLeader')}">
                                <div class="btn_box">
                                    <input type="button" value="Sơ duyệt" class="form-control" onclick="preConfirmRedirect()">
                                    <input type="button" value="Từ chối" class="form-control" onclick="rejectRedirect()">
                                </div>
                            </c:if>
                            <c:if test="${user.getRole().contains('Admin')}">
                                <div class="btn_box">
                                    <input type="button" value="Xét duyệt" class="form-control" onclick="confirmRedirect()">
                                    <input type="button" value="Từ chối" class="form-control" onclick="rejectRedirect()">
                                </div>
                            </c:if>
                            <c:if test="${user.getRole().contains('Police')}">
                                <div class="btn_box">
                                    <input type="button" value="Xét duyệt" class="form-control" onclick="confirmRedirect()">
                                    <input type="button" value="Từ chối" class="form-control" onclick="rejectRedirect()">
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:if test="${childID == null}">
            <script>
                function preConfirmRedirect() {
                    if (confirm("Bạn có chắc chắn muốn sơ duyệt?")) {
                        window.location.href = "Household?action=confirm&registrationID=${registration.getRegistrationID()}&senderID=${sender.getUserID()}";
                    }
                }
                function confirmRedirect() {
                    if (confirm("Bạn có chắc chắn muốn xét duyệt?")) {
                        window.location.href = "Household?action=confirm&registrationID=${registration.getRegistrationID()}&senderID=${sender.getUserID()}";
                    }
                }
            </script>
        </c:if>
        <c:if test="${childID != null}">
            <script>
                function preConfirmRedirect() {
                    if (confirm("Bạn có chắc chắn muốn sơ duyệt?")) {
                        window.location.href = "Household?action=confirm&registrationID=${registration.getRegistrationID()}&senderID=${guardian.getUserID()}";
                    }
                }
                function confirmRedirect() {
                    if (confirm("Bạn có chắc chắn muốn xét duyệt?")) {
                        window.location.href = "Household?action=confirm&registrationID=${registration.getRegistrationID()}&senderID=${guardian.getUserID()}";
                    }
                }
            </script>
        </c:if>
        <script>
            function rejectRedirect() {
                let reason = prompt("Nhập lý do từ chối:");
                if (reason === null || reason.trim() === "") {
                    alert("Bạn phải nhập lý do từ chối!");
                    return;
                }
                document.getElementById("rejectReason").value = reason;
                document.getElementById("rejectForm").submit(); // Gửi form
            }
        </script>
        <form id="rejectForm" action="Household" method="GET">
            <input type="hidden" name="action" value="reject">
            <input type="hidden" name="senderID" value="<c:if test="${childID == null}">${sender.getUserID()}</c:if><c:if test="${childID == null}">${guardian.getUserID()}</c:if>">
            <input type="hidden" name="registrationID" value="${registration.getRegistrationID()}">
            <input type="hidden" name="reason" id="rejectReason">
        </form>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
