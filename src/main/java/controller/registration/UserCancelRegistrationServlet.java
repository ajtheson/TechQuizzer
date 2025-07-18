package controller.registration;

import java.io.IOException;

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
@WebServlet(name = "UserCancelRegistrationServlet", urlPatterns = {"/registration/cancel"})
public class UserCancelRegistrationServlet extends HttpServlet {






    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw = request.getParameter("id");
        if(raw == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
        }else{
            try{
                int id = Integer.parseInt(raw);
                RegistrationDAO rDAO = new RegistrationDAO();
                HttpSession session = request.getSession();
                if(rDAO.changeStatus(id, "Canceled")){
                    session.setAttribute("toastNotification", "Registration has been canceled successfully.");
                    response.sendRedirect("list");
                }else{
                    session.setAttribute("toastNotification", "Something went wrong. Please try again later.");
                    response.sendRedirect("list");
                }
            }catch (NumberFormatException e){
                response.sendRedirect(request.getContextPath() + "/account/login");
            }
        }
    }
}
