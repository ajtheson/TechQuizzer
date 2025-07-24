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
        String correctParam = request.getParameter("correct");
        HttpSession session = request.getSession(false);

        try{
            int examAttemptId = Integer.parseInt(examAttemptIdParam);
            int numberCorrectQuestion = Integer.parseInt(correctParam);

            boolean isUpdated =  new ExamAttemptDAO().updateNumberCorrectQuestion(numberCorrectQuestion, examAttemptId);
            if(!isUpdated){
                session.setAttribute("toastNotification", "Number correct questions updated failed.");
            }else{
                session.setAttribute("toastNotification", "Number correct questions updated successfully.");
            }
            String previousURL = request.getHeader("Referer");
            response.sendRedirect(previousURL);
        } catch (Exception e) {
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}