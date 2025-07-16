package controller.registration;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import dao.PricePackageDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import dto.RegisterDTO;
import entity.PricePackage;
import entity.Subject;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.EmailService;
import service.TokenService;

/**
 * @author Dell
 */
@WebServlet(name = "GuestRegisterSubject", urlPatterns = {"/guest_register_subject"})
public class GuestRegisterSubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SubjectDAO sDAO = new SubjectDAO();
        PricePackageDAO pDAO = new PricePackageDAO();
        UserDAO uDAO = new UserDAO();
        //Get subject info
        int subjectID = Integer.parseInt(request.getParameter("subjectId"));
        int packageID = Integer.parseInt(request.getParameter("packageId"));

        //Get info user
        String name = request.getParameter("name").trim();
        String genderString = request.getParameter("gender").trim();
        String address = request.getParameter("address").trim();
        String email = request.getParameter("email").trim();
        String mobile = request.getParameter("mobile").trim();

        //To DTO
        RegisterDTO rDTO = new RegisterDTO();
        rDTO.setName(name);
        rDTO.setGenderString(genderString);
        rDTO.setAddress(address);
        rDTO.setEmail(email);
        rDTO.setMobile(mobile);

        Subject s = sDAO.getForRegister(subjectID);
        List<PricePackage> packages = pDAO.getActiveOfSubject(subjectID);

        String error = validateUserInfo(rDTO);

        //Error when validate user input
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("subject", s);
            request.setAttribute("packages", packages);
            request.setAttribute("information", rDTO);
            request.getRequestDispatcher("guest_register_subject.jsp").forward(request, response);
            return;
        }

        User checkExist = uDAO.isEmailInSystem(email);
        //Email is not already existed in system
        if (checkExist == null) {
            //Check mobile number exist
            if (uDAO.isMobileExist(mobile)) {
                request.setAttribute("error", "Mobile number already exist");
                request.setAttribute("subject", s);
                request.setAttribute("packages", packages);
                request.setAttribute("information", rDTO);
                request.getRequestDispatcher("guest_register_subject.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("guestInfo", rDTO);
                session.setAttribute("guestPID", packageID);
                Random random = new Random();
                int otp = 1000 + random.nextInt(9000);
                session.setAttribute("otp", otp + "");
                session.setAttribute("otpCreateAt", LocalDateTime.now());
                EmailService emailService = new EmailService();
                emailService.sendOTPForRegisterSubject(email, otp + "", false);
                response.sendRedirect("activate_register_subject");
            }
        } else {
            //Email is already activated
            if (checkExist.getActivate()) {
                HttpSession session = request.getSession();
                session.setAttribute("guestEmail", email);
                session.setAttribute("guestSubjectID", subjectID);
                response.sendRedirect("login_to_register_subject");
            } else {
                //Email in the system but is not activated
                TokenService tokenService = new TokenService();
                tokenService.handleVerifyToken(request, email, true);
                response.sendRedirect("activate");
            }
        }
    }

    private String validateUserInfo(RegisterDTO rDTO) {
        if (rDTO.getName().isEmpty() || rDTO.getGenderString().isEmpty() || rDTO.getAddress().isEmpty() || rDTO.getEmail().isEmpty() || rDTO.getMobile().isEmpty()) {
            return "Some fields are missing";
        }
        //Check email regex
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        if (!rDTO.getEmail().matches(emailRegex)) {
            return "Please enter a valid email address (e.g., example@email.com)";
        }

        //Check mobile regex
        String mobileRegex = "0\\d{9}";
        if (!rDTO.getMobile().matches(mobileRegex)) {
            return "Mobile number must start with 0 and be exactly 10 digits";
        }

//        Check mail valid
//        if(!EmailValidator.isEmailValid(rDTO.getEmail())){
//            return "Email is not valid";
//        }

        //Check temp user
        UserDAO uDAO = new UserDAO();
        if (uDAO.checkTempUser(rDTO.getEmail())) {
           return "Account use this email is in register subject process";
        }

        return null;
    }


}
