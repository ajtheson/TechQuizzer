package controller;

import dao.UserDAO;
import dto.UserDTO;
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
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 1024 * 1024)
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);
        JSONObject json = new JSONObject();

        try {
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            Part fileUpload = request.getPart("image");
            String name = request.getParameter("name").trim();
            String gender = request.getParameter("gender");
            String address = request.getParameter("address").trim();
            if(name.isEmpty()) {
                throw new Exception("Name is empty");
            }
            if(address.isEmpty()) {
                throw new Exception("Address is empty");
            }

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

            UserDTO userDTO = (UserDTO) session.getAttribute("user");
            userDTO.setName(name);
            userDTO.setAddress(address);
            userDTO.setGender(genderBoolean);

            User user = new UserDAO().getUserByEmail(userDTO.getEmail());
            user.setName(name);
            user.setAddress(address);
            user.setGender(genderBoolean);

            if(fileUpload.getSize() > 0) {
                String uploadDirectory = getServletContext().getRealPath("assets/images/avatar");
                String originalFileName = fileUpload.getSubmittedFileName();
                String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
                String fileName = userDTO.getEmail() + "_" + Instant.now().toEpochMilli() + extension;

                user.setAvatar(fileName);

                boolean isUpdated = new UserDAO().updateUserInfo(user);
                if (!isUpdated) {
                    throw new Exception("Failed to update user in database");
                }
                userDTO.setAvatar(fileName);
                ImageUploader.saveImage(uploadDirectory, fileName, fileUpload);
            }else{
                boolean isUpdated = new UserDAO().updateUserInfo(user);
                if (!isUpdated) {
                    throw new Exception("Failed to update user in database");
                }
            }

            json.put("status", true);
            json.put("message", "Update user successfully");
        } catch (Exception e) {
            json.put("status", false);
            json.put("message", e.getMessage());
        }
        finally {
            response.getWriter().write(json.toString());
        }
    }
}