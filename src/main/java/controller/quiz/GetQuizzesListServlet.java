package controller.quiz;

import dao.QuizDAO;
import dao.SubjectDAO;
import dao.TestTypeDAO;
import dto.QuizDTO;
import dto.UserDTO;
import entity.Subject;
import entity.TestType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetQuizzesListServlet", urlPatterns = {"/quiz/quizzeslist"})
public class GetQuizzesListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }


        TestTypeDAO testDao = new TestTypeDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        List<TestType> testTypes = testDao.getAllTestTypes();
        List<Subject> subjects = subjectDAO.getAllSubjects(user.getId());


        String subjectFilter = request.getParameter("subject");
        String testTypeFilter = request.getParameter("testType");
        String subjectSelected = request.getParameter("subject");
        String testTypeSelected = request.getParameter("testType");
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
                    response.sendRedirect("quizzeslist");
                    return;
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid pagination input.");
            response.sendRedirect("quizzeslist");
            return;
        }


        if (sortField == null || sortField.isEmpty()) sortField = "q.id";
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "ASC";
        QuizDAO quizDAO = new QuizDAO();
        if (user.getRoleId()==1){
            List<QuizDTO> quizList = quizDAO.getQuizzesByPage(
                    subjectFilter, testTypeFilter, search,
                    page, pageSize, sortField, sortOrder, null);
            int totalRecords = quizDAO.getTotalQuizzes(
                    subjectFilter, testTypeFilter, search, user.getId());
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            request.setAttribute("quizList", quizList);
            request.setAttribute("subjects", subjects);
            request.setAttribute("testTypes", testTypes);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("subjects", subjects);
            request.setAttribute("subject", subjectFilter);
            request.setAttribute("selectedSubject", subjectSelected);
            request.setAttribute("testType", testTypeFilter);
            request.setAttribute("testTypes", testTypes);
            request.setAttribute("selectedTestType", testTypeSelected);
            request.setAttribute("search", search);
            request.setAttribute("sortField", sortField);
            request.setAttribute("sortOrder", sortOrder);

            request.getRequestDispatcher("quiz_list.jsp").forward(request, response);
        }
        else {
            List<QuizDTO> quizList = quizDAO.getQuizzesByPage(
                    subjectFilter, testTypeFilter, search,
                    page, pageSize, sortField, sortOrder, user.getId());

            int totalRecords = quizDAO.getTotalQuizzes(
                    subjectFilter, testTypeFilter, search, user.getId());
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            request.setAttribute("quizList", quizList);
            request.setAttribute("subjects", subjects);
            request.setAttribute("testTypes", testTypes);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("subjects", subjects);
            request.setAttribute("subject", subjectFilter);
            request.setAttribute("selectedSubject", subjectSelected);
            request.setAttribute("testType", testTypeFilter);
            request.setAttribute("testTypes", testTypes);
            request.setAttribute("selectedTestType", testTypeSelected);
            request.setAttribute("search", search);
            request.setAttribute("sortField", sortField);
            request.setAttribute("sortOrder", sortOrder);

            request.getRequestDispatcher("quiz_list.jsp").forward(request, response);
        }
    }
}
