package controller;

import dao.LessonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleLessonStatusExServlet", urlPatterns = {"/toggle-lesson-status-expert"})
public class ToggleLessonStatusExServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));

            LessonDAO dao = new LessonDAO();
            boolean success= dao.changeLessonStatus(id, status);
            if (success) {
                request.getSession().setAttribute("toastNotification", "Status updated successfully.");
            } else {
                request.getSession().setAttribute("toastNotification", "Failed to update status.");
            }
            response.sendRedirect("subject-lesson-expert");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("subject-lesson-expert");
        }
    }
}
