package controller.lesson;

import dao.LessonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ToggleLessonStatusServlet", urlPatterns = {"/management/lesson/toggle-lesson-status-admin"})
public class ToggleLessonStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int status = Integer.parseInt(request.getParameter("status"));

                LessonDAO dao = new LessonDAO();
                boolean success = dao.changeLessonStatus(id, status);
                if (success) {
                    request.getSession().setAttribute("toastNotification", "Status updated successfully.");
                } else {
                    request.getSession().setAttribute("toastNotification", "Failed to update status.");
                }
                response.sendRedirect("list");
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                response.sendRedirect("list");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
