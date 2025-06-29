/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import model.User;
import util.EmailService;

/**
 *
 * @author Dell
 */
public class ForgotPasswordServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ForgotPasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("requestOTP".equals(action)) {
            String cccd = request.getParameter("cccd");
            
            if (cccd == null || cccd.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập CCCD!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
                return;
            }

            User user = UserDAO.getUserByCCCD(cccd);
            if (user == null) {
                request.setAttribute("error", "CCCD không tồn tại trong hệ thống!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
                return;
            }

            // Tạo OTP
            String otp = generateOTP();
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("cccd", cccd);
            session.setAttribute("otpTimestamp", System.currentTimeMillis());

            // Gửi email chứa OTP
            try {
                EmailService.sendEmail(
                    user.getEmail(),
                    "Xác nhận OTP để đặt lại mật khẩu",
                    "Mã OTP của bạn là: " + otp + "\nMã này có hiệu lực trong 5 phút."
                );
                request.setAttribute("message", "OTP đã được gửi đến email của bạn!");
                request.getRequestDispatcher("view/verifyOTP.jsp").forward(request, response);
            } catch (IOException e) {
                request.setAttribute("error", "Không thể gửi OTP. Vui lòng thử lại!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
            }

        } else if ("verifyOTP".equals(action)) {
            String inputOtp = request.getParameter("otp");
            HttpSession session = request.getSession();
            String storedOtp = (String) session.getAttribute("otp");
            String cccd = (String) session.getAttribute("cccd");
            Long otpTimestamp = (Long) session.getAttribute("otpTimestamp");

            if (storedOtp == null || cccd == null || otpTimestamp == null) {
                request.setAttribute("error", "Phiên xác nhận đã hết hạn. Vui lòng yêu cầu OTP mới!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
                return;
            }

            // Kiểm tra thời hạn 5 phút
            long currentTime = System.currentTimeMillis();
            if (currentTime - otpTimestamp > 5 * 60 * 1000) {
                session.removeAttribute("otp");
                session.removeAttribute("cccd");
                session.removeAttribute("otpTimestamp");
                request.setAttribute("error", "OTP đã hết hạn. Vui lòng yêu cầu OTP mới!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
                return;
            }

            if (storedOtp.equals(inputOtp)) {
                request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "OTP không đúng!");
                request.getRequestDispatcher("view/verifyOTP.jsp").forward(request, response);
            }
        }
    }

    // Phương thức tạo OTP
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo số ngẫu nhiên 6 chữ số
        return String.valueOf(otp);
    }
    
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
