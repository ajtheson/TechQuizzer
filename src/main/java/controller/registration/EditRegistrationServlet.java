package controller.registration;

import java.io.IOException;
import java.time.LocalDateTime;

import dao.RegistrationDAO;
import dao.UserDAO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.Registration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.EmailService;
import util.PasswordEncoder;
import util.PasswordGenerator;

/**
 * @author Dell
 */
@WebServlet(name = "EditRegistrationServlet", urlPatterns = {"/edit_registration"})
public class EditRegistrationServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RegistrationDAO rDAO = new RegistrationDAO();
        RegistrationDTO registration = rDAO.getById(id);
        request.setAttribute("r", registration);
        request.getRequestDispatcher("edit_registration.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RegistrationDAO rDAO = new RegistrationDAO();
        UserDAO uDAO = new UserDAO();
        HttpSession session = request.getSession();
        UserDTO u = (UserDTO) session.getAttribute("user");

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String note = request.getParameter("note");

        RegistrationDTO registration = rDAO.getById(id);
        registration.setNote(note);
        registration.setLastUpdatedBy(uDAO.getForSale(u.getId()));

        Registration rUpdate = new Registration();
        rUpdate.setLastUpdatedBy(u.getId());
        rUpdate.setId(id);
        rUpdate.setNote(note);
        rUpdate.setStatus(registration.getStatus());
        if (status != null && !status.isEmpty()) {
            EmailService emailService = new EmailService();
            rUpdate.setStatus(status);
            registration.setStatus(status);
            if (status.equals("Pending Payment")) {
                emailService.sendStatusUpdateEmail(registration);
            }
            if (status.equals("Paid")) {
                LocalDateTime validFrom = LocalDateTime.now();
                LocalDateTime validTo = null;
                if (registration.getDuration() != null) {
                    validTo = validFrom.plusMonths(registration.getDuration());
                }
                rUpdate.setValidFrom(validFrom);
                rUpdate.setValidTo(validTo);

                if (registration.getUser().isTempUser()) {
                    //Create and Save password for new user
                    String password = PasswordGenerator.generatePassword();
                    uDAO.activateRegistration(registration.getUser().getId(), PasswordEncoder.encode(password));
                    registration.getUser().setPassword(password);
                }

                emailService.sendStatusUpdateEmail(registration);
            }
            if (status.equals("Rejected")) {
                if (registration.getUser().isTempUser()) {
                    rDAO.deleteTempRegistration(id);
                    uDAO.deleteTempUser(registration.getUser().getId());
                }
                emailService.sendStatusUpdateEmail(registration);
            }
        }
        if (rDAO.updateRegistration(rUpdate)) {
            session.setAttribute("toastNotification", "Registration has been updated successfully.");
            response.sendRedirect("registrations");
        } else {
            session.setAttribute("toastNotification", "Something went wrong. Please try again.");
            response.sendRedirect("registrations");
        }
    }
}
