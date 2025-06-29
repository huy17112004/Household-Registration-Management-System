package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;

public class RegisterChildServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            request.getRequestDispatcher("view/registerChild.jsp").forward(request, response);
        } else if ("checkParent".equals(action)) {
            String parentCCCD = request.getParameter("parentCCCD");
            if (parentCCCD == null || !parentCCCD.matches("\\d{12}")) {
                request.setAttribute("error", "CCCD không hợp lệ. Vui lòng nhập 12 chữ số.");
                request.getRequestDispatcher("view/registerChild.jsp").forward(request, response);
                return;
            }

            User parent = UserDAO.getUserByCCCD(parentCCCD);
            if (parent == null) {
                request.setAttribute("error", "CCCD của bố/mẹ không tồn tại trong hệ thống.");
                request.getRequestDispatcher("view/registerChild.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách con dựa trên CCCD tạm (bắt đầu bằng CCCD của bố/mẹ)
            List<User> children = UserDAO.getUserByParentCCCD(parentCCCD);
            request.setAttribute("parentCCCD", parentCCCD);
            request.setAttribute("children", children);
            request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
        } else if ("editChild".equals(action)) {
            String childCCCD = request.getParameter("childCCCD");
            User child = UserDAO.getUserByCCCD(childCCCD);
            if (child == null) {
                request.setAttribute("error", "Không tìm thấy thông tin con với CCCD: " + childCCCD);
                request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
                return;
            }

            // Set trạng thái tài khoản con là "approved" để không cần xác nhận
            child.setStatus("approved");

            // Lấy danh sách tỉnh, huyện, xã từ API (giả định LocationService đã được định nghĩa)
            JSONArray provincesArray = LocationService.getAllProvinces();
            if (provincesArray == null || provincesArray.length() == 0) {
                request.setAttribute("error", "Không thể tải danh sách tỉnh từ API.");
                request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
                return;
            }
            List<JSONObject> provinces = new ArrayList<>();
            for (int i = 0; i < provincesArray.length(); i++) {
                provinces.add(provincesArray.getJSONObject(i));
            }

            int provinceID = child.getProvinceID() > 0 ? child.getProvinceID() : provinces.get(0).getInt("code");
            JSONArray districtsArray = LocationService.getDistrictsByProvince(provinceID);
            if (districtsArray == null || districtsArray.length() == 0) {
                request.setAttribute("error", "Không thể tải danh sách huyện từ API.");
                request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
                return;
            }
            List<JSONObject> districts = new ArrayList<>();
            for (int i = 0; i < districtsArray.length(); i++) {
                districts.add(districtsArray.getJSONObject(i));
            }

            int districtID = child.getDistrictID() > 0 ? child.getDistrictID() : districts.get(0).getInt("code");
            JSONArray wardsArray = LocationService.getWardsByDistrict(districtID);
            if (wardsArray == null || wardsArray.length() == 0) {
                request.setAttribute("error", "Không thể tải danh sách xã từ API.");
                request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
                return;
            }
            List<JSONObject> wards = new ArrayList<>();
            for (int i = 0; i < wardsArray.length(); i++) {
                wards.add(wardsArray.getJSONObject(i));
            }

            request.setAttribute("provinces", provinces);
            request.setAttribute("districts", districts);
            request.setAttribute("wards", wards);
            request.setAttribute("child", child);
            request.getRequestDispatcher("view/editChild.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if ("updateChild".equals(action)) {
            String oldChildCCCD = request.getParameter("oldChildCCCD");
            String newChildCCCD = request.getParameter("childCCCD");
            String fullName = request.getParameter("fullname");
            String dateOfBirth = request.getParameter("dateofbirth");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phonenumber");
            String password = request.getParameter("password");
            int provinceID = Integer.parseInt(request.getParameter("provinceid"));
            int districtID = Integer.parseInt(request.getParameter("districtid"));
            int wardID = Integer.parseInt(request.getParameter("wardid"));
            String addressDetail = request.getParameter("addressdetail");

            if (fullName == null || fullName.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Họ tên và mật khẩu không được để trống.");
                reloadLocationData(request, provinceID, districtID, oldChildCCCD);
                request.getRequestDispatcher("view/editChild.jsp").forward(request, response);
                return;
            }

            if (!newChildCCCD.equals(oldChildCCCD) && UserDAO.isCCCDExists(newChildCCCD)) {
                request.setAttribute("error", "CCCD mới đã tồn tại trong hệ thống.");
                reloadLocationData(request, provinceID, districtID, oldChildCCCD);
                request.getRequestDispatcher("view/editChild.jsp").forward(request, response);
                return;
            }

            User updatedChild = new User(
                1, fullName, dateOfBirth, newChildCCCD, email, phoneNumber, password, "citizen",
                provinceID, districtID, wardID, addressDetail, "approved" // Set trạng thái là approved
            );

            boolean success = UserDAO.updateChildInfo(updatedChild, oldChildCCCD);
            if (success) {
                request.setAttribute("message", "Cập nhật thông tin con thành công.");
                request.getRequestDispatcher("view/signIn.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cập nhật thông tin thất bại. Vui lòng thử lại.");
                reloadLocationData(request, provinceID, districtID, oldChildCCCD);
                request.getRequestDispatcher("view/editChild.jsp").forward(request, response);
            }
        } else {
            String oldChildCCCD = request.getParameter("oldChildCCCD");
            User child = UserDAO.getAccountByCCCD(oldChildCCCD);
            if (child == null) {
                request.setAttribute("error", "Không tìm thấy thông tin con.");
                request.getRequestDispatcher("view/selectChild.jsp").forward(request, response);
                return;
            }

            String provinceIdStr = request.getParameter("provinceid");
            String districtIdStr = request.getParameter("districtid");
            int provinceID = provinceIdStr != null && !provinceIdStr.isEmpty() ? Integer.parseInt(provinceIdStr) : child.getProvinceID();
            int districtID = districtIdStr != null && !districtIdStr.isEmpty() ? Integer.parseInt(districtIdStr) : child.getDistrictID();

            reloadLocationData(request, provinceID, districtID, oldChildCCCD);
            request.getRequestDispatcher("view/editChild.jsp").forward(request, response);
        }
    }

    private void reloadLocationData(HttpServletRequest request, int provinceID, int districtID, String oldChildCCCD) {
        User child = UserDAO.getAccountByCCCD(oldChildCCCD);
        if (child == null) {
            request.setAttribute("error", "Không tìm thấy thông tin con.");
            return;
        }

        JSONArray provincesArray = LocationService.getAllProvinces();
        if (provincesArray == null || provincesArray.length() == 0) {
            request.setAttribute("error", "Không thể tải danh sách tỉnh từ API.");
            return;
        }
        List<JSONObject> provinces = new ArrayList<>();
        for (int i = 0; i < provincesArray.length(); i++) {
            provinces.add(provincesArray.getJSONObject(i));
        }

        JSONArray districtsArray = LocationService.getDistrictsByProvince(provinceID);
        if (districtsArray == null || districtsArray.length() == 0) {
            request.setAttribute("error", "Không thể tải danh sách huyện từ API.");
            return;
        }
        List<JSONObject> districts = new ArrayList<>();
        for (int i = 0; i < districtsArray.length(); i++) {
            districts.add(districtsArray.getJSONObject(i));
        }

        JSONArray wardsArray = LocationService.getWardsByDistrict(districtID);
        if (wardsArray == null || wardsArray.length() == 0) {
            request.setAttribute("error", "Không thể tải danh sách xã từ API.");
            return;
        }
        List<JSONObject> wards = new ArrayList<>();
        for (int i = 0; i < wardsArray.length(); i++) {
            wards.add(wardsArray.getJSONObject(i));
        }

        request.setAttribute("provinces", provinces);
        request.setAttribute("districts", districts);
        request.setAttribute("wards", wards);
        request.setAttribute("child", child);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for registering or editing a child's information";
    }
}
