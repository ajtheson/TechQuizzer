package controller;

import dao.*;
import dto.QuestionDTO;
import dto.UserDTO;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.QuestionService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetQuestionListServlet", urlPatterns = {"/questions"})
public class GetQuestionListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Init default for page, size, search, isFeatured, categoryId, sortOrder
        int page = 1;
        int size = 10;
        int subjectId = 0;
        int dimensionId = 0;
        int lessonId = 0;
        int levelId = 0;
        String status = "";
        String search = "";

        //Init DAO object needed
        QuestionDAO questionDAO = new QuestionDAO();
        RoleDAO roleDAO = new RoleDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        UserDAO userDAO = new UserDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        DimensionDAO dimensionDAO = new DimensionDAO();
        LessonDAO lessonDAO = new LessonDAO();
        QuestionLevelDAO questionLevelDAO = new QuestionLevelDAO();

        //Get userID from session
        int ownerId = 0;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (roleDAO.getRoleNameById(user.getRoleId()).equals("Expert")) {
                ownerId = user.getId();
            }
        }

        //Get page, size, search, isFeatured, categoryId, sortOrder from request
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("size") != null) {
            size = Integer.parseInt(request.getParameter("size"));
        }
        if (request.getParameter("search") != null) {
            search = request.getParameter("search");
        }
        if (request.getParameter("subjectId") != null) {
            subjectId = Integer.parseInt(request.getParameter("subjectId"));
        }
        if (request.getParameter("dimensionId") != null) {
            dimensionId = Integer.parseInt(request.getParameter("dimensionId"));
        }
        if (request.getParameter("lessonId") != null) {
            lessonId = Integer.parseInt(request.getParameter("lessonId"));
        }
        if (request.getParameter("levelId") != null) {
            levelId = Integer.parseInt(request.getParameter("levelId"));
        }
        if (request.getParameter("status") != null) {
            status = request.getParameter("status");
        }
        if(subjectId ==0){
            lessonId = 0;
            dimensionId = 0;
        }

        //Get all subjects from database and convert them to subjectDTO
        List<QuestionDTO> questions = questionDAO.findQuestionWithPagination(page, size, subjectId, dimensionId, lessonId, levelId, status, search, ownerId);

        //Get total subjects, total pages and categories to show in subject list page
        int totalQuestions = questionDAO.getTotalQuestion(subjectId, dimensionId, lessonId, levelId, status, search, ownerId);
        int totalPages = (int) Math.ceil((double) totalQuestions / size);

        List<Subject> subjects = subjectDAO.getAllSubjectsForQuestionList(ownerId);
        List<Dimension> dimensions = new ArrayList<>();
        List<Lesson> lessons = new ArrayList<>();
        if(subjectId != 0){
            List<Integer> subjectIds = new ArrayList<>();
            subjectIds.add(subjectId);
            dimensions = dimensionDAO.findAllBySubjectIds(subjectIds);
            lessons = lessonDAO.findAllBySubjectIds(subjectIds);
        }
        List<QuestionLevel> questionLevels = questionLevelDAO.findAll();

        request.setAttribute("questions", questions);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("size", size);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("dimensionId", dimensionId);
        request.setAttribute("lessonId", lessonId);
        request.setAttribute("levelId", levelId);
        request.setAttribute("search", search);
        request.setAttribute("subjects", subjects);
        request.setAttribute("dimensions", dimensions);
        request.setAttribute("lessons", lessons);
        request.setAttribute("questionLevels", questionLevels);
        if (!status.equals("")) {
            request.setAttribute("status", status);
        }
        request.setAttribute("ownerId", ownerId);
        request.getRequestDispatcher("question_list.jsp").forward(request, response);
    }
}
