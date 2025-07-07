package controller;

import dao.LessonDAO;
import dao.LessonTypeDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import dto.LessonDTO;
import dto.UserDTO;
import entity.Lesson;
import entity.LessonType;
import entity.Subject;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateLessonServlet", urlPatterns = {"/lesson-edit"})
public class UpdateLessonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        int lessonId = Integer.parseInt(request.getParameter("id"));
        LessonDAO lessonDAO = new LessonDAO();
        LessonDTO lesson = lessonDAO.getLessonDTOById(lessonId);
        UserDAO userDAO = new UserDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        LessonTypeDAO lessonTypeDAO = new LessonTypeDAO();
        List<LessonType> lessonTypeList = lessonTypeDAO.getAllLessonTypes();
        List<Subject> subjectList = subjectDAO.getAllSubjectsWithoutID();
        ArrayList<User> experts = userDAO.getAllExpert();
        request.setAttribute("lesson", lesson);
        request.setAttribute("experts", experts);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("lessonTypeList", lessonTypeList);
        request.getRequestDispatcher("subject_lesson_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String topic = request.getParameter("topic");
        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        String videoLink = request.getParameter("videoLink");
        int order = Integer.parseInt(request.getParameter("order"));
        String content = request.getParameter("content");
        int status = Integer.parseInt(request.getParameter("status"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int lessonTypeId = Integer.parseInt(request.getParameter("lessonTypeId"));
        LessonDAO dao = new LessonDAO();
        List<Lesson> lessonList = dao.selectAllLesson(subjectId);
        Lesson lessonName = dao.findById(id);
        if (!name.equalsIgnoreCase(lessonName.getName())) {
            for (Lesson lesson : lessonList) {
                if (name.equals(lesson.getName())) {
                    session.setAttribute("toastNotification", "Duplicate subject lesson name.");
                    response.sendRedirect("lesson-edit?id=" + id);
                    return;
                }
            }
        }
        SubjectDAO subjectDAO = new SubjectDAO();
        subjectDAO.updateOwner(subjectId, ownerId);
        boolean update =dao.updateLesson(id, name, topic, videoLink, order, content, status, subjectId, lessonTypeId);
        if(update){
            session.setAttribute("toastNotification", "Lesson has been updated successfully.");
            response.sendRedirect("subject-lesson");
        }

    }
}
