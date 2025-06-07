package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import dao.PricePackageDAO;
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
@WebServlet(name = "RegisterSubjectServlet", urlPatterns = {"/register_subject"})
public class RegisterSubjectServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int subjectID = Integer.parseInt(request.getParameter("subject_id"));
        HttpSession session = request.getSession();
        SubjectDAO sDAO = new SubjectDAO();
        PricePackageDAO pDAO = new PricePackageDAO();
        Subject s = sDAO.getForRegister(subjectID);
        List<PricePackage> packages = pDAO.getActiveOfSubject(subjectID);
        request.setAttribute("subject", s);
        request.setAttribute("packages", packages);
        //Check login
        if(session.getAttribute("user") != null){
            request.getRequestDispatcher("user_register_subject.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("guest_register_subject.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
