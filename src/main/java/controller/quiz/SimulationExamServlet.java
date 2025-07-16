package controller.quiz;
import dao.*;
import dto.QuizDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.Quiz;
import entity.Subject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.QuizService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SimulationExamServlet", value = "/simulation-exam")
public class SimulationExamServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");
        String filterParam = request.getParameter("filter");
        String searchParam = request.getParameter("search");

        try {
            QuizDAO quizDAO = new QuizDAO();
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            int page = pageParam == null ? 1 : Integer.parseInt(pageParam);
            int size = sizeParam == null ? 10 : Integer.parseInt(sizeParam);
            int filter = filterParam == null ? 0 : Integer.parseInt(filterParam);
            String search = searchParam == null ? "" : searchParam;

            UserDTO user = (UserDTO) session.getAttribute("user");
            List<RegistrationDTO> registrationDTOs = new RegistrationDAO().findAllByUserID(user.getId());
            List<Subject> subjects = registrationDTOs.stream().map(r -> r.getSubject()).toList();
            List<Integer> subjectIds = filter == 0 ? registrationDTOs.stream().map(r -> r.getSubject().getId()).toList()
                    : new ArrayList<>(List.of(filter));
            TestTypeDAO testTypeDao = new TestTypeDAO();
            int testTypeId = testTypeDao.findByName("Simulation").getId();
            List<Quiz> quizzes = quizDAO.findAllByTestTypeIdAndSubjectIdsWithPagination(testTypeId, subjectIds, page, size, search);
            QuizService quizService = new QuizService();
            List<QuizDTO> quizzesDTO = quizService.convertQuizToQuizDTO(quizzes);

            //calculate total page
            int totalQuizzes = quizDAO.countByTestTypeIdAndSubjectIds(testTypeId, subjectIds, search);
            int totalPages = totalQuizzes / size + (totalQuizzes % size == 0 ? 0 : 1);

            request.setAttribute("quizzes", quizzesDTO);
            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("totalPages", totalPages != 0 ? totalPages : 1);
            request.setAttribute("page", page);
            request.setAttribute("size", size);
            request.setAttribute("filter", filter);
            request.setAttribute("search", search);
            request.getRequestDispatcher("simulation_exam.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}