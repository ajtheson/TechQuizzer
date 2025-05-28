package service;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import util.PasswordEncoder;
import util.TokenGenerator;

import java.time.Duration;
import java.time.LocalDateTime;

public class TokenService {
    public boolean handleVerifyToken(HttpServletRequest request, String email, boolean isActivateToken) {
        UserDAO uDAO = new UserDAO();
        EmailService emailService = new EmailService();
        HttpSession session = request.getSession();
        User tokenInformation = uDAO.getTokenInformation(email);
        String token = tokenInformation.getToken();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime tokenSendAt = tokenInformation.getTokenSendAt();

        //Check if do not have token (when account is already have been )
        if(token == null) return false;

        //Check can resend link
        long minutesSinceEmailSent = Duration.between(tokenSendAt, now).toMinutes();

        if(minutesSinceEmailSent < 5){
            //Create send error notification
            session.setAttribute("sendError", true);
        }else{
            token = TokenGenerator.generateToken(uDAO.getMobile(email));
            uDAO.updateToken(email, PasswordEncoder.encode(token), now, now);
            if(isActivateToken){
                emailService.sendActivatingEmail(request, email, token, true);
            }else{
                emailService.sendResetPasswordEmail(request, email, token);
            }
        }
        if(isActivateToken){
            session.setAttribute("unverifiedEmail", email);
        }else {
            session.setAttribute("resetPasswordEmail", email);
        }
        return true;
    }
}
