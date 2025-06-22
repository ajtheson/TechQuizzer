package controller;

import dao.QuestionDAO;
import dao.SettingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleQuestionStatusServlet", urlPatterns = {"/toggle-question-status"})
public class ToggleQuestionStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean statusChange = Boolean.parseBoolean(request.getParameter("statusChange"));

            QuestionDAO questionDAO = new QuestionDAO();
            questionDAO.updateStatus(id, statusChange);

            StringBuilder redirectUrl = new StringBuilder("questions?");

            // Thêm các tham số vào URL
            String page = request.getParameter("page");
            if (page != null) {
                redirectUrl.append("page=").append(page);
            }

            String size = request.getParameter("size");
            if (size != null) {
                redirectUrl.append("&size=").append(size);
            }

            String search = request.getParameter("search");
            if (search != null && !search.isEmpty()) {
                redirectUrl.append("&search=").append(search);
            }

            String subjectId = request.getParameter("subjectId");
            if (subjectId != null && !subjectId.equals("0")) {
                redirectUrl.append("&subjectId=").append(subjectId);
            }

            String dimensionId = request.getParameter("dimensionId");
            if (dimensionId != null && !dimensionId.equals("0")) {
                redirectUrl.append("&dimensionId=").append(dimensionId);
            }

            String lessonId = request.getParameter("lessonId");
            if (lessonId != null && !lessonId.equals("0")) {
                redirectUrl.append("&lessonId=").append(lessonId);
            }

            String levelId = request.getParameter("levelId");
            if (levelId != null && !levelId.equals("0")) {
                redirectUrl.append("&levelId=").append(levelId);
            }

            String statusFilter = request.getParameter("status");
            if (statusFilter != null && !statusFilter.isEmpty()) {
                redirectUrl.append("&status=").append(statusFilter);
            }

            response.sendRedirect(redirectUrl.toString());
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("questions");
        }
    }
}
