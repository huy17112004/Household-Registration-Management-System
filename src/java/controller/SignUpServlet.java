package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import model.Location;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;

public class SignUpServlet extends HttpServlet {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern CCCD_PATTERN = Pattern.compile("^\\d{12}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
         
        String reset = request.getParameter("reset");
        if ("true".equals(reset)) {
            request.removeAttribute("fullname");
            request.removeAttribute("dateofbirth");
            request.removeAttribute("cccd");
            request.removeAttribute("email");
            request.removeAttribute("phonenumber");
            request.removeAttribute("password");
            request.removeAttribute("confirmpassword");
            request.removeAttribute("addressdetail");
        }

        loadInitialLocationData(request);
        RequestDispatcher rs = request.getRequestDispatcher("view/signUp.jsp");
        rs.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String provinceIdStr = request.getParameter("provinceid");
        String districtIdStr = request.getParameter("districtid");
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String fullName = request.getParameter("fullname");
            String dateOfBirth = request.getParameter("dateofbirth");
            String cccd = request.getParameter("cccd");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phonenumber");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");

            Map<String, String> errors = new HashMap<>();
            int provinceId = 0, districtId = 0, wardId = 0;
            try {
                if (provinceIdStr != null && !provinceIdStr.trim().isEmpty()) {
                    provinceId = Integer.parseInt(provinceIdStr);
                }
                if (districtIdStr != null && !districtIdStr.trim().isEmpty()) {
                    districtId = Integer.parseInt(districtIdStr);
                }
                String wardIdStr = request.getParameter("wardid");
                if (wardIdStr != null && !wardIdStr.trim().isEmpty()) {
                    wardId = Integer.parseInt(wardIdStr);
                }
            } catch (NumberFormatException e) {
                errors.put("locationError", "Dữ liệu địa điểm không hợp lệ.");
            }

            String addressDetail = request.getParameter("addressdetail");

            if (!isValidCCCD(cccd)) {
                errors.put("cccdError", "CCCD phải là số và có đúng 12 chữ số.");
            } else if (UserDAO.isCCCDExists(cccd)) {
                errors.put("cccdError", "CCCD đã tồn tại trong hệ thống.");
            }

            if (!isValidEmail(email)) {
                errors.put("emailError", "Email không đúng định dạng.");
            } else if (UserDAO.isEmailExists(email)) {
                errors.put("emailError", "Email đã tồn tại trong hệ thống.");
            }

            if (!isValidPhoneNumber(phoneNumber)) {
                errors.put("phoneError", "Số điện thoại phải là số và có đúng 10 chữ số.");
            } else if (UserDAO.isPhoneNumberExists(phoneNumber)) {
                errors.put("phoneError", "Số điện thoại đã tồn tại trong hệ thống.");
            }
            if (!isPasswordConfirmed(password, confirmPassword)) {
                errors.put("passwordError", "Mật khẩu và xác nhận mật khẩu không khớp.");
            }

            // [SỬA] Thêm kiểm tra mật khẩu hợp lệ (ít nhất 8 ký tự, chứa số và chữ cái)
            if (!isPasswordConfirmed(password, confirmPassword)) {
                errors.put("passwordError", "Mật khẩu và xác nhận mật khẩu không khớp.");
            } else if (!isValidPassword(password)) { // [THÊM MỚI] Kiểm tra định dạng mật khẩu
                errors.put("passwordError", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả số và chữ cái.");
            }
            
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("fullname", fullName);
                request.setAttribute("dateofbirth", dateOfBirth);
                request.setAttribute("cccd", cccd);
                request.setAttribute("email", email);
                request.setAttribute("phonenumber", phoneNumber);
                request.setAttribute("password", password);
                request.setAttribute("confirmpassword", confirmPassword);
                request.setAttribute("addressdetail", addressDetail);

                loadLocationData(request, provinceId, districtId, wardId);
                RequestDispatcher rs = request.getRequestDispatcher("view/signUp.jsp");
                rs.forward(request, response);
                return;
            }

            User user = new User(1,fullName, dateOfBirth, cccd, email, phoneNumber, password, 
                              "Citizen", provinceId, districtId, wardId, addressDetail, "pending");
            User registeredUser = UserDAO.signUpUser(user);

