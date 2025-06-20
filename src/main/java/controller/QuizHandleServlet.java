package controller;
import dao.*;
import dto.EssayAttemptDTO;
import dto.PracticeDTO;
import dto.QuestionAttemptDTO;
import entity.ExamAttempt;
import entity.Practice;
import entity.QuestionOption;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuizHandleServlet", value = "/quiz-handle")
public class QuizHandleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");

        try{
            ExamAttemptDAO examAttemptDAO = new ExamAttemptDAO();
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            if(examAttemptDAO.isTakenExamAttempt(examAttemptId)){
                throw new Exception("Exam attempt is taken");
            }else{
                examAttemptDAO.updateIsTaken(true, examAttemptId);
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
                    }
                }
                request.setAttribute("questionAttempts", questionAttemptDTOs);
                request.getRequestDispatcher("/quiz_handle/multiple_handle.jsp").forward(request, response);
            }else{
                List<EssayAttemptDTO> essayAttemptDTOs = new EssayAttemptDAO().findAllByExamAttemptId(examAttemptId);
                request.setAttribute("essayAttempts", essayAttemptDTOs);
                request.getRequestDispatcher("/quiz_handle/essay_handle.jsp").forward(request, response);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");

        try{
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);

            //calculate number correct question
            int numberCorrectQuestions = 0;
            for(QuestionAttemptDTO questionAttemptDTO : questionAttemptDTOs){
                if(questionAttemptDTO.getUserChoice() != null){
                    for(QuestionOption questionOption : questionAttemptDTO.getOptions()){
                        if(questionAttemptDTO.getUserChoice() == questionOption.getId() && questionOption.isAnswer()){
                            numberCorrectQuestions++;
                            break;
                        }
                    }
                }
            }
            boolean isUpdatedExamAttempt = new ExamAttemptDAO().updateNumberCorrectQuestion(numberCorrectQuestions, examAttemptId);
            if(!isUpdatedExamAttempt) {
                throw new Exception("Exam attempt not updated");
            }
            response.sendRedirect(request.getContextPath() + "/practices");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}