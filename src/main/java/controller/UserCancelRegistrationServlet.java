package controller;

import java.io.IOException;
import java.io.PrintWriter;

import dao.RegistrationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "UserCancelRegistrationServlet", urlPatterns = {"/user_cancel_registration"})
public class UserCancelRegistrationServlet extends HttpServlet {






    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw = request.getParameter("id");
        if(raw == null) {
            response.sendRedirect("login");
        }else{
            try{
                int id = Integer.parseInt(raw);
                RegistrationDAO rDAO = new RegistrationDAO();
                HttpSession session = request.getSession();
                if(rDAO.changeStatus(id, "Canceled")){
                    session.setAttribute("toastNotification", "Registration has been canceled successfully.");
                    response.sendRedirect("my_registration");
                }else{
                    session.setAttribute("toastNotification", "Something went wrong. Please try again later.");
                    response.sendRedirect("my_registration");
                }
            }catch (NumberFormatException e){
                response.sendRedirect("login");
            }
        }
    }
}
