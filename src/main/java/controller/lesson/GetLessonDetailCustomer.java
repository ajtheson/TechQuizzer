package controller.lesson;

import dao.LessonDAO;
import dao.QuizDAO;
import dto.LessonDTO;
import dto.QuizDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.ExamAttemptService;
import service.QuizService;

import java.io.IOException;

@WebServlet(name = "GetLessonDetailCustomer", urlPatterns = {"/lesson/detail"})

public class GetLessonDetailCustomer extends HttpServlet {
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
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        request.setAttribute("subjectId", lesson.getSubject().getId());
        request.setAttribute("lesson", lesson);
        request.setAttribute("currentUser", currentUser);

        request.getRequestDispatcher("/lesson/lesson-detail-customer.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizIdParam = request.getParameter("quizId");

        try{
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            int userId = ((UserDTO)session.getAttribute("user")).getId();
            int quizId = Integer.parseInt(quizIdParam);
            QuizDTO quizDTO = new QuizService().convertQuizToQuizDTO(new QuizDAO().findById(quizId));

            int insertedExamAttemptId = new ExamAttemptService().createExamAttemptAndQuestionForExamAttempt(quizDTO, userId);

            if(insertedExamAttemptId == -1){
                throw new Exception("Exam attempt not created");
            }

            //get previous url before click quiz handle
            String referer = request.getHeader("Referer");
            session.setAttribute("previousURL", referer);

            response.sendRedirect(request.getContextPath() + "/quiz/handle?examAttemptId=" + insertedExamAttemptId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
