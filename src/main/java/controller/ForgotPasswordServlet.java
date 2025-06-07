package controller;

import java.io.IOException;
import java.time.LocalDateTime;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.EmailService;
import service.TokenService;
import util.PasswordEncoder;
import util.TokenGenerator;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot_password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDao = new UserDAO();
        String email = request.getParameter("email").trim();
        String error;
        if(email.isEmpty()){
            error = "Email is required";
        }else{
            //Check email in system and activate status
            User user = uDao.isEmailInSystem(email);
            if(user == null){
                error = "Email does not exist";
            }else{
                if (uDao.checkTempUser(email)) {
                    error = "Account use this email is in register subject process";
                }else {
                    //User in system and have been activated
                    if(user.getActivate()){
                        User tokenInfo = uDao.getTokenInformation(email);
                        //Check token exist
                        if(tokenInfo.getToken() == null){
                            //If dont have token
                            String token = TokenGenerator.generateToken(uDao.getMobile(email));
                            EmailService emailService = new EmailService();
                            emailService.sendResetPasswordEmail(request, email, token);
                            uDao.updateToken(email, PasswordEncoder.encode(token), LocalDateTime.now(), LocalDateTime.now());
                            HttpSession session = request.getSession();
                            session.setAttribute("resetPasswordEmail", email);
                        }else{
                            //Have token
                            TokenService tokenService = new TokenService();
                            tokenService.handleVerifyToken(request, email, false);
                        }
                    }else {
                        //User in system but have not been activated
                        TokenService tokenService = new TokenService();
                        tokenService.handleVerifyToken(request, email, true);
                    }
                    response.sendRedirect("activate");
                    return;
                }
            }
        }
        request.setAttribute("error", error);
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

}
