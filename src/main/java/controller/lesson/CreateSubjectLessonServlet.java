package controller.lesson;

import dao.LessonDAO;
import dao.LessonTypeDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import entity.Lesson;
import entity.LessonType;
import entity.Subject;
import entity.User;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CreateSubjectLessonServlet", urlPatterns = {"/lesson/lesson-create"})
@MultipartConfig
public class CreateSubjectLessonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        UserDAO userDAO = new UserDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        LessonTypeDAO lessonTypeDAO = new LessonTypeDAO();

        List<Subject> subjectList = subjectDAO.getAllSubjectsWithoutID();
        List<LessonType> lessonTypeList = lessonTypeDAO.getAllLessonTypes();
        ArrayList<User> experts = userDAO.getAllExpert();

        request.setAttribute("subjectList", subjectList);
        request.setAttribute("lessonTypeList", lessonTypeList);
        request.setAttribute("experts", experts);
        request.setAttribute("currentUser", currentUser);

        request.getRequestDispatcher("subject_lesson_add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String topic = request.getParameter("topic");
//        String videoLink = request.getParameter("videoLink");
        int order = Integer.parseInt(request.getParameter("order"));
        String content = request.getParameter("content");
        int status = Integer.parseInt(request.getParameter("status"));
        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int lessonTypeId = Integer.parseInt(request.getParameter("lessonTypeId"));
        String videoType = request.getParameter("videoType");
        String videoLink = null;

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

        for (Lesson lesson : lessonList) {
            if (name.equalsIgnoreCase(lesson.getName())) {
                session.setAttribute("toastNotification", "Duplicate subject lesson name.");
                response.sendRedirect("lesson-create");
                return;
            }
        }

        SubjectDAO subjectDAO = new SubjectDAO();
        subjectDAO.updateOwner(subjectId, ownerId);

        boolean inserted = dao.insertLesson(name, topic, videoLink, order, content, status, subjectId, lessonTypeId);

        if (inserted) {
            session.setAttribute("toastNotification", "Lesson has been created successfully.");
        } else {
            session.setAttribute("toastNotification", "Failed to create lesson.");
        }
        UserDTO user = (UserDTO) session.getAttribute("user");
        if(user.getRoleId() ==1){
            response.sendRedirect("subject-lesson");
        } else if (user.getRoleId()==2) {
            response.sendRedirect("subject-lesson-expert");
        }

    }
}
