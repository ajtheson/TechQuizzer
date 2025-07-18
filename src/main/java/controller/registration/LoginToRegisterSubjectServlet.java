package controller.registration;

import java.io.IOException;

import dao.UserDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;
import util.PasswordEncoder;

/**
 * @author Dell
 */
@WebServlet(name = "LoginToRegisterSubjectServlet", urlPatterns = {"/registration/login_to_register_subject"})
public class LoginToRegisterSubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDAO = new UserDAO();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("guestEmail");
        User u = uDAO.getUserByEmail(email);
        request.setAttribute("userName", u.getName());
        request.getRequestDispatcher("login_to_register_subject.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDAO = new UserDAO();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("guestEmail");
        String password = request.getParameter("password");
        User u = uDAO.getUserByEmail(email);
        //Login successful
        if(PasswordEncoder.encode(password).equals(u.getPassword())) {
            int subjectID = (Integer) session.getAttribute("guestSubjectID");
            session.removeAttribute("guestSubjectID");
            session.removeAttribute("guestEmail");
            UserService userService = new UserService();
            UserDTO userDTO = userService.toUserLoginDTO(u);
            session.setAttribute("user", userDTO);
            response.sendRedirect("register_subject?subject_id=" + subjectID);
        }else {
            request.setAttribute("userName", u.getName());
            request.setAttribute("sendError", "Wrong Password");
            request.getRequestDispatcher("login_to_register_subject.jsp").forward(request, response);
        }
    }

}
