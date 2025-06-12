package controller;

import dao.QuizDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleQuizStatusServlet", urlPatterns = {"/toggle-quiz-status"})
public class ToggleQuizStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("changeStatus");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            QuizDAO dao = new QuizDAO();
            dao.changeQuizStatus(id, status);


            response.sendRedirect("quizzeslist");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("quizzeslist");
        }
    }
}
