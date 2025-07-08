package util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import jakarta.servlet.http.Part;

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

    public static boolean uploadFileFromServlet(String targetDirectory, String fileName, Part uploadedFile) {
        try {
            File uploadsDir = new File(targetDirectory);
            if (!uploadsDir.exists()) {
                uploadsDir.mkdirs();
            }
            File file = new File(uploadsDir, fileName);
            try (InputStream inputData = uploadedFile.getInputStream();
                    OutputStream out = new FileOutputStream(file)) {
                byte[] buffer = new byte[20 * 1024 * 1024];
                int length;
                while ((length = inputData.read(buffer)) != -1) {
                    out.write(buffer, 0, length);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public static void copyFile(String sourceDirPath, String targetDirPath, String fileName) throws IOException {
        Path sourceDir = Paths.get(sourceDirPath);
        Path targetDir = Paths.get(targetDirPath);

        // Tạo thư mục đích nếu chưa tồn tại
        if (!Files.exists(targetDir)) {
            Files.createDirectories(targetDir);
        }

        Path sourceFile = sourceDir.resolve(fileName);
        Path targetFile = targetDir.resolve(fileName);

        if (!Files.exists(sourceFile)) {
            throw new IOException("Source file does not exist: " + sourceFile.toString());
        }

        Files.copy(sourceFile, targetFile, StandardCopyOption.REPLACE_EXISTING);
        System.out.println("Copied file: " + sourceFile + " -> " + targetFile);
    }

    public static void deleteAllFileInDirectory(String targetDirectory) {
        File dir = new File(targetDirectory);
        if (dir.exists() && dir.isDirectory()) {
            File[] files = dir.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isFile()) {
                        file.delete();
                    }
                }
            }
        }
    }

}
