import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

public class ImgurScraper {
    public static void downloadImage(String imageUrl, String savePath) {
        try (InputStream in = new URL(imageUrl).openStream()) {
            Files.copy(in, Paths.get(savePath));
            System.out.println("Tải ảnh thành công: " + savePath);
        } catch (IOException e) {
            System.err.println("Lỗi tải ảnh: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        String imgurUrl = "https://i.imgur.com/d8UPeSL.jpeg"; // Link ảnh trên Imgur
        String savePath = "D:\\Downloads\\downloaded_imagsde.jpeg"; // Đường dẫn lưu file
        
        downloadImage(imgurUrl, savePath);
    }
}