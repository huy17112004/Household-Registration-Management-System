/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HouseholdDAO;
import dao.LogDAO;
import dao.NotificationDAO;
import dao.RegistrationDAO;
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
import model.Household;
import model.Log;
import model.Registration;
import model.SendMail;
import model.User;

/**
 *
 * @author GIGABYTE
 */
public class RegistrationServlet extends HttpServlet {

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
            out.println("<title>Servlet RegistrationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        response.setContentType("text/html;charset=UTF-8");
        ArrayList<Registration> registrations = new ArrayList<Registration>();
        try (PrintWriter out = response.getWriter()) {
            if (action == null) {

        } else if (action.equals("listreg")) {
            registrations = RegistrationDAO.getRegistrations();
            request.setAttribute("registrations", registrations);
            RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
            rs.forward(request, response);
        } else if (action.equals("searchRegByType")) {
            String RegistrationType = request.getParameter("RegistrationType");
            registrations = RegistrationDAO.getRegistrationByType(RegistrationType);
            
            request.setAttribute("registrations", registrations);
            request.setAttribute("RegistrationType", RegistrationType);
            RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
            rs.forward(request, response);
        } else if (action.equals("searchRegByStatus")) {
            String Status = request.getParameter("Status");
            registrations = RegistrationDAO.getRegistrationByType(Status);
            request.setAttribute("registrations", registrations);
            request.setAttribute("Status", Status);
            RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
            rs.forward(request, response);
        } 
        else if(action.equals("viewregistration")){
            int  UserID = Integer.parseInt( request.getParameter("userID"));
            String userRole = user.getRole();
            registrations = RegistrationDAO.getRegistrationByUserId(user.getUserID());
            request.setAttribute("registrations", registrations);
            request.setAttribute("userRole", userRole);
            
            RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
            rs.forward(request, response);
        } else if (action.equals("sendReport")) {
            int logID = Integer.parseInt(request.getParameter("logID"));
            Log log = LogDAO.getLogByLogID(logID);
            Household household = HouseholdDAO.getHouseholdByHouseholdID(log.getHouseholdID());
            User citizen = UserDAO.getUserByUserID(log.getUserID());
            SendMail.send(citizen.getEmail(), "Bạn sẽ hết hạn tạm trú tại hộ khẩu " + household.getHouseholdCode() + " vào ngày " + log.getEndDate(), "");
            NotificationDAO.addNotification(log.getUserID(), "Bạn sẽ hết hạn tạm trú tại hộ khẩu " + household.getHouseholdCode() + " vào ngày " + log.getEndDate());
            out.println("<script type='text/javascript'>");
                        out.println("alert('Gửi thông báo thành công!');");
                        out.println("window.location.href='Household?action=registrationNotification';"); // Chuyển hướng sau khi hiển thị thông báo
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
