package controller.practice;
import dao.ExamAttemptDAO;
import dao.PracticeDAO;
import dao.RegistrationDAO;
import dto.PracticeDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.ExamAttempt;
import entity.Subject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PracticeDetailServlet", value = "/practice/detail")
public class GetPracticeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String idParam = request.getParameter("id");

        try{
            HttpSession session = request.getSession(false);
            PracticeDAO practiceDAO = new PracticeDAO();

            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }
            UserDTO user = (UserDTO) session.getAttribute("user");

            int id = Integer.parseInt(idParam);
            if(!practiceDAO.isBelongToUser(id, user.getId()) ){
                throw new Exception("Practice is not available");
            }

            List<RegistrationDTO> registrationDTOs = new RegistrationDAO().findAllByUserID(user.getId());
            List<Subject> subjects = registrationDTOs.stream().map(r -> r.getSubject()).toList();

            PracticeDTO practiceDTO = new PracticeDAO().findById(id);

            request.setAttribute("practice", practiceDTO);
            request.setAttribute("registrationSubjects", subjects);
            request.getRequestDispatcher("practice_detail.jsp").forward(request, response);
        }catch (Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("practiceId");
        try{
            int id = Integer.parseInt(idParam);
            ExamAttempt examAttempt = new ExamAttemptDAO().findByPracticeId(id);
            if(examAttempt == null){
                throw new Exception("Exam attempt not found");
            }
            response.sendRedirect(request.getContextPath() + "/quiz/review?examAttemptId=" + examAttempt.getId());
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}