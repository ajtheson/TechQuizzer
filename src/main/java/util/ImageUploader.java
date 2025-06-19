package util;

import jakarta.servlet.http.Part;

import java.io.*;

public class ImageUploader {
    public static void saveImage(String targetDirectory, String fileName, Part uploadedFile) throws IOException {
        File uploadsDir = new File(targetDirectory);
        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs();
        }
        File file = new File(uploadsDir, fileName);
        try (InputStream inputData = uploadedFile.getInputStream();
             OutputStream out = new FileOutputStream(file)) {
            byte[] buffer = new byte[5120];
            int length;
            while ((length = inputData.read(buffer)) != -1) {
                out.write(buffer, 0, length);
            }
        }
    }

    public static void deleteImage(String targetDirectory, String fileName) {
        File file = new File(targetDirectory, fileName);
        if (file.exists()) {
            file.delete();
        }
    }
}
