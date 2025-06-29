/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HouseholdDAO;
import dao.HouseholdMemberDAO;
import dao.LogDAO;
import dao.NotificationDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Household;
import model.HouseholdMember;
import model.Log;
import model.Notification;
import model.User;

/**
 *
 * @author Huytayto
 */
@WebServlet(name = "NotificationServlet", urlPatterns = {"/Notification"})
public class NotificationServlet extends HttpServlet {

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
            out.println("<title>Servlet NotificationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NotificationServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("signIn"); // Chuyển hướng về trang đăng nhập
            return;
        }
        User user = (User) session.getAttribute("user");
        if (action.equals("view")) {
            ArrayList<Notification> notifications = NotificationDAO.getNotificationsByUserID(user.getUserID());
            request.setAttribute("notifications", notifications);
            NotificationDAO.updateIsReadByUserID(user.getUserID());
            RequestDispatcher rs = request.getRequestDispatcher("view/notificationView.jsp");
            rs.forward(request, response);

        } else if (action.equals("viewHousehold")) {
                HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByUserID(user.getUserID());
                if (householdMember != null) {
                    request.setAttribute("householdMember", householdMember);
                    ArrayList<HouseholdMember> householdMembers = HouseholdMemberDAO.getHouseholdMemberByHouseholdIDIncludingUser(householdMember.getHouseholdID());
                    Household household = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    if (householdMember.getRelationship().equals("Chủ hộ")) {
                        request.setAttribute("isHead", "YES");
                        if (householdMembers.size() == 1) {
                            request.setAttribute("canDelete", "YES");
                        }
                    }
                    request.setAttribute("householdMembers", householdMembers);
                    request.setAttribute("household", household);
                }
                Log log = LogDAO.getTemporaryByUserID(user.getUserID());
                if (log != null) {
                    request.setAttribute("log", log);
                    User headTemporary = UserDAO.getUserByUserID(log.getHousehold().getHeadOfHouseholdID());
                    String provinceNameHH = LocationService.getProvinceName(log.getHousehold().getProvinceID());
                    String districtNameHH = LocationService.getDistrictName(log.getHousehold().getDistrictID());
                    String wardNameHH = LocationService.getWardName(log.getHousehold().getDistrictID(), log.getHousehold().getWardID());
                    request.setAttribute("addressDetailMoreHousehold", log.getHousehold().getAddressDetail() + ", " + wardNameHH + ", " + districtNameHH + ", " + provinceNameHH);
                    request.setAttribute("headTemporary", headTemporary);
                }
                RequestDispatcher rs = request.getRequestDispatcher("view/citizenViewHousehold.jsp");
                rs.forward(request, response);
            } else if (action.equals("deleteHousehold")) {
                int householdID = Integer.parseInt(request.getParameter("householdID"));
                HouseholdDAO.deleteHousehold(householdID);
                out.println("<script type='text/javascript'>");
                out.println("alert('Xoá hộ khẩu thành công!');");
                out.println("window.location.href='Notification?action=viewHousehold';"); // Chuyển hướng sau khi hiển thị thông báo
                out.println("</script>");
            } else if (action.equals("changeRelationship")) {
                int memberID = Integer.parseInt(request.getParameter("memberID"));
                String relationship = request.getParameter("relationship");
                HouseholdMemberDAO.updateRelationShipHouseholdMember(memberID, relationship);
                out.println("<script type='text/javascript'>");
                out.println("alert('Đổi mối quan hệ với chủ hộ thành công!');");
                out.println("window.location.href='Notification?action=viewHousehold';"); // Chuyển hướng sau khi hiển thị thông báo
                out.println("</script>");
            } else if (action.equals("changeHead")) {
                String newRelationship = request.getParameter("relationship");
                int newHeadID = Integer.parseInt(request.getParameter("newHeadID"));
                int memberID = Integer.parseInt(request.getParameter("memberID"));
                int householdID = Integer.parseInt(request.getParameter("householdID"));
                HouseholdDAO.updateHeadOfHousehold(householdID, newHeadID);
                HouseholdMemberDAO.updateRelationShipHouseholdMember(memberID, newRelationship);
                HouseholdMember householdMemberHead = HouseholdMemberDAO.getHouseholdMemberByUserID(newHeadID);
                HouseholdMemberDAO.updateRelationShipHouseholdMember(householdMemberHead.getMemberID(), "Chủ hộ");
                out.println("<script type='text/javascript'>");
                out.println("alert('Đổi chủ hộ khẩu thành công!');");
                out.println("window.location.href='Notification?action=viewHousehold';"); // Chuyển hướng sau khi hiển thị thông báo
                out.println("</script>");
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
        processRequest(request, response);
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
