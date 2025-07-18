package controller.question;

import java.io.IOException;
import java.util.List;

import dao.*;
import dto.UserDTO;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "ViewQuestionServlet", urlPatterns = {"/management/question/view"})
public class ViewQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int questionId = Integer.parseInt(request.getParameter("id"));
            QuestionDAO qDAO = new QuestionDAO();
            Question question = qDAO.findById(questionId);

            if (question == null) {
                response.getWriter().write("Question not found.");
                return;
            }

            UserDTO user = (UserDTO) session.getAttribute("user");
            if(user.getRoleId() == 2) {
                int subjectId = qDAO.findSubjectIdByQuestionId(questionId);
                SubjectDAO subjectDAO = new SubjectDAO();
                if(!subjectDAO.isExpertHasSubject(subjectId, user.getId())){
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/account/login");
                    return;
                }
            }

            List<Subject> subjects = new SubjectDAO().getAllSubjects();
            List<Lesson> lessons = new LessonDAO().findAllBySubjectIds(
                    subjects.stream().map(Subject::getId).toList());
            List<Dimension> dimensions = new DimensionDAO().findAllBySubjectIds(
                    subjects.stream().map(Subject::getId).toList());
            List<QuestionLevel> levels = new QuestionLevelDAO().findAll();
            List<QuestionMedia> medias = new QuestionMediaDAO().findByQuestionId(questionId);
            List<QuestionOption> options = new QuestionOptionDAO().findByQuestionId(questionId);
            int subjectID = qDAO.findSubjectIdByQuestionId(questionId);
            request.setAttribute("question", question);
            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("lessons", lessons);
            request.setAttribute("dimensions", dimensions);
            request.setAttribute("questionLevels", levels);
            request.setAttribute("medias", medias);
            request.setAttribute("options", options);
            request.setAttribute("subjectID", subjectID);

            request.getRequestDispatcher("/question/question_view.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
