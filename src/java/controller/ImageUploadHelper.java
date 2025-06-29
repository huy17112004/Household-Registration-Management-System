/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author Huytayto
 */
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;
import org.json.JSONObject;

public class ImageUploadHelper {

    private static final String IMGUR_CLIENT_ID = "ec874c1e5c4351a";
    private static final String IMGUR_UPLOAD_URL = "https://api.imgur.com/3/image";
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=YourDB";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "yourpassword";

    // Phương thức upload ảnh lên Imgur và trả về URL ảnh
    public static String uploadToImgur(byte[] imageBytes) throws Exception {
        String imageBase64 = Base64.getEncoder().encodeToString(imageBytes); // Chuyển sang Base64

        JSONObject json = new JSONObject();
        json.put("image", imageBase64);
        json.put("type", "base64");

        URL url = new URL(IMGUR_UPLOAD_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Client-ID " + IMGUR_CLIENT_ID);
        conn.setRequestProperty("Content-Type", "application/json");

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.toString().getBytes());
            os.flush();
        }

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        // Đọc response từ Imgur
        InputStream is = conn.getInputStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = is.read(buffer)) != -1) {
            baos.write(buffer, 0, bytesRead);
        }

        String response = new String(baos.toByteArray());
        JSONObject jsonResponse = new JSONObject(response);
        conn.disconnect();

        String imageUrl = jsonResponse.getJSONObject("data").getString("link");

        return imageUrl;
    }

    // Phương thức lưu link ảnh vào database
    public static void saveImageLinkToDB(int registrationID, String imageUrl, String imageType) {
        String sql = "INSERT INTO RegistrationImages (RegistrationID, ImageURL, ImageType) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, registrationID);
            stmt.setString(2, imageUrl);
            stmt.setString(3, imageType);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
