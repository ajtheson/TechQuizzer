package controller.lesson;

import dao.LessonDAO;
import dao.SubjectDAO;
import dao.LessonTypeDAO;
import dto.LessonDTO;
import dto.UserDTO;
import entity.Subject;
import entity.LessonType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetSubjectLessonListServletExpert", urlPatterns = {"/lesson/subject-lesson-expert"})
public class GetSubjectLessonListServletForExpert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SubjectDAO subjectDAO = new SubjectDAO();
        LessonTypeDAO lessonTypeDAO = new LessonTypeDAO();

        List<Subject> subjects = subjectDAO.getAllSubjects(user.getId());
        List<LessonType> lessonTypes = lessonTypeDAO.getAllLessonTypes();

        String subjectFilter = request.getParameter("subject");
        String subjectSelected = request.getParameter("subject");

        String lessonTypeFilter = request.getParameter("lessonType");
        String selectedLessonType = request.getParameter("lessonType");
        String search = request.getParameter("search");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        int page = 1;
        int pageSize = 10;

        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                int tmp = Integer.parseInt(pageSizeParam);
                if (tmp > 0) {
                    pageSize = tmp;
                } else {
                    session.setAttribute("error", "Page size must be greater than 0.");
                    response.sendRedirect("subject-lesson");
                    return;
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid pagination input.");
            response.sendRedirect("subject-lesson");
            return;
        }

        if (sortField == null || sortField.isEmpty()) sortField = "l.id";
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "ASC";

        LessonDAO lessonDAO = new LessonDAO();
        List<LessonDTO> lessonList = lessonDAO.getLessonsByPageForExpert(
                subjectFilter, lessonTypeFilter, search,
                page, pageSize, sortField, sortOrder, user.getId()
        );

        int totalRecords = lessonDAO.getTotalLessonsForExpert(subjectFilter, lessonTypeFilter, search, user.getId());
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("lessonList", lessonList);
        request.setAttribute("subjects", subjects);
        request.setAttribute("lessonTypes", lessonTypes);
        request.setAttribute("subject", subjectFilter);
        request.setAttribute("selectedSubject", subjectSelected);
        request.setAttribute("selectedLessonType", selectedLessonType);
        request.setAttribute("lessonType", lessonTypeFilter);
        request.setAttribute("search", search);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("subject_lesson_expert.jsp").forward(request, response);
    }
}
