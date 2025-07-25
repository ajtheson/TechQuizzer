package controller.quiz;
import dao.*;
import dto.EssayAttemptDTO;
import dto.PracticeDTO;
import dto.QuestionAttemptDTO;
import dto.UserDTO;
import entity.ExamAttempt;
import entity.QuestionOption;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuizReviewServlet", value = "/quiz/review")
public class QuizReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");
        HttpSession session = request.getSession(false);
        try{
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }
            UserDTO user = (UserDTO) session.getAttribute("user");

            ExamAttemptDAO examAttemptDAO = new ExamAttemptDAO();
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            if(!examAttemptDAO.isTakenExamAttempt(examAttemptId)){
                throw new Exception("Exam attempt is not available");
            }

            if(user.getRoleId() == 3 && !examAttemptDAO.isBelongToUser(examAttemptId, user.getId())){
                throw new Exception("Exam attempt is not available");
            }
            
            //get format
            String format = "";
            ExamAttempt examAttempt = examAttemptDAO.findById(examAttemptId);
            if(examAttempt == null){
                throw new Exception("Exam attempt not found");
            }
            if(examAttempt.getQuizId() != null){
                Quiz quiz = new QuizDAO().findById(examAttempt.getQuizId());
                format = quiz.getFormat();
            }else{
                PracticeDTO practice = new PracticeDAO().findById(examAttempt.getPracticeId());
                format = practice.getFormat();
            }
            //handle multiple or essay question
            if(format.trim().equalsIgnoreCase("multiple")){
                List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);
                request.setAttribute("questionAttempts", questionAttemptDTOs);
                request.getRequestDispatcher("multiple_review.jsp").forward(request, response);
            }else{
                List<EssayAttemptDTO> essayAttemptDTOs = new EssayAttemptDAO().findAllByExamAttemptId(examAttemptId);
                request.setAttribute("essayAttempts", essayAttemptDTOs);
                request.getRequestDispatcher("essay_review.jsp").forward(request, response);
            }

        }catch (Exception e){
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}