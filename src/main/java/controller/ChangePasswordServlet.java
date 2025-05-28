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
import util.PasswordEncoder;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("change_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get parameter from change password form
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        //Get session user
        HttpSession session = request.getSession();
        UserDTO sessionUser = (UserDTO) session.getAttribute("user");

        //Get user information from database
        String email = sessionUser.getEmail();
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        String error = "";
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime lockedUntil = user.getPasswordChangeLockedUntil();

        //Check if the user is locked or not
        if (lockedUntil != null && lockedUntil.isAfter(now)) {
            error = "You have entered the wrong password too many times. Please try again after " +
                    lockedUntil.format(DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy"));
        }
        //Check unempty parameter from change password form
        else if(currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            error = "Some fields are missing!";
        }
        //Check if the current password is correct or not
        else if (!PasswordEncoder.encode(currentPassword).equals(user.getPassword())) {
            //If the user has entered the wrong password too many times, lock the account for 5 minutes
            int wrongPasswordAttempts = user.getWrongPasswordAttempts() + 1;
            //If the wrong password attempts is greater than 5, lock the account for 5 minutes inmediately
            if (wrongPasswordAttempts >= 5) {
                LocalDateTime lockUntil = now.plusMinutes(5);
                userDAO.lockPasswordChange(email, lockUntil);
                error = "You have entered the wrong password too many times. Please try again after " +
                        lockUntil.format(DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy"));
            }
            //If the wrong password attempts is less than 5, update the wrong password attempts and show the error message
            else {
                userDAO.updateWrongPasswordAttempts(email, wrongPasswordAttempts);
                error = "The current password is incorrect! (" + wrongPasswordAttempts + "/5 attempts used). Your account will be locked for 5 minutes after 5 failed attempts.";
            }
        }
        //Check if the new password and confirm password are the same or not
        else if (!newPassword.equals(confirmPassword)) {
            error = "The new password and confirm password do not match!";
        }
        else {
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

        //Return to change password page with error message if there is any
        request.setAttribute("currentPassword", currentPassword);
        request.setAttribute("newPassword", newPassword);
        request.setAttribute("confirmPassword", confirmPassword);
        request.setAttribute("error", error);

        request.getRequestDispatcher("change_password.jsp").forward(request, response);
    }
}
