package controller.lesson;

import dao.*;
import dto.LessonDTO;
import dto.QuizDTO;
import dto.UserDTO;
import entity.Lesson;
import entity.LessonType;
import entity.Subject;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateLessonServlet", urlPatterns = {"/management/lesson/edit"})
@MultipartConfig
public class UpdateLessonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        int lessonId = Integer.parseInt(request.getParameter("id"));
        LessonDAO lessonDAO = new LessonDAO();
        LessonDTO lesson = lessonDAO.getLessonDTOById(lessonId);
        UserDAO userDAO = new UserDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        LessonTypeDAO lessonTypeDAO = new LessonTypeDAO();
        List<LessonType> lessonTypeList = lessonTypeDAO.getAllLessonTypes();
        ArrayList<User> experts = userDAO.getAllExpert();
        QuizDAO quizDAO = new QuizDAO();
        if (currentUser.getRoleId() == 2) {
            List<QuizDTO> quizList = quizDAO.getQuizByCondition(currentUser.getId());
            List<Subject> subjectList = subjectDAO.getAllSubjects(currentUser.getId());
            request.setAttribute("quizList", quizList);
            request.setAttribute("subjectList", subjectList);
        }
        if (currentUser.getRoleId() == 1) {
            List<QuizDTO> quizList = quizDAO.getQuizByCondition(null);
            List<Subject> subjectList = subjectDAO.getAllSubjectsWithoutID();
            request.setAttribute("quizList", quizList);
            request.setAttribute("subjectList", subjectList);
        }
        QuizDTO quiz = quizDAO.findByQuizId(lesson.getQuizId());
        request.setAttribute("quiz", quiz);
        request.setAttribute("lesson", lesson);
        request.setAttribute("experts", experts);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("lessonTypeList", lessonTypeList);
        request.getRequestDispatcher("/lesson/subject_lesson_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String topic = request.getParameter("topic");
        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        int order = Integer.parseInt(request.getParameter("order"));
        String content = request.getParameter("content");
        int status = Integer.parseInt(request.getParameter("status"));
        String subjectIdParam = request.getParameter("subjectId");
        String quizIdParam = request.getParameter("quizId");
        int lessonTypeId = Integer.parseInt(request.getParameter("lessonTypeId"));
        String videoType = request.getParameter("videoType");
        String videoLink = null;
        if (subjectIdParam != null) {
            int subjectId = Integer.parseInt(subjectIdParam);

        if ("youtube".equals(videoType)) {
            videoLink = request.getParameter("videoLink").trim();
        } else if ("upload".equals(videoType)) {
            Part videoPart = request.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0) {
                String fileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/assets/videos");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fullPath = uploadDir + File.separator + fileName;
                videoPart.write(fullPath);

                // Lưu link tương đối để hiển thị
                videoLink = "assets/videos/" + fileName;
            }
        }
        LessonDAO dao = new LessonDAO();
        List<Lesson> lessonList = dao.selectAllLesson(subjectId);
        Lesson lessonName = dao.findById(id);
        if (!name.equalsIgnoreCase(lessonName.getName())) {
            for (Lesson lesson : lessonList) {
                if (name.equals(lesson.getName())) {
                    session.setAttribute("toastNotification", "Duplicate subject lesson name.");
                    response.sendRedirect("edit?id=" + id);
                    return;
                }
            }
        }
        SubjectDAO subjectDAO = new SubjectDAO();
        subjectDAO.updateOwner(subjectId, ownerId);
            boolean update = dao.updateLesson(id, name, topic, videoLink, order, content, status, Integer.parseInt(subjectIdParam), lessonTypeId, null);


            if (update) {
                session.setAttribute("toastNotification", "Lesson has been updated successfully.");

            } else {
                session.setAttribute("toastNotification", "Failed to create lesson.");
            }
        }
        else {
            QuizDAO quizDAO = new QuizDAO();
            QuizDTO quiz = quizDAO.findByQuizId(id);
            LessonDAO dao = new LessonDAO();
            boolean update = dao.updateLesson(id, name, topic, null, order, content, status, quiz.getSubject().getId(), lessonTypeId, Integer.parseInt(quizIdParam));


            if (update) {
                session.setAttribute("toastNotification", "Lesson has been updated successfully.");

            } else {
                session.setAttribute("toastNotification", "Failed to create lesson.");
            }
        }
        response.sendRedirect("list");
    }
}
