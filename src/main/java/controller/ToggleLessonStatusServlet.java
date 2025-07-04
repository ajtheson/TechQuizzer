package controller;

import dao.LessonDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ToggleLessonStatusServlet", urlPatterns = {"/toggle-lesson-status-admin"})
public class ToggleLessonStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));

            LessonDAO dao = new LessonDAO();
            dao.changeLessonStatus(id, status);
            response.sendRedirect("subject-lesson");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("subject-lesson");
        }
    }
}
