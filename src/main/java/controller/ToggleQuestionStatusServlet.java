package controller;

import java.io.IOException;
import java.io.PrintWriter;

import dao.QuestionDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "ToggleQuestionStatusServlet", urlPatterns = {"/toggle_question_status"})
public class ToggleQuestionStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {

            int questionId = Integer.parseInt(request.getParameter("id"));

            SubjectDAO subjectDAO = new SubjectDAO();
            QuestionDAO qDao = new QuestionDAO();

            UserDTO user = (UserDTO) session.getAttribute("user");
            if(user.getRoleId() == 2){
                int subjectID = qDao.findSubjectIdByQuestionId(questionId);
                if(!subjectDAO.isExpertHasSubject(subjectID, user.getId())){
                    session.invalidate();
                    response.sendRedirect("login.jsp");
                    return;
                }
            }
            boolean status = request.getParameter("mode").equals("activate");

            if(qDao.toggleStatus(questionId, status)){
                session.setAttribute("toastNotification", "Question has been updated successfully.");
                response.sendRedirect("questions");
            }else {
                session.setAttribute("toastNotification", "Question has been updated failed. Please try again later.");
                response.sendRedirect("questions");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
