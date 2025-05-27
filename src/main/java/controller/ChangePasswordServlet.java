package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordEncoder;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        user.setEmail("john.doe1@example.com");
        user.setPassword(PasswordEncoder.encode("Password123@"));
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        request.getRequestDispatcher("change_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");
        String email = sessionUser.getEmail();

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String error = "";

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime lockedUntil = user.getPasswordChangeLockedUntil();
        if (lockedUntil != null && lockedUntil.isAfter(now)) {
            error = "You have entered the wrong password too many times. Please try again after " +
                    lockedUntil.format(DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy"));
        } else if(currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            error = "Some fields are missing!";
        } else if (!PasswordEncoder.encode(currentPassword).equals(user.getPassword())) {
            int wrongPasswordAttempts = user.getWrongPasswordAttempts() + 1;
            if (wrongPasswordAttempts >= 5) {
                LocalDateTime lockUntil = now.plusMinutes(5);
                userDAO.lockPasswordChange(email, lockUntil);
                error = "You have entered the wrong password too many times. Please try again after " +
                        lockUntil.format(DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy"));
            }else {
                userDAO.updateWrongPasswordAttempts(email, wrongPasswordAttempts);
                error = "The current password is incorrect! (" + wrongPasswordAttempts + "/5 attempts used). Your account will be locked for 5 minutes after 5 failed attempts.";
            }
        } else if (!newPassword.equals(confirmPassword)) {
            error = "The new password and confirm password do not match!";
        } else {
            if (userDAO.resetPassword(user.getEmail(), PasswordEncoder.encode(newPassword))) {
                userDAO.updateWrongPasswordAttempts(email, 0);
                userDAO.lockPasswordChange(email, null);
                request.setAttribute("success", "Your password has been changed successfully");
                request.getRequestDispatcher("change_password.jsp").forward(request, response);
                return;
            }
            else{
                error = "Password change failed! Please try again.";
            }
        }

        request.setAttribute("currentPassword", currentPassword);
        request.setAttribute("newPassword", newPassword);
        request.setAttribute("confirmPassword", confirmPassword);
        request.setAttribute("error", error);

        request.getRequestDispatcher("change_password.jsp").forward(request, response);
    }
}
