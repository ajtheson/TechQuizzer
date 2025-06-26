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

import java.io.IOException;

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


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        StringBuilder redirectUrl = new StringBuilder("questions?");

        // Thêm các tham số vào URL
        String page = request.getParameter("page");
        if (page != null) {
            redirectUrl.append("page=").append(page);
        }

        String size = request.getParameter("size");
        if (size != null) {
            redirectUrl.append("&size=").append(size);
        }

        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            redirectUrl.append("&search=").append(search);
        }

        String subjectId = request.getParameter("subjectId");
        if (subjectId != null && !subjectId.equals("0")) {
            redirectUrl.append("&subjectId=").append(subjectId);
        }

        String dimensionId = request.getParameter("dimensionId");
        if (dimensionId != null && !dimensionId.equals("0")) {
            redirectUrl.append("&dimensionId=").append(dimensionId);
        }

        String lessonId = request.getParameter("lessonId");
        if (lessonId != null && !lessonId.equals("0")) {
            redirectUrl.append("&lessonId=").append(lessonId);
        }

        String levelId = request.getParameter("levelId");
        if (levelId != null && !levelId.equals("0")) {
            redirectUrl.append("&levelId=").append(levelId);
        }

        String statusFilter = request.getParameter("status");
        if (statusFilter != null && !statusFilter.isEmpty()) {
            redirectUrl.append("&status=").append(statusFilter);
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean statusChange = Boolean.parseBoolean(request.getParameter("statusChange"));

            QuestionDAO questionDAO = new QuestionDAO();
            questionDAO.updateStatus(id, statusChange);

            session.setAttribute("toastNotification", "Question status has been changed successfully.");
            response.sendRedirect(redirectUrl.toString());
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            session.setAttribute("toastNotification", "Question status has been changed failed.");
            response.sendRedirect(redirectUrl.toString());
        }
    }
}
