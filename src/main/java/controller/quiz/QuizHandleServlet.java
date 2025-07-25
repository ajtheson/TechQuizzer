package controller.quiz;
import dao.*;
import dto.EssayAttemptDTO;
import dto.PracticeDTO;
import dto.QuestionAttemptDTO;
import entity.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "QuizHandleServlet", value = "/quiz/handle")
public class QuizHandleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");
        HttpSession session = request.getSession(false);
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
            //handle multiple and essay question
            if(format.trim().equalsIgnoreCase("multiple")){
                List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);
                boolean isPractice = examAttempt.getType().trim().equalsIgnoreCase("practice");

                request.setAttribute("isPractice", isPractice);
                request.setAttribute("questionAttempts", questionAttemptDTOs);
                request.getRequestDispatcher("multiple_handle.jsp").forward(request, response);
            }else{
                List<EssayAttemptDTO> essayAttemptDTOs = new EssayAttemptDAO().findAllByExamAttemptId(examAttemptId);
                boolean isPractice = examAttempt.getType().trim().equalsIgnoreCase("practice");

                request.setAttribute("isPractice", isPractice);
                request.setAttribute("essayAttempts", essayAttemptDTOs);
                request.getRequestDispatcher("essay_handle.jsp").forward(request, response);
            }


        } catch (Exception e) {
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");
        HttpSession session = request.getSession(false);

        try{
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            List<QuestionAttemptDTO> questionAttemptDTOs = new QuestionAttemptDAO().findAllByExamAttemptId(examAttemptId);

            //calculate number correct question
            int numberCorrectQuestions = 0;
            for(QuestionAttemptDTO questionAttemptDTO : questionAttemptDTOs){
                List<Integer> optionIdsSelected = questionAttemptDTO.getUserChoices();
                if(optionIdsSelected != null && !optionIdsSelected.isEmpty()){
                    List<QuestionOption> options = questionAttemptDTO.getOptions();
                    List<Integer> correctOptionIds = options.stream().filter(option -> option.isAnswer())
                            .map(option -> option.getId())
                            .collect(Collectors.toList());

                    boolean isExactlyCorrect = new HashSet<>(optionIdsSelected).equals(new HashSet<>(correctOptionIds));
                    if(isExactlyCorrect){
                        numberCorrectQuestions++;
                    }
                }
            }

            boolean isUpdatedExamAttempt = new ExamAttemptDAO().updateNumberCorrectQuestion(numberCorrectQuestions, examAttemptId);
            if(!isUpdatedExamAttempt) {
                throw new Exception("Exam attempt not updated");
            }

            String previousURL = (String) request.getSession().getAttribute("previousURL");
            if(previousURL.contains("practice/create")){
                previousURL = request.getContextPath() + "/practice/list?page=1&size=3";
            }
            response.sendRedirect(previousURL);
        } catch (Exception e) {
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}