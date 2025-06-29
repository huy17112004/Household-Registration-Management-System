package controller;

import dao.RegistrationDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.Registration;
import model.User;

public class SignInServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            String userInput = request.getParameter("userInput");
            String password = request.getParameter("password");
            // Kiểm tra nếu tài khoản hoặc mật khẩu bị để trống
            if (userInput == null || userInput.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Tài khoản và mật khẩu không được để trống!");
                request.setAttribute("userInput", userInput); // Lưu userInput để hiển thị lại
                System.out.println("DEBUG: Error set - Tài khoản và mật khẩu không được để trống!");
                request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
                return;
            }
            User user = UserDAO.getUserByCCCDAndPassword(userInput, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                String role = user.getRole() != null ? user.getRole() : "";
                if ("Police".equalsIgnoreCase(role)) {
//                   
                    request.getRequestDispatcher("view/policeWelcome.jsp").forward(request, response);
                } else if ("AreaLeader".equalsIgnoreCase(role)) {
                    request.getRequestDispatcher("view/areaLeaderWelcome.jsp").forward(request, response);
                } else if ("Citizen".equalsIgnoreCase(role)) {
                    String status = user.getStatus() != null ? user.getStatus() : "";
                    if ("approved".equalsIgnoreCase(status)) {
                        request.getRequestDispatcher("view/household.jsp").forward(request, response);
                    } else if ("pending".equalsIgnoreCase(status)) {
                        request.setAttribute("error", "Tài khoản của bạn đang chờ phê duyệt!");
                        request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
                    } else if ("rejected".equalsIgnoreCase(status)) {
                        request.setAttribute("error", "Tài khoản của bạn đã bị từ chối!");
                        request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Trạng thái tài khoản không hợp lệ!");
                        request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
                    }
                }else if (role.equals("Admin")) {
                    RequestDispatcher rs = request.getRequestDispatcher("view/Admin.jsp");
                    rs.forward(request, response);
                } else {
                    request.setAttribute("error", "Vai trò người dùng không hợp lệ!");
                    request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Số điện thoại, email hoặc mật khẩu không đúng!");
                request.setAttribute("userInput", userInput); // Lưu userInput để hiển thị lại
                request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Hành động không hợp lệ!");
            request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập";
    }
}
