package controller.registration;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import dto.UserDTO;
import entity.PricePackage;
import entity.Subject;
import entity.User;
import entity.Registration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "CreateRegistrationServlet", urlPatterns = {"/create_registration"})
public class CreateRegistrationServlet extends HttpServlet {




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDAO = new UserDAO();
        SubjectDAO sDAO = new SubjectDAO();
        PricePackageDAO pDAO = new PricePackageDAO();

        List<User> users = uDAO.getForCreateRegistration();
        List<Subject> subjects = sDAO.getForCreateRegistration();
        List<PricePackage> packages = new ArrayList<>();
        for(Subject s : subjects){
            List<PricePackage> pricePackages = pDAO.getActiveOfSubject(s.getId());
            packages.addAll(pricePackages);
        }

        request.setAttribute("users", users);
        request.setAttribute("subjects", subjects);
        request.setAttribute("packages", packages);

        request.getRequestDispatcher("create_registration.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO sale = (UserDTO) session.getAttribute("user");

        int userID = Integer.parseInt(request.getParameter("user"));
        int subjectID = Integer.parseInt(request.getParameter("subject"));
        int packageID = Integer.parseInt(request.getParameter("package"));
        String status = request.getParameter("status");
        String note = request.getParameter("note");

        RegistrationDAO rDAO = new RegistrationDAO();
        PricePackageDAO pDAO = new PricePackageDAO();

        if(rDAO.isRegistrationExist(userID, subjectID)){
            session.setAttribute("toastNotification", "User already have an active or pending course for this subject.");
            response.sendRedirect("registrations");
            return;
        }
        PricePackage pricePackage = pDAO.get(packageID);

        Registration registration = new Registration();
        registration.setTime(LocalDateTime.now());
        registration.setTotalCost(pricePackage.getSalePrice());
        registration.setDuration(pricePackage.getDuration());

        if(status.equals("Paid")){
            registration.setValidFrom(LocalDateTime.now());
            if(pricePackage.getDuration() != null){
                registration.setValidTo(LocalDateTime.now().plusMonths(pricePackage.getDuration()));
            }
        }

        registration.setStatus(status);
        registration.setNote(note);
        registration.setPricePackageId(packageID);
        registration.setUserId(userID);
        registration.setLastUpdatedBy(sale.getId());

        if(rDAO.createRegistrationBySale(registration)){
            session.setAttribute("toastNotification", "Registration has been created successfully.");
            response.sendRedirect("registrations");
        }else {
            session.setAttribute("toastNotification", "Registration has been created failed. Please try again later.");
            response.sendRedirect("registrations");
        }
    }

}
