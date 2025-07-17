package controller.quiz;
import dao.QuizDAO;
import dto.QuizDTO;
import dto.UserDTO;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.ExamAttemptService;
import service.QuizService;

import java.io.IOException;

@WebServlet(name = "SimulationExamDetailServlet", value = "/simulation/detail")
public class GetSimulationExamDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String idParam = request.getParameter("id");

        try {
            int id = Integer.parseInt(idParam);
            Quiz quiz = new QuizDAO().findById(id);
            if (quiz != null) {
                QuizDTO quizDTO = new QuizService().convertQuizToQuizDTO(quiz);
                request.setAttribute("quiz", quizDTO);
                request.getRequestDispatcher("/quiz/simulation_exam_detail.jsp").forward(request, response);
            }else{
                throw new ServletException("Quiz not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

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