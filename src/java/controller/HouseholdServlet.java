/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HouseholdDAO;
import dao.HouseholdMemberDAO;
import dao.LogDAO;
import dao.NotificationDAO;
import dao.RegistrationDAO;
import dao.RegistrationImageDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import model.Household;
import model.HouseholdMember;
import model.Log;
import model.Registration;
import model.RegistrationImage;
import model.SendMail;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Huytayto
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB: kích thước file tối thiểu cần lưu vào ổ đĩa (nếu nhỏ hơn lưu RAM)
        maxFileSize = 1024 * 1024 * 10, // 10MB: kích thước file tối đa
        maxRequestSize = 1024 * 1024 * 50 // 50MB: tổng kích thước request tối đa
)
public class HouseholdServlet extends HttpServlet {

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
            out.println("<title>Servlet householdServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet householdServlet at " + request.getContextPath() + "</h1>");
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
    protected String getAddressDetailMore(String addressDetail, int wardID, int districtID, int provinceID) {
        String provinceName = LocationService.getProvinceName(provinceID);
        String districtName = LocationService.getDistrictName(districtID);
        String wardName = LocationService.getWardName(districtID, wardID);
        return addressDetail + ", " + wardName + ", " + districtName + ", " + provinceName;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("signIn"); // Chuyển hướng về trang đăng nhập
            return;
        }
        User user = (User) session.getAttribute("user");
        ArrayList<Household> households1 = new ArrayList<Household>();

