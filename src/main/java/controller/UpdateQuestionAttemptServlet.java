package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ExamAttemptDAO;
import dao.QuestionAttemptDAO;
import dto.QuestionAttemptDTO;
import dto.UpdateQuestionAttemptDTO;
import entity.QuestionAttempt;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateQuestionAttemptServlet", value = "/update-question-attempt")
public class UpdateQuestionAttemptServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        ObjectMapper mapper = new ObjectMapper();
        UpdateQuestionAttemptDTO updateQuestionAttemptDTO = mapper.readValue(request.getInputStream(), UpdateQuestionAttemptDTO.class);
        try{
            int duration = updateQuestionAttemptDTO.getDuration();
            int examAttemptId = updateQuestionAttemptDTO.getExamAttemptId();
            List<QuestionAttemptDTO> questionAttemptDTOs = updateQuestionAttemptDTO.getQuestionAttempts();

            boolean isUpdatedQuestionAttempts = new QuestionAttemptDAO().updateQuestionAttemptDuringExamAttempt(questionAttemptDTOs);
            if(!isUpdatedQuestionAttempts){
                throw new Exception("Question attempt not updated");
            }
            boolean isUpdatedExamAttempt = new ExamAttemptDAO().updateDuration(duration, examAttemptId);
            if(!isUpdatedExamAttempt){
                throw new Exception("Exam attempt not updated");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}