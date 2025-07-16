package controller.account;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordEncoder;
import util.TokenGenerator;

@WebServlet(name = "VerifyServlet", urlPatterns = {"/account/verify"})
public class VerifyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO uDAO = new UserDAO();
        String mode = request.getParameter("mode");
        String token = request.getParameter("token");
        User u = uDAO.getVerifyInformation(PasswordEncoder.encode(token));
        if (u == null) {
            //Account has been verified
            //Click link after verify
            session.setAttribute("verifyNotification", "Your link has been used or expired");
            response.sendRedirect("login");
            return;
        }
        LocalDateTime tokenCreateAt = u.getTokenCreateAt();
        LocalDateTime now = LocalDateTime.now();
        //Check expired token
        long hoursSinceTokenCreate = Duration.between(tokenCreateAt, now).toHours();
        if (hoursSinceTokenCreate < 24) {
            //Success verify account
            uDAO.activateAccount(u.getEmail());
            if(mode.equals("activate")){
                session.invalidate();
                HttpSession newSession = request.getSession();
                newSession.setAttribute("verifyNotification", "Your account has been activated");
                response.sendRedirect("login");
                return;
            }
            if(mode.equals("reset")){
                session.invalidate();
                HttpSession newSession = request.getSession();
                newSession.setAttribute("email", u.getEmail());
                newSession.setAttribute("resetToken", TokenGenerator.generateToken(""));
                //Reset password available in 5 minutes
                newSession.setMaxInactiveInterval(300);
                response.sendRedirect("reset_password");
                return;
            }
        }
        //Handle expired token -> forward to activate page with email
        session.setAttribute("expiredToken", true);
        if(mode.equals("activate")){
            session.setAttribute("unverifiedEmail", u.getEmail());
        }
        if(mode.equals("reset")){
            session.setAttribute("resetPasswordEmail", u.getEmail());
        }
        response.sendRedirect("activate");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
