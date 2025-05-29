package controller;

import java.io.IOException;

import dao.UserDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.RequestDispatcher;
import service.UserService;
import util.PasswordEncoder;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if(session.getAttribute("verifyNotification") != null) {
            String notification = (String) session.getAttribute("verifyNotification");
            session.removeAttribute("verifyNotification");
            request.setAttribute("verifyNotification", notification);
        }
        if (user == null) {
            RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
            rs.forward(request, response);
        } else {
            response.sendRedirect("user");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);
        HttpSession session = request.getSession();
        if (user == null) {
            session.setAttribute("email", email);
            request.setAttribute("error", "Wrong email or password");
            request.getRequestDispatcher("login").forward(request, response);
        } else if (!user.getPassword().equals(PasswordEncoder.encode(password))) {
            request.setAttribute("error", "Wrong email or password");
            request.getRequestDispatcher("login").forward(request, response);
        } else {
            UserService userService = new UserService();
            UserDTO userDTO = userService.toUserLoginDTO(user);
            session.setAttribute("user", userDTO);
            response.sendRedirect("user");
        }


    }

    @Override
    public String getServletInfo() {
        return "Handles user login";
    }
}
