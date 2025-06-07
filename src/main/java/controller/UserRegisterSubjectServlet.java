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

        PricePackage p = pdao.get(packageID);

        Registration r = new Registration();

        r.setTime(LocalDateTime.now());
        r.setTotalCost(p.getSalePrice());
        r.setStatus("pending");
        r.setPricePackageId(packageID);
        r.setUserId(user.getId());

        SubjectDAO sDAO = new SubjectDAO();
        Subject s = sDAO.getForRegister(subjectID);
        List<PricePackage> packages = pdao.getActiveOfSubject(subjectID);
        request.setAttribute("subject", s);
        request.setAttribute("packages", packages);
        if(rDAO.addRegistration(r)){
            request.setAttribute("success", "Your registration has been confirmed");
            request.getRequestDispatcher("user_register_subject.jsp").forward(request, response);
        }else{
            request.setAttribute("error", "Something went wrong. Please try again");
            request.getRequestDispatcher("user_register_subject.jsp").forward(request, response);
        }
    }
}
