<%-- 
    Document   : householdList
    Created on : Mar 14, 2025, 10:38:59 AM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="model.Household" %>
<%@page import="model.LocationService" %>
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

        <title>Household List</title>
        <meta charset="utf-8" />
        <title> Feane </title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" /> 
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="js/jquery-3.4.1.min.js"></script>
    </head>
    <body class="sub_page">
        <jsp:include page="topnavAdmin.jsp"/>

        <%ArrayList<Household> households = (ArrayList<Household>) request.getAttribute("households"); %>

        <h1 class="text-center">List of Households</h1>

        <% if (households == null || households.isEmpty()) { %>
        <h2 class="text-center text-danger">There are no households available</h2>
        <% } else { %>

        <div class="container-fluid mt-4">
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center">
                    <thead class="thead-dark">
                        <tr>
                            <th>Household ID</th>
                            <th>Household Code</th>
                            <th>Head Of Household ID</th>
                            <th>Province</th>
                            <th>District</th>
                            <th>Ward</th>
                            <th>Address Detail</th>
                            <th>Created Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Household household : households) { %>
                        <tr>
                            <td><%= household.getHouseholdID() %></td>
                            <td><%= household.getHouseholdCode() %></td>
                            <td><%= household.getHeadOfHouseholdID() %></td>
                            <td><%= LocationService.getProvinceName(household.getProvinceID()) %></td>
                            <td><%= LocationService.getDistrictName(household.getDistrictID()) %></td>
                            <td><%= LocationService.getWardName(household.getDistrictID(), household.getWardID()) %></td>
                            <td><%= household.getAddressDetail() %></td>
                            <td><%= household.getCreatedDate() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>


        <br>
        <div class="container mt-4">
    <h3 class="mb-3">Search Household</h3>
    <form action="Household" method="GET" class="p-4 border rounded shadow-sm bg-light">
        <input type="hidden" name="action" value="searchhousehold">
        
        <div class="mb-3">
            <label for="province" class="form-label">Province:</label>
            <select id="province" name="provinceId" class="form-select">
                <option value="">-- Select Province --</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="district" class="form-label">District:</label>
            <select id="district" name="districtId" class="form-select" disabled>
                <option value="">-- Select District --</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="ward" class="form-label">Ward:</label>
            <select id="ward" name="wardId" class="form-select" disabled>
                <option value="">-- Select Ward --</option>
            </select>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary">Search Household</button>
        </div>
    </form>
</div>

        <jsp:include page="footer.jsp"/>
        <script>
            $(document).ready(function () {
                let selectedProvince = "<%= request.getAttribute("provinceId") != null ? request.getAttribute("provinceId") : "" %>";
                let selectedDistrict = "<%= request.getAttribute("districtId") != null ? request.getAttribute("districtId") : "" %>";
                let selectedWard = "<%= request.getAttribute("wardId") != null ? request.getAttribute("wardId") : "" %>";

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
                    $('#district').html('<option value="">-- Select District --</option>').prop('disabled', true);
                    $('#ward').html('<option value="">-- Select Ward --</option>').prop('disabled', true);

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
                    $('#ward').html('<option value="">-- Select Ward --</option>').prop('disabled', true);

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
        </script>
    </body>
</html>
