package controller.quiz;
import dao.ExamAttemptDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateCorrectQuestionServlet", value = "/management/quiz/edit-correct-question")
public class UpdateCorrectQuestionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String examAttemptIdParam = request.getParameter("examAttemptId");
        String numberCorrectQuestionParam = request.getParameter("numberCorrectQuestion");

        try{
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            int numberCorrectQuestion = Integer.parseInt(numberCorrectQuestionParam);

            boolean isUpdated =  new ExamAttemptDAO().updateNumberCorrectQuestion(numberCorrectQuestion, examAttemptId);
            if(!isUpdated){
                throw new Exception("Number correct question not updated");
            }
            response.sendRedirect("view-submission?id=");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}