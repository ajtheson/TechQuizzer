package controller.quiz;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ExamAttemptDAO;
import dao.QuestionAttemptDAO;
import dao.UserChoiceDAO;
import dto.QuestionAttemptDTO;
import dto.UpdateQuestionAttemptDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "UpdateQuestionAttemptServlet", value = "/quiz/update-question-attempt")
public class UpdateQuestionAttemptServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        ObjectMapper mapper = new ObjectMapper();
        UpdateQuestionAttemptDTO updateQuestionAttemptDTO = mapper.readValue(request.getInputStream(), UpdateQuestionAttemptDTO.class);
        HttpSession session = request.getSession(false);

        try{
            int duration = updateQuestionAttemptDTO.getDuration();
            int examAttemptId = updateQuestionAttemptDTO.getExamAttemptId();
            List<QuestionAttemptDTO> questionAttemptDTOs = updateQuestionAttemptDTO.getQuestionAttempts();

            boolean isUpdatedQuestionAttempts = new QuestionAttemptDAO().updateQuestionAttemptsDuringExamAttempt(questionAttemptDTOs);
            if(!isUpdatedQuestionAttempts){
                throw new Exception("Question attempt not updated");
            }
            boolean isUpdatedExamAttempt = new ExamAttemptDAO().updateDuration(duration, examAttemptId);
            if(!isUpdatedExamAttempt){
                throw new Exception("Exam attempt not updated");
            }

            UserChoiceDAO userChoiceDAO = new UserChoiceDAO();
            for(QuestionAttemptDTO questionAttemptDTO : questionAttemptDTOs){
                int questionAttemptId = questionAttemptDTO.getId();

                Set<Integer> optionIdsInDB = new HashSet<>(userChoiceDAO.findAllOptionIdByQuestionAttemptId(questionAttemptId));
                Set<Integer> optionIdsSelected = new HashSet<>(questionAttemptDTO.getUserChoices());

                Set<Integer> toInsert = new HashSet<>(optionIdsSelected);
                toInsert.removeAll(optionIdsInDB);

                Set<Integer> toDelete = new HashSet<>(optionIdsInDB);
                toDelete.removeAll(optionIdsSelected);

                if(!toInsert.isEmpty()){
                    userChoiceDAO.insert(questionAttemptId, new ArrayList<>(toInsert));
                }
                if(!toDelete.isEmpty()){
                    userChoiceDAO.delete(questionAttemptId, new ArrayList<>(toDelete));
                }

            }
        }catch (Exception e){
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}