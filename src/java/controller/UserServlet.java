/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.SendMail;
import model.User;

/**
 *
 * @author Huytayto
 */
public class UserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("signIn"); // Chuyển hướng về trang đăng nhập
            return;
        }
        User user = (User) session.getAttribute("user");
        ArrayList<User> users = new ArrayList<User>();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (action.equals("childManagement")) {
                ArrayList<User> childList = UserDAO.getUserByParentCCCD(user.getCCCD());
                request.setAttribute("childList", childList);
                RequestDispatcher rs = request.getRequestDispatcher("view/relativeManagement.jsp");
                rs.forward(request, response);
            } else if (action.equals("addChild")) {
                ArrayList<User> childList = UserDAO.getUserByParentCCCD(user.getCCCD());
                int maxSuffix = -1;
                if (childList != null) {
                    for (User child : childList) {
                        String suffix = child.getCCCD().substring(user.getCCCD().length()); // Lấy phần số thứ tự
                        try {
                            int suffixNumber = Integer.parseInt(suffix);
                            maxSuffix = Math.max(maxSuffix, suffixNumber);
                        } catch (NumberFormatException e) {
                            e.printStackTrace(); // Nếu lỗi định dạng
                        }
                    }
                }
                maxSuffix++;
                request.setAttribute("suffix", String.format("%02d", maxSuffix));
                RequestDispatcher rs = request.getRequestDispatcher("view/addChild.jsp");
                rs.forward(request, response);
            }else if(action.equals("return")){
                RequestDispatcher rs = request.getRequestDispatcher("view/Admin.jsp");
                rs.forward(request, response);
            } else if (action.equals("list")) {
                users = UserDAO.getUsers();
                request.setAttribute("users", users);
                RequestDispatcher rs = request.getRequestDispatcher("view/userList.jsp");
                rs.forward(request, response);
            } else if (action.equals("view")) {
                int userID = Integer.parseInt(request.getParameter("userID"));
                User userneed = UserDAO.getUserById(userID);
                request.setAttribute("userneed", userneed);
                RequestDispatcher rs = request.getRequestDispatcher("view/userDetail.jsp");
                rs.forward(request, response);
            } else if (action.equals("delete")) {
                int userID = Integer.parseInt(request.getParameter("userID"));
                User userneed = UserDAO.getUserById(userID);
                userneed = UserDAO.deleteUser(userneed);
                request.setAttribute("userneed", userneed);
                RequestDispatcher rs = request.getRequestDispatcher("view/deleteUser.jsp");
                rs.forward(request, response);
            } else if (action.equals("edit")) {
                int userID = Integer.parseInt(request.getParameter("userID"));
                User userneed = UserDAO.getUserById(userID);
                request.setAttribute("userneed", userneed);
                RequestDispatcher rs = request.getRequestDispatcher("view/userEdit.jsp");
                rs.forward(request, response);
            } else if (action.equals("searchByName")) {
                String nameSearch = request.getParameter("nameSearch");
                users = UserDAO.getUsersByName(nameSearch);
                request.setAttribute("users", users);
                RequestDispatcher rs = request.getRequestDispatcher("view/userList.jsp");
                rs.forward(request, response);
            } else if (action.equals("searchByPhoneNumber")) {
                String phoneNumer = request.getParameter("phoneNumberSearch");
                users = UserDAO.getUsersByPhoneNumber(phoneNumer);
                request.setAttribute("users", users);
                RequestDispatcher rs = request.getRequestDispatcher("view/userList.jsp");
                rs.forward(request, response);
            } else if (action.equals("viewSelf")) {
                String provinceName = LocationService.getProvinceName(user.getProvinceID());
                String districtName = LocationService.getDistrictName(user.getDistrictID());
                String wardName = LocationService.getWardName(user.getDistrictID(), user.getWardID());
                request.setAttribute("provinceName", provinceName);
                request.setAttribute("districtName", districtName);
                request.setAttribute("wardName", wardName);
                RequestDispatcher rs = request.getRequestDispatcher("view/userView.jsp");
                rs.forward(request, response);
            } else if (action.equals("editEmail")) {
                int userID = user.getUserID();
                String email = user.getEmail();
                String phonenumber = user.getPhoneNumber();
                request.setAttribute("email", email);
                request.setAttribute("phonenumber", phonenumber);
                RequestDispatcher rs = request.getRequestDispatcher("view/editEmail.jsp");
                rs.forward(request, response);
            } else if (action.equals("editok")) {
                int userID = user.getUserID();
                String email = request.getParameter("email");
                String phonenumber = request.getParameter("phonenumber");
                user = UserDAO.updateEmailOrPhoneNumber(user, email, phonenumber);
                user = UserDAO.getUserById(userID);
                request.setAttribute("user", user);
                String provinceName = LocationService.getProvinceName(user.getProvinceID());
                String districtName = LocationService.getDistrictName(user.getDistrictID());
                String wardName = LocationService.getWardName(user.getDistrictID(), user.getWardID());
                request.setAttribute("provinceName", provinceName);
                request.setAttribute("districtName", districtName);
                request.setAttribute("email", email);
                request.setAttribute("phonenumber", phonenumber);
                session.setAttribute("user", user);
                out.println("<script type='text/javascript'>");
                        out.println("alert('Cập nhật thông tin thành công!');");
                        out.println("window.location.href='User?action=viewSelf';"); // Chuyển hướng sau khi hiển thị thông báo
                        out.println("</script>");
            } else if (action.equals("editPassword")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/editPassword.jsp");
                rs.forward(request, response);
            } else if (action.equals("editpassword")) {
                String oldPass = request.getParameter("oldpass");
                String newpass = request.getParameter("newpass");
                String xacnhan = request.getParameter("xacnhan");
                String error1 = "Vui lòng nhập đúng mật khẩu cũ !!!!";
                String error2 = "Vui lòng nhập đúng mật khẩu xác nhận !!!";
                if (UserDAO.hashPassword(oldPass).equals(user.getPassword())) {
                    if (newpass.equals(xacnhan)) {
                        UserDAO.updatePassword(user, UserDAO.hashPassword(newpass));
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Cập nhật mật khẩu thành công!');");
                        out.println("window.location.href='User?action=viewSelf';"); // Chuyển hướng sau khi hiển thị thông báo
                        out.println("</script>");
                    } else {
                        request.setAttribute("error2", error2 );
                        RequestDispatcher rs = request.getRequestDispatcher("view/editPassword.jsp");
                        rs.forward(request, response);
                    }

                } else {
                    request.setAttribute("error1", error1 );
                    RequestDispatcher rs = request.getRequestDispatcher("view/editPassword.jsp");
                    rs.forward(request, response);
                }
            } else if (action.equals("addHighPeople")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/addHighPeople.jsp");
                rs.forward(request, response);
            }

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
            if (action.equals("addChild")) {
                String suffix = request.getParameter("suffix");
                String fullName = request.getParameter("fullName");
                String dateOfBirth = request.getParameter("dateOfBirth");
                int provinceID = Integer.parseInt(request.getParameter("provinceID"));
                int districtID = Integer.parseInt(request.getParameter("districtID"));
                int wardID = Integer.parseInt(request.getParameter("wardID"));
                String addressDetail = request.getParameter("addressDetail");
                UserDAO.addChildUser(fullName, dateOfBirth, user.getCCCD() + suffix, provinceID, districtID, wardID, addressDetail);
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Đăng ký thành công!');");
                out.println("window.location.href = 'User?action=childManagement';");
                out.println("</script>");
            } else if (action.equals("edit")) {
                int userId = Integer.parseInt(request.getParameter("userID"));
                String fullName = request.getParameter("fullname");
                String dateofbirth = request.getParameter("dateofbirth");
                String cccd = request.getParameter("cccd");
                String email = request.getParameter("email");
                String phonenumber = request.getParameter("phonenumber");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                int provinceId = Integer.parseInt(request.getParameter("provinceId"));
                int districtId = Integer.parseInt(request.getParameter("districtId"));
                int wardId = Integer.parseInt(request.getParameter("wardId"));
                String address = request.getParameter("address");
                String status = request.getParameter("status");

                User usernew = new User(userId, fullName, dateofbirth, cccd, email, phonenumber, password, role, provinceId, districtId, wardId, address, status);
                usernew = UserDAO.updateUser(usernew);
                request.setAttribute("usernew", usernew);
                RequestDispatcher rs = request.getRequestDispatcher("view/editUserResult.jsp");
                rs.forward(request, response);
            } else if (action.equals("addHighPeople")) {
                String fullName = request.getParameter("fullName");
                String CCCD = request.getParameter("userName");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                int proviceID = Integer.parseInt(request.getParameter("provinceID"));
                int districtID = Integer.parseInt(request.getParameter("districtID"));
                int wardID = Integer.parseInt(request.getParameter("wardID"));
                String addressDetail = request.getParameter("addressDetail");
                UserDAO.addHighUser(fullName, CCCD, password, role, proviceID, districtID, wardID, addressDetail);
                RequestDispatcher rs = request.getRequestDispatcher("view/Admin.jsp");
                rs.forward(request, response);
            }
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
