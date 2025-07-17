package controller.lesson;

import dao.LessonDAO;
import dto.LessonDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "GetSubjectLessonDetailServlet", urlPatterns = {"/lesson/lesson-detail"})
public class GetSubjectLessonDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        int lessonId = Integer.parseInt(idParam);

        LessonDAO dao = new LessonDAO();
        LessonDTO lesson = dao.getLessonDTOById(lessonId);

        if (lesson == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Lấy user từ session
        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        request.setAttribute("lesson", lesson);
        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("subject_lesson_detail.jsp").forward(request, response);
    }
}
