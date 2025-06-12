package controller;


import dao.UserDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
        } else {
            int role = user.getRoleId();
            String targetPage = "";

            switch (role) {
                case 1:

                    targetPage = "admin";
                    break;
                case 2:
                    targetPage = "expert";
                    break;
                case 3:
                    targetPage = "home";
                    break;
                default:
                    request.setAttribute("error", "Invalid role");
                    targetPage = "login";
                    break;
            }
            response.sendRedirect(targetPage);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
