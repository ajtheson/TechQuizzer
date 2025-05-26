package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordEncoder;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset_password"})
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("email") == null) {
            response.sendRedirect("forgot_password");
            return;
        }
        String email = (String) session.getAttribute("email");
        request.setAttribute("email", email);
        request.getRequestDispatcher("reset_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String resetToken = request.getParameter("resetToken");
        String resetTokenSession = (String) session.getAttribute("resetToken");
        //Verify token in session
        if(resetToken == null || !resetToken.equals(resetTokenSession)) {
            response.sendRedirect("login");
        }
        String email = request.getParameter("email");
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();
        String error = "";
        if(email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            error = "Some fields are missing!";
        }else{
            if(!password.equals(confirmPassword)) {
                error = "Passwords do not match!";
            }else{
                UserDAO uDAO = new UserDAO();
                if(uDAO.resetPassword(email, PasswordEncoder.encode(password))) {
                    session.removeAttribute("email");
                    session.removeAttribute("resetToken");
                    session.setAttribute("verifyNotification", "Your account password has been reset");
                    response.sendRedirect("login");
                    return;
                }
            }
        }
        request.setAttribute("error", error);
        request.getRequestDispatcher("reset_password.jsp").forward(request, response);
    }
}
