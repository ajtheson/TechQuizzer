package controller.registration;

import java.io.IOException;
import java.util.List;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dto.UserDTO;
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
@WebServlet(name = "RegisterSubjectServlet", urlPatterns = {"/registration/register_subject"})
public class RegisterSubjectServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            int subjectID = Integer.parseInt(request.getParameter("subject_id"));
            HttpSession session = request.getSession();
            SubjectDAO sDAO = new SubjectDAO();
            PricePackageDAO pDAO = new PricePackageDAO();
            Subject s = sDAO.findById(subjectID);
            if(!s.isPublished()){
                session.setAttribute("toastNotification", "Subject not published now");
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            List<PricePackage> packages = pDAO.getActiveOfSubject(subjectID);
            request.setAttribute("subject", s);
            request.setAttribute("packages", packages);
            //Check login
            if(session.getAttribute("user") != null){
                UserDTO user = (UserDTO) session.getAttribute("user");
                RegistrationDAO rDAO = new RegistrationDAO();
                if(rDAO.isRegistrationExist(user.getId(), subjectID)) {
                    session.setAttribute("toastNotification", "You already have an active or pending course for this subject.");
                    response.sendRedirect("list");
                    return;
                }
                request.getRequestDispatcher("user_register_subject.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("guest_register_subject.jsp").forward(request, response);
            }
        }catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
