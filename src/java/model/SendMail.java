/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

    
    
    public static void send(String to, String subject, String messageContent) throws UnsupportedEncodingException {
        String user = "baolong2000k4@gmail.com";
    String password = "yyntftfoglwowmkt";
        // Cấu hình các thuộc tính SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Server của Gmail
        props.put("mail.smtp.port", "587"); // Cổng đúng cho TLS
        props.put("mail.smtp.auth", "true"); // Bật xác thực
        props.put("mail.smtp.starttls.enable", "true"); // Kích hoạt STARTTLS

        // Tạo Session với Authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            // Tạo đối tượng MimeMessage
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user)); // Đặt địa chỉ người gửi
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // Đặt người nhận

            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));// Đặt tiêu đề email

            // Đặt nội dung email với định dạng HTML
            message.setContent(messageContent, "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);

            System.out.println("Email đã được gửi thành công!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
