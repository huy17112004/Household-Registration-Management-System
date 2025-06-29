/////*
//// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
//// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
//// */
//

package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.User;
import util.EmailService;

public class ApproveOrRejectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try (PrintWriter out = response.getWriter()) {
            String cccd = request.getParameter("cccd");
            String action = request.getParameter("action");

            System.out.println("[DEBUG] Processing request - CCCD: " + cccd + ", Action: " + action);

            if (cccd == null || cccd.isEmpty() || action == null || action.isEmpty()) {
                System.out.println("[ERROR] Invalid parameters: CCCD or Action is null/empty");
                out.print("error_invalid_params");
                return;
            }

            if (action.equals("approve")) {
                System.out.println("[DEBUG] Attempting to approve user with CCCD: " + cccd);
                boolean success = UserDAO.approveUser(cccd);
                System.out.println("[DEBUG] approveUser result: " + success);
                if (success) {
                    User user = UserDAO.getUserByCCCD(cccd);
                    if (user != null) {
                        System.out.println("[DEBUG] User found - FullName: " + user.getFullName() + ", Email: " + user.getEmail());
                        if (user.getEmail() != null && !user.getEmail().isEmpty()) {
                            String email = user.getEmail();
                            String subject = "Tài khoản của bạn đã được phê duyệt";
                            String body = "Chào " + user.getFullName() + ",\n\n" +
                                          "Tài khoản của bạn với CCCD " + cccd + " đã được phê duyệt thành công. " +
                                          "Bạn có thể đăng nhập vào hệ thống ngay bây giờ.\n\n" +
                                          "Trân trọng,\nHệ thống quản lý";
                            System.out.println("[DEBUG] Attempting to send approval email to: " + email);
                            try {
                                EmailService.sendEmail(email, subject, body);
                                System.out.println("[DEBUG] Email sent successfully to: " + email);
                                out.print("approved");
                            } catch (IOException e) {
                                System.err.println("[ERROR] Failed to send approval email: " + e.getMessage());
                                out.print("error_email_failed");
                            }
                        } else {
                            System.out.println("[WARN] Email is null or empty for CCCD: " + cccd);
                            out.print("approved_no_email");
                        }
                    } else {
                        System.out.println("[ERROR] User not found for CCCD: " + cccd);
                        out.print("error_user_not_found");
                    }
                } else {
                    System.out.println("[ERROR] Approval failed for CCCD: " + cccd);
                    out.print("error_approval_failed");
                }
            } else if (action.equals("reject")) {
                System.out.println("[DEBUG] Attempting to reject user with CCCD: " + cccd);
                boolean success = UserDAO.rejectUser(cccd);
                System.out.println("[DEBUG] rejectUser result: " + success);
                if (success) {
                    User user = UserDAO.getUserByCCCD(cccd);
                    if (user != null && user.getEmail() != null && !user.getEmail().isEmpty()) {
                        String email = user.getEmail();
                        String subject = "Tài khoản của bạn đã bị từ chối";
                        String body = "Chào " + user.getFullName() + ",\n\n" +
                                      "Tài khoản của bạn với CCCD " + cccd + " đã bị từ chối. " +
                                      "Vui lòng liên hệ quản trị viên để biết thêm chi tiết.\n\n" +
                                      "Trân trọng,\nHệ thống quản lý";
                        System.out.println("[DEBUG] Attempting to send rejection email to: " + email);
                        try {
                            EmailService.sendEmail(email, subject, body);
                            System.out.println("[DEBUG] Email sent successfully to: " + email);
                            out.print("rejected");
                        } catch (IOException e) {
                            System.err.println("[ERROR] Failed to send rejection email: " + e.getMessage());
                            out.print("error_email_failed");
                        }
                    } else {
                        System.out.println("[WARN] User or Email is null/empty for CCCD: " + cccd);
                        out.print("rejected_no_email");
                    }
                } else {
                    System.out.println("[ERROR] Rejection failed for CCCD: " + cccd);
                    out.print("error_rejection_failed");
                }
            } else {
                System.out.println("[ERROR] Invalid action: " + action);
                out.print("error_invalid_action");
            }
        } catch (Exception e) {
            System.err.println("[ERROR] Exception occurred: " + e.getMessage());
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("error_exception");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for approving or rejecting users";
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApproveOrRejectServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApproveOrRejectServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}

