package controller.registration;

import java.io.IOException;

import dao.RegistrationDAO;
import dto.RegistrationDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author Dell
 */
@WebServlet(name = "ViewRegistrationServlet", urlPatterns = {"/sale/registration/view"})
public class ViewRegistrationServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RegistrationDAO rDAO = new RegistrationDAO();
        RegistrationDTO registration = rDAO.getById(id);
        request.setAttribute("r", registration);
        request.getRequestDispatcher("view_registration.jsp").forward(request, response);
    }
}


