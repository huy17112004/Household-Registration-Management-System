/*
 * Click nbsp://nbsp/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbsp://nbsp/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;
import model.User;

/**
 *
 * @author Dell
 */
public class ResetPasswordServlet extends HttpServlet {

    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String cccd = (String) session.getAttribute("cccd");

        // Kiểm tra xem CCCD có tồn tại trong session không (để đảm bảo người dùng đã qua bước xác nhận OTP)
        if (cccd == null) {
            request.setAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thực hiện lại từ đầu!");
            request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
            return;
        }

        // Hiển thị form đặt lại mật khẩu (không đặt message để tránh hiển thị thông báo thành công)
        request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String cccd = (String) session.getAttribute("cccd");

        // Kiểm tra xem CCCD có tồn tại trong session không
        if (cccd == null) {
            request.setAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thực hiện lại từ đầu!");
            request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
            return;
        }

        // Lấy dữ liệu từ form
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu mới và xác nhận mật khẩu
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu mới không được để trống!");
            request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng mật khẩu: ít nhất 8 ký tự, chứa cả số và chữ cái
        if (!isValidPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả số và chữ cái!");
            request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu trong cơ sở dữ liệu
        try {
            User user = UserDAO.getUserByCCCD(cccd);
            if (user == null) {
                request.setAttribute("error", "Người dùng không tồn tại!");
                request.getRequestDispatcher("view/forgotPassword.jsp").forward(request, response);
                return;
            }

            // Cập nhật mật khẩu
            boolean updated = UserDAO.updatePassword(cccd, newPassword);
            if (updated) {
                // Xóa các thuộc tính trong session sau khi đặt lại mật khẩu thành công
                session.removeAttribute("cccd");
                session.removeAttribute("otp");
                session.removeAttribute("otpTimestamp");

                // Hiển thị thông báo thành công trong resetPassword.jsp
                request.setAttribute("message", "Mật khẩu đã được đặt lại thành công!");
                request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại!");
                request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!");
            request.getRequestDispatcher("view/resetPassword.jsp").forward(request, response);
        }
    }

    private boolean isValidPassword(String password) {
        return password != null && !password.trim().isEmpty() && PASSWORD_PATTERN.matcher(password).matches();
    }

    @Override
    public String getServletInfo() {
        return "Servlet for resetting user password";
    }
}
