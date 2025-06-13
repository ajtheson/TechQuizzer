package controller;
import dao.DimensionDAO;
import dao.LessonDAO;
import dao.PracticeDAO;
import dao.RegistrationDAO;
import dto.PracticeDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.Dimension;
import entity.Lesson;
import entity.Subject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PracticeDetailServlet", value = "/practice/detail")
public class PracticeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String idParam = request.getParameter("id");

        try{
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            UserDTO user = (UserDTO) session.getAttribute("user");
            List<RegistrationDTO> registrationDTOs = new RegistrationDAO().findAllByUserID(user.getId());
            List<Subject> subjects = registrationDTOs.stream().map(r -> r.getSubject()).toList();

            int id = Integer.parseInt(idParam);
            PracticeDTO practiceDTO = new PracticeDAO().findById(id);

            request.setAttribute("practice", practiceDTO);
            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("questionLevels", practiceDTO.getPracticeQuestionLevels());
            request.getRequestDispatcher("/practice_detail.jsp").forward(request, response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}