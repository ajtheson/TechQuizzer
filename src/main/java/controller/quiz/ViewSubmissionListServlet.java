package controller.quiz;
import dao.*;
import dto.ExamAttemptDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ViewSubmissionServlet", value = "/management/quiz/view-submission")
public class ViewSubmissionListServlet extends HttpServlet {

    private String formatDuration(int duration) {
        int hours = duration / 3600;
        int minutes = (duration % 3600) / 60;
        int seconds = duration % 60;
        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String quizIdParam = request.getParameter("id");
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");
        String filterParam = request.getParameter("filter");
        String searchParam = request.getParameter("search");

        try {
            ExamAttemptDAO examAttemptDAO = new ExamAttemptDAO();
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            int quizId = Integer.parseInt(quizIdParam);
            int page = pageParam == null ? 1 : Integer.parseInt(pageParam);
            int size = sizeParam == null ? 10 : Integer.parseInt(sizeParam);
            LocalDate filter = filterParam == null ? null : LocalDate.parse(filterParam);
            String search = searchParam == null ? "" : searchParam;

            List<ExamAttemptDTO> examAttemptDTOs = examAttemptDAO.findAllByQuizIdWithPagination(quizId, page, size, search, filter);
            examAttemptDTOs.forEach(e -> e.setFormattedDuration(formatDuration(e.getDuration())));


            //calculate total page
            int totalQuizzes = examAttemptDAO.countByQuizId(quizId, search, filter);
            int totalPages = totalQuizzes / size + (totalQuizzes % size == 0 ? 0 : 1);

            request.setAttribute("submissions", examAttemptDTOs);
            request.setAttribute("quizId", quizId);
            request.setAttribute("totalPages", totalPages != 0 ? totalPages : 1);
            request.setAttribute("page", page);
            request.setAttribute("size", size);
            request.setAttribute("filter", filter);
            request.setAttribute("search", search);
            request.getRequestDispatcher("/quiz/quiz_submission_list.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}