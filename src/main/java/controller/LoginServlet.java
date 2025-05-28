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
            response.sendRedirect("User");
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
            session.setAttribute("error", "Wrong email or password");
            System.out.println("email");
        } else if (!user.getPassword().equals(PasswordEncoder.encode(password))) {
            session.setAttribute("error", "Wrong email or password");
            System.out.println("here");
            response.sendRedirect("login");
        } else {
            UserService userService = new UserService();
            UserDTO userDTO = userService.toUserLoginDTO(user);
            session.setAttribute("user", userDTO);
            response.sendRedirect("home");
        }

    }

    @Override
    public String getServletInfo() {
        return "Handles user login";
    }
}
