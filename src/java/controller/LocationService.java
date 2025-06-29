package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class LocationService {
    private static final String API_BASE_URL = "https://provinces.open-api.vn/api/";

    // Phương thức gửi yêu cầu GET đến API
    private static String getResponseFromAPI(String endpoint) {
    try {
        URL url = new URL(API_BASE_URL + endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Lỗi HTTP: " + conn.getResponseCode());
        }

        // Đọc dữ liệu từ API với đúng encoding UTF-8
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            response.append(output);
        }
        conn.disconnect();
        return response.toString();
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
}

    // Phương thức lấy tên tỉnh từ mã tỉnh
    public static String getProvinceName(int provinceCode) {
        String jsonResponse = getResponseFromAPI("p/" + provinceCode);
        if (jsonResponse == null) return null;
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getString("name");
    }

    // Phương thức lấy tên huyện từ mã huyện
    public static String getDistrictName(int districtCode) {
        String jsonResponse = getResponseFromAPI("d/" + districtCode);
        if (jsonResponse == null) return null;
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getString("name");
    }

    // Phương thức lấy tên xã từ mã huyện và mã xã
    public static String getWardName(int districtCode, int wardCode) {
        String jsonResponse = getResponseFromAPI("d/" + districtCode + "?depth=2");
        if (jsonResponse == null) return null;

        JSONObject districtData = new JSONObject(jsonResponse);
        JSONArray wards = districtData.getJSONArray("wards");

        // Duyệt danh sách xã để tìm xã theo mã wardCode
        for (int i = 0; i < wards.length(); i++) {
            JSONObject ward = wards.getJSONObject(i);
            if (ward.getInt("code") == wardCode) { // So sánh trực tiếp kiểu int
                return ward.getString("name"); // Trả về tên xã
            }
        }
        return null; // Nếu không tìm thấy xã
    }
    public static String getWardName(int wardCode) { // Sửa để chỉ cần wardCode
        String jsonResponse = getResponseFromAPI("w/" + wardCode);
        if (jsonResponse == null) return null;
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getString("name");
    }

    // Lấy danh sách tất cả tỉnh
    public static JSONArray getAllProvinces() {
        String jsonResponse = getResponseFromAPI("p/");
        if (jsonResponse == null) return null;
        return new JSONArray(jsonResponse);
    }

    // Lấy danh sách huyện theo mã tỉnh
    public static JSONArray getDistrictsByProvince(int provinceCode) {
        String jsonResponse = getResponseFromAPI("p/" + provinceCode + "?depth=2");
        if (jsonResponse == null) return null;
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getJSONArray("districts");
    }

    // Lấy danh sách xã theo mã huyện
    public static JSONArray getWardsByDistrict(int districtCode) {
        String jsonResponse = getResponseFromAPI("d/" + districtCode + "?depth=2");
        if (jsonResponse == null) return null;
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.getJSONArray("wards");
    }
}
