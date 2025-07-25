package controller.lesson;

import dao.LessonDAO;
import dao.QuizDAO;
import dto.LessonDTO;
import dto.QuizDTO;
import dto.UserDTO;
import entity.Quiz;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "GetSubjectLessonDetailServlet", urlPatterns = {"/management/lesson/detail"})
public class GetSubjectLessonDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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
            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
                return;
            }
            QuizDAO quizDAO = new QuizDAO();
            QuizDTO quiz = quizDAO.findByQuizId(lesson.getQuizId());
            if (quiz != null) {
                request.setAttribute("quiz", quiz);
            }
            System.out.println("lesson.getQuizId() = " + lesson.getQuizId());


            request.setAttribute("lesson", lesson);
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("/lesson/subject_lesson_detail.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
