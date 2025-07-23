package controller.quiz;
import dao.ExamAttemptDAO;
import dao.QuizDAO;
import dto.ExamAttemptDTO;
import dto.QuizDTO;
import dto.UserDTO;
import entity.ExamAttempt;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.ExamAttemptService;
import service.QuizService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SimulationExamDetailServlet", value = "/simulation/detail")
public class GetSimulationExamDetailServlet extends HttpServlet {

    private String formatDuration(int duration) {
        int hours = duration / 3600;
        int minutes = (duration % 3600) / 60;
        int seconds = duration % 60;
        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String idParam = request.getParameter("id");

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
            }

            UserDTO user = (UserDTO) session.getAttribute("user");

            int quizId = Integer.parseInt(idParam);
            Quiz quiz = new QuizDAO().findById(quizId);
            if (quiz != null) {
                QuizDTO quizDTO = new QuizService().convertQuizToQuizDTO(quiz);
                List<ExamAttemptDTO> examAttemptDTOs= new ExamAttemptDAO().findTop10ByQuizIdAndUserIdOrderByDateDescAndIdDesc(quizId, user.getId());
                examAttemptDTOs.forEach(e -> e.setFormattedDuration(formatDuration(e.getDuration())));

                request.setAttribute("quiz", quizDTO);
                request.setAttribute("submissions", examAttemptDTOs);
                request.getRequestDispatcher("/quiz/simulation_exam_detail.jsp").forward(request, response);
            }else{
                throw new ServletException("Quiz not found");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}