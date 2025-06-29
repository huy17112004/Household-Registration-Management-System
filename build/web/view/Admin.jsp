<%-- 
    Document   : index
    Created on : Mar 14, 2025, 8:21:03 AM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title> Feane </title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" /> 
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="js/jquery-3.4.1.min.js"></script>
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

    <jsp:include page="topnavAdmin.jsp"/>
    <!--        <a href="Logout">Logout</a>
            <form action="User" method="GET">
                <input type="hidden" name="action" value="list" >
                <table>
                    <tr> 
                        <td>
                            Xem tất cả người dùng: 
                        </td>  
                        <td><input type="submit" value="Xem thông tin"></td>
    
                    </tr>
                </table>
    
            </form>    
            <form action="Registration" method="GET">
                <input type="hidden" name="action" value="listreg" >
                <table>
                    <tr> 
                        <td>
                            Xem tất cả đơn : 
                        </td>  
                        <td><input type="submit" value="Xem thông tin"></td>
    
                    </tr>
                </table>
    
            </form>
            
            
            <form action="Household" method="GET">
                <input type="hidden" name="action" value="listHouseHold" >
                <table>
                    <tr> 
                        <td>
                            Xem tất cả hộ khẩu : 
                        </td>  
                        <td><input type="submit" value="Xem thông tin"></td>
    
                    </tr>
                </table>
    
            </form>
            
            <form action="User" method="GET">
                <input type="hidden" name="action" value="addHighPeople" >
                <table>
                    <tr> 
                        <td>
                            Thêm tài khoản cấp cao
                        </td>  
                        <td><input type="submit" value="Thêm"></td>
    
                    </tr>
                </table>
    
            </form>-->
    <jsp:include page="footer.jsp"/>
</body>
</html>
