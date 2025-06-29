package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dto.UserDTO;
import entity.PricePackage;
import entity.Registration;
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
@WebServlet(name = "UserRegisterSubjectServlet", urlPatterns = {"/user_register_subject"})
public class UserRegisterSubjectServlet extends HttpServlet {





    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        int packageID = Integer.parseInt(request.getParameter("packageId"));
        int subjectID = Integer.parseInt(request.getParameter("subjectId"));
        UserDTO user = (UserDTO) session.getAttribute("user");
        PricePackageDAO pdao = new PricePackageDAO();
        RegistrationDAO rDAO = new RegistrationDAO();

        if(rDAO.isRegistrationExist(user.getId(), subjectID)) {
            session.setAttribute("toastNotification", "You already have an active or pending course for this subject.");
            response.sendRedirect("my_registration");
            return;
        }

        PricePackage p = pdao.get(packageID);

        Registration r = new Registration();

        r.setTime(LocalDateTime.now());
        r.setTotalCost(p.getSalePrice());
        r.setDuration(p.getDuration());
        r.setStatus("Pending Confirmation");
        r.setPricePackageId(packageID);
        r.setUserId(user.getId());

        if(rDAO.addRegistration(r)){
            session.setAttribute("toastNotification", "Registration has been added successfully.");
            response.sendRedirect("my_registration");
        }else{
            session.setAttribute("toastNotification", "Something went wrong. Please try again later.");
            response.sendRedirect("my_registration");
        }
    }
}
