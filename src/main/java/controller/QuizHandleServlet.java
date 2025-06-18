package controller;
import dao.ExamAttemptDAO;
import dao.QuestionAttemptDAO;
import dto.QuestionAttemptDTO;
import entity.ExamAttempt;
import entity.QuestionOption;
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
            List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);
            for(QuestionAttemptDTO questionAttemptDTO : questionAttemptDTOs){
                int asciiCharacter = 65;
                for(QuestionOption questionOption : questionAttemptDTO.getOptions()){
                    questionOption.setOptionContent((char)asciiCharacter + ". " + questionOption.getOptionContent());
                    asciiCharacter++;
                }
            }

            request.setAttribute("questionAttempts", questionAttemptDTOs);
            request.getRequestDispatcher("/quiz_handle/quiz_handle.jsp").forward(request, response);
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