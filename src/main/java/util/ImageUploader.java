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

    public static boolean uploadFileFromServlet(String targetDirectory, String fileName, Part uploadedFile){
        try{
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
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
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
