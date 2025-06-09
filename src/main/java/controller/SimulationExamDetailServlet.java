package controller;
import dao.QuizDAO;
import dto.QuizDTO;
import entity.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.QuizService;

import java.io.IOException;

@WebServlet(name = "SimulationExamDetailServlet", value = "/simulation-exam/detail")
public class SimulationExamDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String idParam = request.getParameter("id");

        try {
            int id = Integer.parseInt(idParam);
            Quiz quiz = new QuizDAO().findById(id);
            if (quiz != null) {
                QuizDTO quizDTO = new QuizService().convertQuizToQuizDTO(quiz);
                request.setAttribute("quiz", quizDTO);
                request.getRequestDispatcher("/simulation_exam_detail.jsp").forward(request, response);
            }else{
                throw new ServletException("Quiz not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}