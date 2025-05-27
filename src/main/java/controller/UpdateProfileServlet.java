package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "UpdateProfileServlet", value = "/update-profile")
@MultipartConfig

public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
//        System.out.println(name);
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        Boolean genderBoolean = null;
        switch (gender) {
            case "male": genderBoolean = true; break;
            case "female": genderBoolean = false; break;
            default: break;
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        user.setName(name);
        user.setAddress(address);
        user.setGender(genderBoolean);

        try {
            boolean isUpdated = new UserDAO().updateUserInfo(user);
            if(!isUpdated) {
                throw new ServletException("Failed to update user");
            }
            session.setAttribute("user", user);

            out.write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}