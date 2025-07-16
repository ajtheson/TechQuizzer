package controller.quiz;
import dao.*;
import dto.EssayAttemptDTO;
import dto.PracticeDTO;
import dto.QuestionAttemptDTO;
import entity.ExamAttempt;
import entity.QuestionOption;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuizReviewServlet", value = "/quiz-review")
public class QuizReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");

        try{
            ExamAttemptDAO examAttemptDAO = new ExamAttemptDAO();
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            if(!examAttemptDAO.isTakenExamAttempt(examAttemptId)){
                throw new Exception("Exam attempt is not taken");
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
            if(format.equalsIgnoreCase("multiple")){
                List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);
                for(QuestionAttemptDTO questionAttemptDTO : questionAttemptDTOs){
                    int asciiCharacter = 65;
                    for(QuestionOption questionOption : questionAttemptDTO.getOptions()){
                        questionOption.setOptionContent((char)asciiCharacter + ". " + questionOption.getOptionContent());
                        asciiCharacter++;
                        if(asciiCharacter == 91){
                            asciiCharacter = 97;
                        }
                    }
                }
                request.setAttribute("questionAttempts", questionAttemptDTOs);
                request.getRequestDispatcher("/quiz_handle/multiple_review.jsp").forward(request, response);
            }else{
                List<EssayAttemptDTO> essayAttemptDTOs = new EssayAttemptDAO().findAllByExamAttemptId(examAttemptId);
                request.setAttribute("essayAttempts", essayAttemptDTOs);
                request.getRequestDispatcher("/quiz_handle/essay_review.jsp").forward(request, response);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}