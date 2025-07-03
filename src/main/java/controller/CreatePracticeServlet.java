package controller;

import dao.*;
import dto.PracticeDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.ExamAttemptService;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "CreatePracticeServlet", value = "/practices/create")
public class CreatePracticeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }
            UserDTO user = (UserDTO) session.getAttribute("user");
            List<RegistrationDTO> registrationDTOs = new RegistrationDAO().findAllByUserID(user.getId());
            List<Subject> subjects = registrationDTOs.stream().map(r -> r.getSubject()).toList();
            List<Integer> subjectIds = subjects.stream().map(s -> s.getId()).toList();

            List<Dimension> dimensions = new DimensionDAO().findAllBySubjectIds(subjectIds);
            List<Lesson> lessons = new LessonDAO().findAllBySubjectIds(subjectIds);

            List<QuestionLevel> questionLevels = new QuestionLevelDAO().findAll();

            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("dimensions", dimensions);
            request.setAttribute("lessons", lessons);
            request.setAttribute("questionLevels", questionLevels);
            request.getRequestDispatcher("/practice_create.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        String nameParam = request.getParameter("name");
        String subjectIdParam = request.getParameter("subjectId");
        String numberOfQuestionsParam = request.getParameter("numberOfQuestions");
        String subjectDimensionIdParam = request.getParameter("subjectDimensionId");
        String subjectLessonIdParam = request.getParameter("subjectLessonId");
        String examFormatParam = request.getParameter("examFormat");
        String questionLevelIdParam = request.getParameter("questionLevelId");

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new Exception("User not logged in");
            }

            //prepare argument
            UserDTO user = (UserDTO) session.getAttribute("user");
            int subjectId = Integer.parseInt(subjectIdParam);
            int numberOfQuestions = Integer.parseInt(numberOfQuestionsParam);
            int questionLevelId = Integer.parseInt(questionLevelIdParam);
            int userId = user.getId();

            //insert practice
            Practice practiceObj = new Practice();
            practiceObj.setName(nameParam);
            practiceObj.setNumberOfQuestions(numberOfQuestions);
            practiceObj.setFormat(examFormatParam);
            practiceObj.setQuestionLevelId(questionLevelId);
            if (subjectDimensionIdParam != null) {
                int subjectDimensionId = Integer.parseInt(subjectDimensionIdParam);
                practiceObj.setSubjectDimensionId(subjectDimensionId);
            } else {
                int subjectLessonId = Integer.parseInt(subjectLessonIdParam);
                practiceObj.setSubjectLessonId(subjectLessonId);
            }
            practiceObj.setUserId(userId);
            Practice practice = new PracticeDAO().insert(practiceObj);
            if (practice == null) {
                throw new Exception("Practice not created");
            }

            int insertedExamAttemptId = new ExamAttemptService().createExamAttemptAndQuestionForExamAttempt(practice, userId);

            if(insertedExamAttemptId == -1){
                throw new Exception("Exam attempt not created");
            }
            response.sendRedirect(request.getContextPath() + "/quiz-handle?examAttemptId=" + insertedExamAttemptId);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}