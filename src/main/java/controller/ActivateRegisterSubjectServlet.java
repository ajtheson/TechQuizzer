package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalDateTime;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.UserDAO;
import dto.RegisterDTO;
import entity.PricePackage;
import entity.Registration;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.eclipse.tags.shaded.org.apache.regexp.RE;

/**
 * @author Dell
 */
@WebServlet(name = "ActivateRegisterSubjectServlet", urlPatterns = {"/activate_register_subject"})
public class ActivateRegisterSubjectServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("activate_register_subject.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("otp") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String otpInput = request.getParameter("otp");
        String otpCheck = (String) session.getAttribute("otp");
        LocalDateTime otpCreateAt = (LocalDateTime) session.getAttribute("otpCreateAt");
        if(otpInput.equals(otpCheck)) {
            LocalDateTime now = LocalDateTime.now();
            Duration duration = Duration.between(otpCreateAt, now);
            if(duration.toSeconds() <= 300) {
                //Get registration information
                int packageID = (int) session.getAttribute("guestPID");
                RegisterDTO rDTO = (RegisterDTO) session.getAttribute("guestInfo");

                //Remove session
                session.removeAttribute("otp");
                session.removeAttribute("otpCreateAt");
                session.removeAttribute("guestPID");
                session.removeAttribute("guestInfo");

                //Handle registration
                User user = new User();
                user.setEmail(rDTO.getEmail());
                user.setName(rDTO.getName());
                user.setMobile(rDTO.getMobile());
                user.setAddress(rDTO.getAddress());
                Boolean gender = null;
                if (rDTO.getGenderString().equals("male")) {
                    gender = true;
                }
                if (rDTO.getGenderString().equals("female")) {
                    gender = false;
                }
                user.setGender(gender);

                UserDAO uDAO = new UserDAO();
                int userID = uDAO.addAccountForRegisterSubject(user);
                if(userID  == -1) {
                    session.setAttribute("verifyNotification", "Something went wrong");
                    response.sendRedirect("login");
                    return;
                }else {
                    RegistrationDAO rDAO = new RegistrationDAO();
                    PricePackageDAO pDAO = new PricePackageDAO();
                    PricePackage pricePackage = pDAO.get(packageID);
                    Registration registration = new Registration();
                    registration.setTime(LocalDateTime.now());
                    registration.setTotalCost(pricePackage.getSalePrice());
                    registration.setStatus("pending");
                    registration.setPricePackageId(packageID);
                    registration.setUserId(userID);
                    if(rDAO.addRegistration(registration)) {
                        session.setAttribute("verifyNotification", "Your registration has been verified");
                        response.sendRedirect("login");
                        return;
                    }else {
                        session.setAttribute("verifyNotification", "Something went wrong");
                        response.sendRedirect("login");
                        return;
                    }

                }
            }else{
                request.setAttribute("error", "OTP has expired. Enter resend box bellow");
            }
        }else {
            request.setAttribute("error", "Incorrect OTP");
        }
        request.getRequestDispatcher("activate_register_subject.jsp").forward(request, response);
    }
}
