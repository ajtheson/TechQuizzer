package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;

@WebServlet(name = "ChangeAvatarServlet", value = "/upload-avatar")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10) // Adjust sizes as needed
public class ChangeAvatarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            Part filePart = request.getPart("image"); //part is a file or a field of multipart
            HttpSession session = request.getSession(false);

            String originalFileName = filePart.getSubmittedFileName();
            String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
            String fileName = ((User) session.getAttribute("user")).getEmail() + "_" + Instant.now().toEpochMilli() + extension;
//            System.out.println("file name: " + fileName);

            String uploadDir = getServletContext().getRealPath("assets/images/avatar");
            //check directory
//            System.out.println("Upload path: " + uploadDir);

            String absolutePath = util.ImageUploader.saveImage(uploadDir, fileName, filePart);
//            System.out.println("absolute path: " + absolutePath);

            User user = (User) session.getAttribute("user");
            user.setAvatar(fileName);

            boolean isUpdated = new UserDAO().updateUserInfo(user);
            if (!isUpdated) {
                throw new ServletException("Failed to change avatar");
            }

            session.setAttribute("user", user);

            out.write("{\"success\": true, \"newAvatar\": \"" + fileName + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"success\": false, \"message\": \"Upload failed\"}");
        }

        //notification

    }
}