package controller.account;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.TokenService;

@WebServlet(name="ActivateServlet", urlPatterns={"/account/activate"})
public class ActivateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        //If user verify a expired link
        if(session.getAttribute("expiredToken") != null) {
            request.setAttribute("message", "Link has expired. You can resend it by clicking the button below");
            session.removeAttribute("expiredToken");
            request.setAttribute("mode", "register");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
            return;
        }else{
            //Mode activate account
            if(session.getAttribute("unverifiedEmail") != null) {
                request.setAttribute("message", "Account for email has not been activated. Verify by link have sent to your email");
                //Check resend link error
                if(session.getAttribute("sendError") != null) {
                    session.removeAttribute("sendError");
                    request.setAttribute("sendError", "Resend link available every 5 minute");
                }
                request.setAttribute("mode", "register");
                request.getRequestDispatcher("verify.jsp").forward(request, response);
                return;
            }

            //Mode reset password
            if(session.getAttribute("resetPasswordEmail") != null) {
                request.setAttribute("message", "Verify your email by clicking the link have sent to your email");
                if(session.getAttribute("sendError") != null) {
                    session.removeAttribute("sendError");
                    request.setAttribute("sendError", "Resend link available every 5 minute");
                }
                request.setAttribute("mode", "forgot_password");
                request.getRequestDispatcher("verify.jsp").forward(request, response);
                return;
            }
        }
        //If do not have request email in session, forward to login
        response.sendRedirect("login");
    }

    //For resend verify link
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        //Mode activate account
        if (session.getAttribute("unverifiedEmail") != null) {
            String email = session.getAttribute("unverifiedEmail").toString();
            TokenService tokenService = new TokenService();
            //Handle token
            if(tokenService.handleVerifyToken(request, email, true)){
                response.sendRedirect("activate");
            }else{
                //Account has been verified
                //Resend after verify
                session.removeAttribute("unverifiedEmail");
                session.setAttribute("verifyNotification", "Your account has been activated");
                response.sendRedirect("login");
            }
            return;
        }


        if(session.getAttribute("resetPasswordEmail") != null) {
            String email = session.getAttribute("resetPasswordEmail").toString();
            TokenService tokenService = new TokenService();
            if(tokenService.handleVerifyToken(request, email, false)){
                response.sendRedirect("activate");
            }else{
                //Account has been verified
                //Resend after verify
                session.removeAttribute("resetPasswordEmail");
                session.setAttribute("verifyNotification", "Your account password has been reset");
                response.sendRedirect("login");
            }
            return;
        }
        //If do not have request email in session, forward to login
        response.sendRedirect("login");
    }

}