            if (registeredUser != null) {
                request.getSession().invalidate();
                request.setAttribute("message", "Tài khoản của bạn đã được ghi nhận. Vui lòng đợi phê duyệt.");
                RequestDispatcher rs = request.getRequestDispatcher("view/signUpSuccessful.jsp");
                rs.forward(request, response);
            } else {
                request.setAttribute("message", "Đăng ký thất bại. Vui lòng thử lại.");
                request.setAttribute("fullname", fullName);
                request.setAttribute("dateofbirth", dateOfBirth);
                request.setAttribute("cccd", cccd);
                request.setAttribute("email", email);
                request.setAttribute("phonenumber", phoneNumber);
                request.setAttribute("password", password);
                request.setAttribute("confirmpassword", confirmPassword);
                request.setAttribute("addressdetail", addressDetail);

                loadLocationData(request, provinceId, districtId, wardId);
                RequestDispatcher rs = request.getRequestDispatcher("view/signUp.jsp");
                rs.forward(request, response);
            }
        } else {
            int provinceId = 0, districtId = 0;
            try {
                if (provinceIdStr != null && !provinceIdStr.trim().isEmpty()) {
                    provinceId = Integer.parseInt(provinceIdStr);
                }
                if (districtIdStr != null && !districtIdStr.trim().isEmpty()) {
                    districtId = Integer.parseInt(districtIdStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("NumberFormatException: " + e.getMessage());
            }

            loadLocationData(request, provinceId, districtId, 0);
            RequestDispatcher rs = request.getRequestDispatcher("view/signUp.jsp");
            rs.forward(request, response);
        }
    }

    private void loadInitialLocationData(HttpServletRequest request) {
        JSONArray provincesJson = LocationService.getAllProvinces();
        List<Location> provinces = convertJsonArrayToLocations(provincesJson);
        request.setAttribute("provinces", provinces != null ? provinces : new ArrayList<>());

        if (provinces != null && !provinces.isEmpty()) {
            int firstProvinceCode = provinces.get(0).getCode();
            JSONArray districtsJson = LocationService.getDistrictsByProvince(firstProvinceCode);
            List<Location> districts = convertJsonArrayToLocations(districtsJson);
            request.setAttribute("districts", districts != null ? districts : new ArrayList<>());

            if (districts != null && !districts.isEmpty()) {
                int firstDistrictCode = districts.get(0).getCode();
                JSONArray wardsJson = LocationService.getWardsByDistrict(firstDistrictCode);
                List<Location> wards = convertJsonArrayToLocations(wardsJson);
                request.setAttribute("wards", wards != null ? wards : new ArrayList<>());
            } else {
                request.setAttribute("wards", new ArrayList<>());
            }
        } else {
            request.setAttribute("districts", new ArrayList<>());
            request.setAttribute("wards", new ArrayList<>());
        }
    }

    private void loadLocationData(HttpServletRequest request, int provinceId, int districtId, int wardId) {
        JSONArray provincesJson = LocationService.getAllProvinces();
        List<Location> provinces = convertJsonArrayToLocations(provincesJson);
        request.setAttribute("provinces", provinces != null ? provinces : new ArrayList<>());

        JSONArray districtsJson = provinceId != 0 ? LocationService.getDistrictsByProvince(provinceId) : new JSONArray();
        List<Location> districts = convertJsonArrayToLocations(districtsJson);
        request.setAttribute("districts", districts != null ? districts : new ArrayList<>());

        JSONArray wardsJson = districtId != 0 ? LocationService.getWardsByDistrict(districtId) : new JSONArray();
        List<Location> wards = convertJsonArrayToLocations(wardsJson);
        request.setAttribute("wards", wards != null ? wards : new ArrayList<>());

        request.setAttribute("provinceId", provinceId);
        request.setAttribute("districtId", districtId);
        request.setAttribute("wardId", wardId);

        request.setAttribute("fullname", request.getParameter("fullname"));
        request.setAttribute("dateofbirth", request.getParameter("dateofbirth"));
        request.setAttribute("cccd", request.getParameter("cccd"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("phonenumber", request.getParameter("phonenumber"));
        request.setAttribute("password", request.getParameter("password"));
        request.setAttribute("confirmpassword", request.getParameter("confirmpassword"));
        request.setAttribute("addressdetail", request.getParameter("addressdetail"));
    }

    private List<Location> convertJsonArrayToLocations(JSONArray jsonArray) {
        if (jsonArray == null) return new ArrayList<>();
        List<Location> locations = new ArrayList<>();
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                int code = jsonObject.getInt("code");
                String name = jsonObject.getString("name");
                locations.add(new Location(code, name));
            } catch (Exception e) {
                System.err.println("Error parsing JSON object: " + e.getMessage());
            }
        }
        return locations;
    }

    private boolean isValidCCCD(String cccd) {
        return cccd != null && !cccd.trim().isEmpty() && CCCD_PATTERN.matcher(cccd).matches();
    }

    private boolean isValidEmail(String email) {
        return email != null && !email.trim().isEmpty() && EMAIL_PATTERN.matcher(email).matches();
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && !phoneNumber.trim().isEmpty() && PHONE_PATTERN.matcher(phoneNumber).matches();
    }

    private boolean isPasswordConfirmed(String password, String confirmPassword) {
        return password != null && confirmPassword != null && password.equals(confirmPassword);
    }

    // [THÊM MỚI] Phương thức kiểm tra định dạng mật khẩu theo yêu cầu
    private boolean isValidPassword(String password) {
        return password != null && !password.trim().isEmpty() && PASSWORD_PATTERN.matcher(password).matches();
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet for user sign up";
    }
}