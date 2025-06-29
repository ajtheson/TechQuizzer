package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import entity.PricePackage;
import entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "UserModifyRegistrationServlet", urlPatterns = {"/user_modify_registration"})
public class UserModifyRegistrationServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw = request.getParameter("id");
        if(raw == null) {
            response.sendRedirect("login");
        }else{
            try{
                int id = Integer.parseInt(raw);
                RegistrationDAO regDao = new RegistrationDAO();
                SubjectDAO sDAO = new SubjectDAO();
                PricePackageDAO pDAO = new PricePackageDAO();
                int subjectID = regDao.getSubjectId(id);
                int pricePackageID = regDao.getPricePackageId(id);
                Subject s = sDAO.getForRegister(subjectID);
                List<PricePackage> packages = pDAO.getActiveOfSubject(subjectID);
                request.setAttribute("userChoice", pricePackageID);
                request.setAttribute("subject", s);
                request.setAttribute("packages", packages);
                request.setAttribute("registrationID", id);
                request.getRequestDispatcher("user_modify_registration.jsp").forward(request, response);
            }catch (NumberFormatException e){
                response.sendRedirect("login");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int packageID = Integer.parseInt(request.getParameter("packageId"));
        int registrationID = Integer.parseInt(request.getParameter("registrationID"));

        PricePackageDAO pdao = new PricePackageDAO();
        RegistrationDAO rDAO = new RegistrationDAO();

        PricePackage p = pdao.get(packageID);
        HttpSession session = request.getSession();
        if(rDAO.userModifyRegistration(LocalDateTime.now(), p.getSalePrice(), p.getDuration(), packageID, registrationID)) {
            session.setAttribute("toastNotification", "Registration has been modified successfully.");
            response.sendRedirect("my_registration");
        }else{
            session.setAttribute("toastNotification", "Something went wrong. Please try again later.");
            response.sendRedirect("my_registration");
        }
    }
}
