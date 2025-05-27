package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "GetUserDetailServlet", value = "/user-detail")
@MultipartConfig
public class GetUserDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session != null) {
            int id = ((User) session.getAttribute("user")).getId();
            User user = new UserDAO().getUserById(id);
            if (user != null) {
                out.write("{'name': " + user.getName() + ", 'gender':" + user.getGender() + ", 'address: '" + user.getAddress() + "}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}