        try (PrintWriter out = response.getWriter()) {
            if (action == null) {
                if (user.getRole().equals("Police")) {
                    RequestDispatcher rs = request.getRequestDispatcher("view/policeWelcome.jsp");
                    rs.forward(request, response);
                } else if (user.getRole().equals("AreaLeader")) {
                    RequestDispatcher rs = request.getRequestDispatcher("view/areaLeaderWelcome.jsp");
                    rs.forward(request, response);
                } else {
                    RequestDispatcher rs = request.getRequestDispatcher("view/household.jsp");
                    rs.forward(request, response);
                }
            } else if (action.equals("householdCreate")) {
                HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByUserID(user.getUserID());
                if (householdMember != null) {
                    if (householdMember.getRelationship().equals("Chủ hộ")) {
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Cần chuyển chủ hộ khẩu cho người khác hoặc xoá hộ khẩu để có thể đăng kí thường trú!');");
                        out.println("window.location.href='Household';"); // Chuyển hướng sau khi hiển thị thông báo
                        out.println("</script>");
                        return;
                    }
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("householdMember", householdMember);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }
                String addressDetailMoreSelf = getAddressDetailMore(user.getAddressDetail(), user.getWardID(), user.getDistrictID(), user.getProvinceID());
                request.setAttribute("addressDetailMoreSelf", addressDetailMoreSelf);
                RequestDispatcher rs = request.getRequestDispatcher("view/householdCreate.jsp");
                rs.forward(request, response);
            } else if (action.equals("permanent")) {
                User sender = user;
                String childID = request.getParameter("childID");
                if (childID != null) {
                    sender = UserDAO.getUserByUserID(Integer.parseInt(childID));
                    request.setAttribute("childID", childID);
                }
                HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByUserID(sender.getUserID());
                if (householdMember != null) {
                    if (householdMember.getRelationship().equals("Chủ hộ")) {
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Cần chuyển chủ hộ khẩu cho người khác hoặc xoá hộ khẩu để có thể đăng kí thường trú!');");
                        out.println("window.location.href='Household';"); // Chuyển hướng sau khi hiển thị thông báo
                        out.println("</script>");
                        return;
                    }
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("householdMember", householdMember);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }
                String addressDetailMoreSelf = getAddressDetailMore(sender.getAddressDetail(), sender.getWardID(), sender.getDistrictID(), sender.getProvinceID());
                request.setAttribute("addressDetailMoreSelf", addressDetailMoreSelf);

                request.setAttribute("registrationType", "Permanent");
                request.setAttribute("sender", sender);
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationCreate.jsp");
                rs.forward(request, response);
            } else if (action.equals("temporary")) {
                User sender = user;
                String childID = request.getParameter("childID");
                if (childID != null) {
                    sender = UserDAO.getUserByUserID(Integer.parseInt(childID));
                    request.setAttribute("childID", childID);
                }
                Log temporaryLog = LogDAO.getLatestLogByUserID(sender.getUserID(), "Temporary");
                if (temporaryLog != null) {
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(temporaryLog.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("temporaryLog", temporaryLog);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }
                String addressDetailMoreSelf = getAddressDetailMore(sender.getAddressDetail(), sender.getWardID(), sender.getDistrictID(), sender.getProvinceID());
                request.setAttribute("addressDetailMoreSelf", addressDetailMoreSelf);
                request.setAttribute("sender", sender);
                request.setAttribute("registrationType", "Temporary");
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationCreate.jsp");
                rs.forward(request, response);
            } else if (action.equals("temporaryStay")) {
                User sender = user;
                String childID = request.getParameter("childID");
                if (childID != null) {
                    sender = UserDAO.getUserByUserID(Integer.parseInt(childID));
                    request.setAttribute("childID", childID);
                }
                String addressDetailMoreSelf = getAddressDetailMore(sender.getAddressDetail(), sender.getWardID(), sender.getDistrictID(), sender.getProvinceID());
                request.setAttribute("addressDetailMoreSelf", addressDetailMoreSelf);
                request.setAttribute("sender", sender);
                HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByUserID(sender.getUserID());
                if (householdMember != null) {
                    Household household = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    User head = UserDAO.getUserByUserID(household.getHeadOfHouseholdID());
                    request.setAttribute("householdMember", householdMember);
                    request.setAttribute("household", household);
                    request.setAttribute("head", head);
                    request.setAttribute("registrationType", "TemporaryStay");
                    String addressDetailMoreOfHousehold = getAddressDetailMore(household.getAddressDetail(), household.getWardID(), household.getDistrictID(), household.getProvinceID());
                    request.setAttribute("addressDetailMoreOfHousehold", addressDetailMoreOfHousehold);
                    RequestDispatcher rs = request.getRequestDispatcher("view/registrationCreate.jsp");
                    rs.forward(request, response);
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Thường trú trong 1 hộ khẩu bất kì mới có thể tạm trú!');");
                    if (childID != null) {
                        out.println("window.location.href='Household?action=registrationChild&childID=" + childID + "';");
                    } else {
                        out.println("window.location.href='Household';");
                    }
                    out.println("</script>");
                    return;
                }
            } else if (action.equals("getHouseholdByCCCD")) {
                String headCCCD = request.getParameter("headCCCD");
                JSONObject json = new JSONObject();

                if (headCCCD != null && !headCCCD.isEmpty()) {
                    User headUser = UserDAO.getUserByCCCD(headCCCD);
                    if (headUser != null) {
                        Household household = HouseholdDAO.getHouseholdByHeadOfHouseholdID(headUser.getUserID(), true);
                        if (household != null) {
                            json.put("isHouseholdHead", true);

                            json.put("headFullName", headUser.getFullName());
                            json.put("householdCode", household.getHouseholdCode());
                            json.put("householdID", household.getHouseholdID());
                            json.put("headUser", headUser);
                            json.put("household", household);
                            json.put("addressDetail", getAddressDetailMore(household.getAddressDetail(), household.getWardID(), household.getDistrictID(), household.getProvinceID()));
                            ArrayList<User> areaLeaders = UserDAO.getAreaLeaderByWardID(household.getWardID());
                            JSONArray areaLeadersArray = new JSONArray();
                            for (User leader : areaLeaders) {
                                JSONObject leaderJson = new JSONObject();
                                leaderJson.put("userID", leader.getUserID());
                                leaderJson.put("fullName", leader.getFullName());
                                leaderJson.put("addressDetail", leader.getAddressDetail());
                                areaLeadersArray.put(leaderJson);
                            }

                            json.put("areaLeaders", areaLeadersArray);
                        } else {
                            json.put("isHouseholdHead", false);
                        }
                    } else {
                        json.put("isHouseholdHead", false);
                    }
                } else {
                    json.put("isHouseholdHead", false);
                }

                // *** GỬI JSON VỀ CLIENT ***
                out.print(json.toString());
                out.flush();
            } else if (action.equals("getAreaLeaderByWardID")) {
                JSONObject json = new JSONObject();
                String wardIDParam = request.getParameter("wardID");
                int wardID = 0;

                if (wardIDParam != null && !wardIDParam.isEmpty()) {
                    try {
                        wardID = Integer.parseInt(wardIDParam);
                        ArrayList<User> areaLeaders = UserDAO.getAreaLeaderByWardID(wardID);

                        if (areaLeaders.isEmpty() || areaLeaders == null) {
                            json.put("wardSuccess", false);
                        } else {
                            JSONArray areaLeadersArray = new JSONArray();
                            for (User leader : areaLeaders) {
                                JSONObject leaderJson = new JSONObject();
                                leaderJson.put("userID", leader.getUserID());
                                leaderJson.put("fullName", leader.getFullName());
                                leaderJson.put("addressDetail", leader.getAddressDetail());
                                areaLeadersArray.put(leaderJson);
                            }

                            json.put("wardSuccess", true);
                            json.put("areaLeaders", areaLeadersArray);
                        }
                    } catch (NumberFormatException e) {
                        json.put("wardSuccess", false);
                    }
                } else {
                    json.put("wardSuccess", false);
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                out.print(json.toString());
                out.flush();
            } else if (action.equals("registrationChild")) {
                request.setAttribute("childID", request.getParameter("childID"));
                RequestDispatcher rs = request.getRequestDispatcher("view/householdChild.jsp");
                rs.forward(request, response);
            } else if (action.equals("permanentChild")) {

            } else if (action.equals("registrationView")) {
                String registrationID = request.getParameter("registrationID");
                Registration registration = RegistrationDAO.getRegistrationByRegistrationID(registrationID);
                request.setAttribute("registration", registration);
                User sender = UserDAO.getUserByUserID(registration.getUserID());
                request.setAttribute("sender", sender);
                if (sender.getCCCD().length() > 12) {
                    request.setAttribute("childID", sender.getUserID());
                    User guardian = UserDAO.getUserByCCCD(sender.getCCCD().substring(0, 12));
                    request.setAttribute("guardian", guardian);
                }
                String addressDetailMore = getAddressDetailMore(sender.getAddressDetail(), sender.getWardID(), sender.getDistrictID(), sender.getProvinceID());
                request.setAttribute("addressDetailMore", addressDetailMore);
                if (!registration.getRegistrationType().equals("Temporary")) {
                    HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByUserID(sender.getUserID());
                    if (householdMember != null) {
                        Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                        User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                        String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                        request.setAttribute("householdMember", householdMember);
                        request.setAttribute("oldHousehold", oldHousehold);
                        request.setAttribute("oldHead", oldHead);
                        request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                    }
                } else {
                    Log temporaryLog = LogDAO.getLatestLogByUserID(sender.getUserID(), "Temporary");
                    if (temporaryLog != null) {
                        Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(temporaryLog.getHouseholdID());
                        User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                        String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                        request.setAttribute("temporaryLog", temporaryLog);
                        request.setAttribute("oldHousehold", oldHousehold);
                        request.setAttribute("oldHead", oldHead);
                        request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                    }
                }
                if (registration.getHouseholdID() == 0) {
                    Household household = HouseholdDAO.getHouseholdByRegistrationID(registration.getRegistrationID());
                    String addressDetailMoreOfHousehold = getAddressDetailMore(household.getAddressDetail(), household.getWardID(), household.getDistrictID(), household.getProvinceID());
                    request.setAttribute("addressDetailMoreOfHousehold", addressDetailMoreOfHousehold);
                } else {
                    Household household = HouseholdDAO.getHouseholdByHouseholdID(registration.getHouseholdID());
                    User head = UserDAO.getUserByUserID(household.getHeadOfHouseholdID());
                    request.setAttribute("household", household);
                    request.setAttribute("head", head);
                    String addressDetailMoreOfHousehold = getAddressDetailMore(household.getAddressDetail(), household.getWardID(), household.getDistrictID(), household.getProvinceID());
                    request.setAttribute("addressDetailMoreOfHousehold", addressDetailMoreOfHousehold);
                }
                ArrayList<RegistrationImage> registrationImages = RegistrationImageDAO.getRegistrationImagesByRegistrationID(registration.getRegistrationID());
                request.setAttribute("registrationImages", registrationImages);
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationResult.jsp");
                rs.forward(request, response);
            } else if (action.equals("confirm")) {
                int registrationID = Integer.parseInt(request.getParameter("registrationID"));
                Registration registration = RegistrationDAO.getRegistrationById(registrationID);
                if (user.getRole().contains("AreaLeader")) {
                    RegistrationDAO.updateStatusRegistrationByRegistrationID(registrationID, "PreApproved");
                    User sender = UserDAO.getUserByUserID(Integer.parseInt(request.getParameter("senderID")));
                    SendMail.send(sender.getEmail(), "Đơn " + registration.getRegistrationCode() + " đã được sơ duyệt!", "");
                    NotificationDAO.addNotification(sender.getUserID(), "Đơn " + registration.getRegistrationCode() + " đã được sơ duyệt!");
                    RequestDispatcher rs = request.getRequestDispatcher("view/areaLeaderWelcome.jsp");
                    rs.forward(request, response);
                } else if (user.getRole().contains("Police")) {
                    RegistrationDAO.updateStatusRegistrationByRegistrationID(registrationID, "Approved");
                    User sender = UserDAO.getUserByUserID(Integer.parseInt(request.getParameter("senderID")));
                    SendMail.send(sender.getEmail(), "Đơn " + registration.getRegistrationCode() + " đã được xét duyệt!", "");
                    NotificationDAO.addNotification(sender.getUserID(), "Đơn " + registration.getRegistrationCode() + " đã được xét duyệt!");
                    RequestDispatcher rs = request.getRequestDispatcher("view/policeWelcome.jsp");
                    rs.forward(request, response);
                } else if (user.getRole().contains("Admin")) {
                    RegistrationDAO.updateStatusRegistrationByRegistrationID(registrationID, "Approved");
                    User sender = UserDAO.getUserByUserID(Integer.parseInt(request.getParameter("senderID")));
                    SendMail.send(sender.getEmail(), "Đơn " + registration.getRegistrationCode() + " đã được xét duyệt!", "");
                    NotificationDAO.addNotification(sender.getUserID(), "Đơn " + registration.getRegistrationCode() + " đã được xét duyệt!");
                    RequestDispatcher rs = request.getRequestDispatcher("view/Admin.jsp");
                    rs.forward(request, response);
                }

            } else if (action.equals("reject")) {
                String reason = request.getParameter("reason");
                int registrationID = Integer.parseInt(request.getParameter("registrationID"));
                Registration registration = RegistrationDAO.getRegistrationById(registrationID);
                User sender = UserDAO.getUserByUserID(Integer.parseInt(request.getParameter("senderID")));
                RegistrationDAO.updateStatusRegistrationByRegistrationID(registrationID, "Rejected");
                SendMail.send(sender.getEmail(), "Đơn của bạn đã bị từ chối", "Mã đơn: " + registration.getRegistrationCode() + " với lí do: " +reason);
                NotificationDAO.addNotification(sender.getUserID(), "Đơn " + registration.getRegistrationCode() + " đã bị từ chối với lí do: " + reason);
                RequestDispatcher rs = request.getRequestDispatcher("view/areaLeaderWelcome.jsp");
                rs.forward(request, response);

            } else if (action.equals("areaLeaderManager")) {
                ArrayList<Registration> registrations = RegistrationDAO.getRegistrationForAreaLeader(user.getUserID());
                request.setAttribute("registrations", registrations);
                RequestDispatcher rs = request.getRequestDispatcher("view/areaLeaderScreen.jsp");
                rs.forward(request, response);
            } else if (action.equals("policeManager")) {
                ArrayList<Registration> registrations = RegistrationDAO.getRegistrationForPolice(user);
                request.setAttribute("registrations", registrations);
                RequestDispatcher rs = request.getRequestDispatcher("view/policeRegistrationManagement.jsp");
                rs.forward(request, response);
            } else if (action.equals("policeViewHousehold")) {
                ArrayList<Household> households = HouseholdDAO.getHouseholdsByWardIDIncludeHeadOfHousehold(user.getWardID());

                String wardName = LocationService.getWardName(user.getDistrictID(), user.getWardID());
                String districtName = LocationService.getDistrictName(user.getDistrictID());
                String provinceName = LocationService.getProvinceName(user.getProvinceID());
                request.setAttribute("wardName", wardName);
                request.setAttribute("districtName", districtName);
                request.setAttribute("provinceName", provinceName);
                request.setAttribute("households", households);

                RequestDispatcher rs = request.getRequestDispatcher("view/policeViewHousehold.jsp");
                rs.forward(request, response);
            } else if (action.equals("viewMember")) {
                int householdID = Integer.parseInt(request.getParameter("householdID"));
                Household household = HouseholdDAO.getHouseholdByHouseholdID(householdID);
                ArrayList<HouseholdMember> householdMembers = HouseholdMemberDAO.getHouseholdMemberByHouseholdIDIncludingUser(householdID);
                request.setAttribute("householdMembers", householdMembers);
                request.setAttribute("household", household);
                RequestDispatcher rs = request.getRequestDispatcher("view/policeViewMember.jsp");
                rs.forward(request, response);
            } else if (action.equals("policeCheckUser")) {
                int policeWardId = user.getWardID();
                // Lấy danh sách pendingUsers và lọc chỉ những CCCD có đúng 12 số
                List<User> pendingUsers = UserDAO.getPendingUsers(policeWardId);
                List<User> filteredPendingUsers = pendingUsers.stream()
                        .filter(u -> u.getCCCD() != null)
                        .collect(Collectors.toList());
                request.setAttribute("pendingUsers", filteredPendingUsers);
                request.getRequestDispatcher("view/policeSignIn.jsp").forward(request, response);
            }
            
            
            
            
            else if (action.equals("registrationNotification")) {
                ArrayList<Log> logs = new ArrayList<Log>();
                logs = LogDAO.getLogsNotificate(user.getWardID());
                request.setAttribute("logs", logs);
                RequestDispatcher rs = request.getRequestDispatcher("view/logList.jsp");
                rs.forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            else if (action.equals("listHouseHold")) {
                households1 = HouseholdDAO.getHouseholds();
                request.setAttribute("households", households1);
                RequestDispatcher rs = request.getRequestDispatcher("view/householdList.jsp");
                rs.forward(request, response);
            } else if (action.equals("searchhousehold")) {
                String provinceIdString = request.getParameter("provinceId");
                String districtIdString = request.getParameter("districtId");
                String wardIdString = request.getParameter("wardId");
                if (provinceIdString.isEmpty()) {
                    households1 = HouseholdDAO.getHouseholds();
                    request.setAttribute("households", households1);
                    RequestDispatcher rs = request.getRequestDispatcher("view/householdList.jsp");
                    rs.forward(request, response);
                } else if (!provinceIdString.isEmpty() && districtIdString.isEmpty()) {
                    int provinceId = Integer.parseInt(provinceIdString);
                    households1 = HouseholdDAO.getHouseholdByProvinceID(provinceId);
                    request.setAttribute("households", households1);
                    RequestDispatcher rs = request.getRequestDispatcher("view/householdList.jsp");
                    rs.forward(request, response);
                } else if (!provinceIdString.isEmpty() && !districtIdString.isEmpty() && wardIdString.isEmpty()) {
                    int provinceId = Integer.parseInt(provinceIdString);
                    int districtId = Integer.parseInt(districtIdString);
                    households1 = HouseholdDAO.getHouseholdByProvinceIDandDistrictID(provinceId, districtId);
                    request.setAttribute("households", households1);
                    RequestDispatcher rs = request.getRequestDispatcher("view/householdList.jsp");
                    rs.forward(request, response);
                } else {
                    int provinceId = Integer.parseInt(provinceIdString);
                    int districtId = Integer.parseInt(districtIdString);
                    int wardId = Integer.parseInt(wardIdString);
                    households1 = HouseholdDAO.getHouseholdByLocation(provinceId, districtId, wardId);
                    request.setAttribute("households", households1);
                    RequestDispatcher rs = request.getRequestDispatcher("view/householdList.jsp");
                    rs.forward(request, response);
                } 

            }  else if (action.equals("citizenViewRegistration")) {
                ArrayList<Registration> registrations = RegistrationDAO.getRegistrationForCitizen(user.getUserID());
                request.setAttribute("registrations", registrations);
                RequestDispatcher rs = request.getRequestDispatcher("view/citizenViewRegistration.jsp");
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (PrintWriter out = response.getWriter()) {
            if (action == null) {

            } else if (action.equals("householdCreate")) {

                String householdMemberIDStr = request.getParameter("householdMemberID");
                if (householdMemberIDStr != null) {
                    int householdMemberID = Integer.parseInt(householdMemberIDStr);
                    HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByMemberID(householdMemberID);
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("householdMember", householdMember);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }

                // đặt về 0 vì đăng kí sổ hộ khẩu
                int householdID = 0;
                String relationship = "Chủ hộ";

                int approveBy = Integer.parseInt(request.getParameter("areaLeaderID"));
                String comments = request.getParameter("comments");
                String startDate = request.getParameter("startDate");

                // lấy địa chỉ cụ thể của sổ hộ khẩu
                String addressDetailOfHousehold = request.getParameter("addressDetail");
                int wardIDOfhousehold = Integer.parseInt(request.getParameter("wardID"));
                int districtIDOfhousehold = Integer.parseInt(request.getParameter("districtID"));
                int provinceIDOfhousehold = Integer.parseInt(request.getParameter("provinceID"));
                String addressDetailMoreOfHousehold = getAddressDetailMore(addressDetailOfHousehold, wardIDOfhousehold, districtIDOfhousehold, provinceIDOfhousehold);
                String addressDetailMore = getAddressDetailMore(user.getAddressDetail(), user.getWardID(), user.getDistrictID(), user.getProvinceID());
                RegistrationDAO.addRegistration(user.getUserID(), "Permanent", householdID, startDate, null, approveBy, comments, relationship);
                Registration registration = RegistrationDAO.getLatestRegistrationByUserID(user.getUserID());
                HouseholdDAO.addHousehold(user.getUserID(), provinceIDOfhousehold, districtIDOfhousehold, wardIDOfhousehold, addressDetailOfHousehold, startDate);
                SendMail.send(user.getEmail(), "Gửi đơn đăng kí hộ khẩu thành công, Mã đơn đăng kí là :" + registration.getRegistrationCode(), "");
                NotificationDAO.addNotification(user.getUserID(), "Gửi đơn đăng kí hộ khẩu thành công, Mã đơn đăng kí là :" + registration.getRegistrationCode());
                String[] fileNames = {"personalDocuments", "residenceDocuments", "otherDocs"};
                StringBuilder urls = new StringBuilder();
                for (String fileName : fileNames) {
                    Collection<Part> fileParts = request.getParts(); // Lấy tất cả Part (ảnh)

                    for (Part filePart : fileParts) {
                        if (filePart.getName().equals(fileName) && filePart.getSize() > 0) {
                            try (InputStream fileContent = filePart.getInputStream()) {
                                byte[] imageBytes = fileContent.readAllBytes();
                                String imageUrl = ImageUploadHelper.uploadToImgur(imageBytes);
                                RegistrationImageDAO.addRegistrationImage(registration.getRegistrationID(), imageUrl, fileName);
                            } catch (Exception e) {
                                e.printStackTrace();
                                response.getWriter().write("Lỗi upload ảnh: " + e.getMessage());
                                return;
                            }
                        }
                    }
                }
                ArrayList<RegistrationImage> registrationImages = RegistrationImageDAO.getRegistrationImagesByRegistrationID(registration.getRegistrationID());
                request.setAttribute("sender", user);
                request.setAttribute("addressDetailMore", addressDetailMore);
                request.setAttribute("registration", registration);
                request.setAttribute("registrationImages", registrationImages);
                request.setAttribute("addressDetailMoreOfHousehold", addressDetailMoreOfHousehold);
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationResult.jsp");
                rs.forward(request, response);
            } else if (action.equals("registration")) {
                String householdMemberIDStr = request.getParameter("householdMemberID");
                if (householdMemberIDStr != null && !householdMemberIDStr.trim().isEmpty()) {
                    int householdMemberID = Integer.parseInt(householdMemberIDStr);
                    HouseholdMember householdMember = HouseholdMemberDAO.getHouseholdMemberByMemberID(householdMemberID);
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(householdMember.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("householdMember", householdMember);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }
                String temporaryLogIDStr = request.getParameter("temporaryLogID");
                if (temporaryLogIDStr != null && !temporaryLogIDStr.trim().isEmpty()) {
                    int temporaryLogID = Integer.parseInt(temporaryLogIDStr);

                    Log temporaryLog = LogDAO.getLogByLogID(temporaryLogID);
                    Household oldHousehold = HouseholdDAO.getHouseholdByHouseholdID(temporaryLog.getHouseholdID());
                    User oldHead = UserDAO.getUserByUserID(oldHousehold.getHeadOfHouseholdID());
                    String addressDetailMoreOfOldHousehold = getAddressDetailMore(oldHousehold.getAddressDetail(), oldHousehold.getWardID(), oldHousehold.getDistrictID(), oldHousehold.getProvinceID());
                    request.setAttribute("temporaryLog", temporaryLog);
                    request.setAttribute("oldHousehold", oldHousehold);
                    request.setAttribute("oldHead", oldHead);
                    request.setAttribute("addressDetailMoreOfOldHousehold", addressDetailMoreOfOldHousehold);
                }
                User sender = user;
                String childID = request.getParameter("childID");
                if (childID != null && !childID.trim().isEmpty()) {
                    sender = UserDAO.getUserByUserID(Integer.parseInt(childID));
                    request.setAttribute("childID", childID);
                    User guardian = UserDAO.getUserByCCCD(sender.getCCCD().substring(0, 12));
                    request.setAttribute("guardian", guardian);
                }
                int householdID = Integer.parseInt(request.getParameter("householdID"));
                Household household = HouseholdDAO.getHouseholdByHouseholdID(householdID);
                User head = UserDAO.getUserByUserID(household.getHeadOfHouseholdID());
                int approveBy = Integer.parseInt(request.getParameter("areaLeaderID"));
                String registrationType = request.getParameter("registrationType");
                String startDate = request.getParameter("startDate");
                String endDate = null;
                if (!registrationType.equals("Permanent")) {
                    endDate = request.getParameter("endDate");
                }
                String comments = request.getParameter("comments");
                String relationship = request.getParameter("relationship");
                String addressDetailMoreOfHousehold = getAddressDetailMore(household.getAddressDetail(), household.getWardID(), household.getDistrictID(), household.getProvinceID());
                String addressDetailMore = getAddressDetailMore(sender.getAddressDetail(), sender.getWardID(), sender.getDistrictID(), sender.getProvinceID());
                RegistrationDAO.addRegistration(sender.getUserID(), registrationType, householdID, startDate, endDate, approveBy, comments, relationship);
                Registration registration = RegistrationDAO.getLatestRegistrationByUserID(sender.getUserID());
                String[] fileNames = {"personalDocuments", "residenceDocuments", "otherDocs"};
                StringBuilder urls = new StringBuilder();
                for (String fileName : fileNames) {
                    Collection<Part> fileParts = request.getParts(); // Lấy tất cả Part (ảnh)

                    for (Part filePart : fileParts) {
                        if (filePart.getName().equals(fileName) && filePart.getSize() > 0) {
                            try (InputStream fileContent = filePart.getInputStream()) {
                                byte[] imageBytes = fileContent.readAllBytes();
                                String imageUrl = ImageUploadHelper.uploadToImgur(imageBytes);
                                RegistrationImageDAO.addRegistrationImage(registration.getRegistrationID(), imageUrl, fileName);
                            } catch (Exception e) {
                                e.printStackTrace();
                                response.getWriter().write("Lỗi upload ảnh: " + e.getMessage());
                                return;
                            }
                        }
                    }
                }
                ArrayList<RegistrationImage> registrationImages = RegistrationImageDAO.getRegistrationImagesByRegistrationID(registration.getRegistrationID());
                request.setAttribute("sender", sender);
                request.setAttribute("addressDetailMore", addressDetailMore);
                request.setAttribute("registration", registration);
                request.setAttribute("registrationImages", registrationImages);
                request.setAttribute("household", household);
                request.setAttribute("head", head);
                request.setAttribute("addressDetailMoreOfHousehold", addressDetailMoreOfHousehold);
                SendMail.send(user.getEmail(), "Tạo đơn thành công", "Đơn được tạo thành công. Mã đơn : " + registration.getRegistrationCode() + "\n" + registration.getRegistrationType());
                NotificationDAO.addNotification(user.getUserID(), "Gửi đơn thành công, Mã đơn đăng kí là :" + registration.getRegistrationCode());
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationResult.jsp");
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
