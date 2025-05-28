package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;
import util.ImageUploader;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.Instant;

@WebServlet(name = "UpdateProfileServlet", value = "/update-profile")
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);
        JSONObject json = new JSONObject();
        String errorMsg = "";

        try {
            if (session == null || session.getAttribute("user") == null) {
                errorMsg = "User not logged in";
                throw new Exception();
            }

            Part fileUpload = request.getPart("image");
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String email = request.getParameter("email");

            Boolean genderBoolean = null;
            switch (gender) {
                case "male":
                    genderBoolean = true;
                    break;
                case "female":
                    genderBoolean = false;
                    break;
                default:
                    break;
            }

            String uploadDirectory = getServletContext().getRealPath("assets/images/avatar");
            String originalFileName = fileUpload.getSubmittedFileName();
            String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
            String fileName = email + "_" + Instant.now().toEpochMilli() + extension;

            User user = (User) session.getAttribute("user");
            user.setName(name);
            user.setAddress(address);
            user.setGender(genderBoolean);
            user.setAvatar(fileName);

            boolean isUpdated = new UserDAO().updateUserInfo(user);
            if (!isUpdated) {
                errorMsg = "Failed to update user in database";
            }

            ImageUploader.saveImage(uploadDirectory, fileName, fileUpload);

            json.put("status", true);
            json.put("message", "Update user successfully");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", false);
            json.put("message", errorMsg);
        }
        finally {
            response.getWriter().write(json.toString());
        }
    }
}