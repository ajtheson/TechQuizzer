package util;

import jakarta.servlet.http.Part;

import java.io.*;

public class ImageUploader {
    public static String saveImage(String targetDirectory, String fileName, Part filePart) throws IOException {
        File uploadsDir = new File(targetDirectory);
        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs();
        }
        File file = new File(uploadsDir, fileName);
        try (InputStream input = filePart.getInputStream();
             OutputStream out = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = input.read(buffer)) != -1) {
                out.write(buffer, 0, length);
            }
        }
        return file.getAbsolutePath();
    }

}
