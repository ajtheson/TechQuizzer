package controller.practice;

import dao.PracticeDAO;
import dao.RegistrationDAO;
import dto.PracticeDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.Subject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PracticeListServlet", value = "/practice/list")
public class GetPracticeListServlet extends HttpServlet {

    private String formatDuration(int duration) {
        int hours = duration / 3600;
        int minutes = (duration % 3600) / 60;
        int seconds = duration % 60;
        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");
        String filterParam = request.getParameter("filter");

        try {
            PracticeDAO practiceDAO = new PracticeDAO();
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            int page = pageParam == null ? 1 : Integer.parseInt(pageParam);
            int size = sizeParam == null ? 3 : Integer.parseInt(sizeParam);
            int filter = filterParam == null ? 0 : Integer.parseInt(filterParam);

            UserDTO user = (UserDTO) session.getAttribute("user");
            List<RegistrationDTO> registrationDTOs = new RegistrationDAO().findAllByUserID(user.getId());
            List<Subject> subjects = registrationDTOs.stream().map(r -> r.getSubject()).toList();
            List<Integer> subjectIds = filter == 0 ? registrationDTOs.stream().map(r -> r.getSubject().getId()).toList()
                    : new ArrayList<>(List.of(filter));
            List<PracticeDTO> practiceDTOs = practiceDAO.findAllByUserIdAndSubjectIdsWithPagination(user.getId(), subjectIds, page, size);
            practiceDTOs.forEach(p -> p.setFormattedDuration(formatDuration(p.getExamAttempt().getDuration())));
            //calculate total page
            int totalQuizzes = practiceDAO.countByUserIdAndSubjectIds(user.getId(), subjectIds);
            int totalPages = totalQuizzes / size + (totalQuizzes % size == 0 ? 0 : 1);

            request.setAttribute("practices", practiceDTOs);
            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("totalPages", totalPages != 0 ? totalPages : 1);
            request.setAttribute("page", page);
            request.setAttribute("size", size);
            request.setAttribute("filter", filter);
            request.getRequestDispatcher("practice_list.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}