package controller.registration;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Random;

import dto.RegisterDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.EmailService;

/**
 * @author Dell
 */
@WebServlet(name = "ResendOTPServlet", urlPatterns = {"/resend_otp"})
public class ResendOTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("otp") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        LocalDateTime otpCreateAt = (LocalDateTime) session.getAttribute("otpCreateAt");
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(otpCreateAt, now);
        if(duration.toSeconds() <= 60) {
            request.setAttribute("error", "Resend OTP available every one minute!");
        }else{
            RegisterDTO rDTO = (RegisterDTO) session.getAttribute("guestInfo");
            Random random = new Random();
            int otp = 1000 + random.nextInt(9000);
            session.setAttribute("otp", otp + "");
            session.setAttribute("otpCreateAt", LocalDateTime.now());
            EmailService emailService = new EmailService();
            emailService.sendOTPForRegisterSubject(rDTO.getEmail(), otp + "", true);
        }
        request.getRequestDispatcher("activate_register_subject.jsp").forward(request, response);
    }
}
