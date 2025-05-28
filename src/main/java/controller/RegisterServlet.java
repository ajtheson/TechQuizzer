package controller;

import java.io.IOException;


import dao.UserDAO;
import dto.RegisterDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import service.EmailService;
import service.TokenService;
import util.EmailValidator;
import util.PasswordEncoder;
import util.TokenGenerator;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDAO = new UserDAO();

        String name = request.getParameter("name").trim();
        String genderString = request.getParameter("gender").trim();
        String address = request.getParameter("address").trim();
        String email = request.getParameter("email").trim();
        String mobile = request.getParameter("mobile").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        RegisterDTO information = new RegisterDTO(email, password, confirmPassword, name, genderString, mobile, address);

        //Check register information
        String error = validateRegisterInformation(information);

        //Validate through database
        if (error == null) {
            //Check valid email
            if (false/*!EmailValidator.isEmailValid(email)*/) {
                error = "Email is not valid";
            } else {
                //Check mobile number exist
                if(uDAO.isMobileExist(mobile)) {
                    error = "Mobile number already exist";
                }else{
                    User checkExist = uDAO.isEmailInSystem(email);
                    //Email is not already existed in system
                    if (checkExist == null) {
                        //Convert DTO to Entity
                        User user = convertFromRegisterDTO(information);

                        //Create token and add user to database
                        String token = TokenGenerator.generateToken(mobile);
                        //Encrypt token
                        user.setToken(PasswordEncoder.encode(token));

                        if(uDAO.register(user)){
                            //Send email
                            EmailService emailService = new EmailService();
                            emailService.sendActivatingEmail(request, email, token, false);

                            HttpSession session = request.getSession();
                            session.setAttribute("unverifiedEmail", email);
                            response.sendRedirect("activate");
                            return;
                        }
                    }else {
                        //Email is already activated
                        if(checkExist.getActivate()){
                            error = "Email already in use and is already activated";
                        }else {
                            //Email in the system but is not activated
                            TokenService tokenService = new TokenService();
                            tokenService.handleVerifyToken(request, email, true);
                            response.sendRedirect("activate");
                            return;
                        }
                    }
                }
            }
        }
        //Having error
        request.setAttribute("error", error);
        request.setAttribute("information", information);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    private String validateRegisterInformation(RegisterDTO registerDTO) {
        //Check information is full
        if (!registerDTO.isValidInput()) {
            return "Some fields is empty";
        }

        //Check email regex
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        if (!registerDTO.getEmail().matches(emailRegex)) {
            return "Please enter a valid email address (e.g., example@email.com)";
        }

        //Check mobile regex
        String mobileRegex = "0\\d{9}";
        if (!registerDTO.getMobile().matches(mobileRegex)) {
            return "Mobile number must start with 0 and be exactly 10 digits";
        }

        //Check passwordRegex
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,16}$";
        if (!registerDTO.getPassword().matches(passwordRegex)) {
            return "Password must be 8–16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, 1 special character. No spaces allowed";
        }

        //Check confirm password is match with password
        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            return "Password and confirm password do not match";
        }

        return null;
    }

    private User convertFromRegisterDTO(RegisterDTO registerDTO) {
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        User user = modelMapper.map(registerDTO, User.class);

        //Set gender
        Boolean gender = null;
        if(registerDTO.getGenderString().equals("male")) {
            gender = true;
        }
        if(registerDTO.getGenderString().equals("female")) {
            gender = false;
        }
        user.setGender(gender);

        //Encrypt password
        user.setPassword(PasswordEncoder.encode(registerDTO.getPassword()));

        return user;
    }
}
