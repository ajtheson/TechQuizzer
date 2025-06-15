package controller;

import dao.QuizSettingDAO;
import dao.QuizSettingGroupDAO;
import entity.QuizSettingGroup;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateQuizServlet", urlPatterns = {"/quiz-setting"})
public class UpdateQuizServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateSetting".equals(action)) {
            updateQuizSetting(request, response);
        } else if ("removeSetting".equals(action)) {
            removeQuizSettingGroup(request, response);
        } else {
            response.sendRedirect("quizzeslist");
        }
    }

    private void removeQuizSettingGroup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int quizId = Integer.parseInt(request.getParameter("id"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            String type = request.getParameter("type");
            int groupId = Integer.parseInt(request.getParameter("groupId"));

            QuizSettingGroupDAO groupDAO = new QuizSettingGroupDAO();
            int quizSettingId = getQuizSettingId(quizId);

            // Check if this is the last group of this type
            List<QuizSettingGroup> existingGroups;
            if ("lesson".equals(type)) {
                existingGroups = groupDAO.getByQuizSettingIdAndType(quizSettingId, "lesson");
            } else {
                existingGroups = groupDAO.getByQuizSettingIdAndType(quizSettingId, "dimension");
            }

            if (existingGroups.size() <= 1) {
                response.getWriter().write("error: Cannot remove the last question group");
                return;
            }

            // Remove the specific group
            if ("lesson".equals(type)) {
                groupDAO.deleteByQuizSettingIdAndLessonId(quizSettingId, groupId);
            } else if ("dimension".equals(type)) {
                groupDAO.deleteByQuizSettingIdAndDimensionId(quizSettingId, groupId);
            }

            // Recalculate total questions after removal
            List<QuizSettingGroup> remainingGroups;
            if ("lesson".equals(type)) {
                remainingGroups = groupDAO.getByQuizSettingIdAndType(quizSettingId, "lesson");
            } else {
                remainingGroups = groupDAO.getByQuizSettingIdAndType(quizSettingId, "dimension");
            }

            int newTotalQuestions = remainingGroups.stream()
                    .mapToInt(QuizSettingGroup::getNumberQuestion)
                    .sum();

            // Update quiz setting with new total
            QuizSettingDAO quizSettingDAO = new QuizSettingDAO();
            quizSettingDAO.updateQuizSetting(quizSettingId, newTotalQuestions);

            response.getWriter().write("success");

        } catch (Exception e) {
            response.getWriter().write("error: " + e.getMessage());
        }
    }

    private void updateQuizSetting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            // Lấy thông tin cơ bản
            int quizId = Integer.parseInt(request.getParameter("id"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            int totalQuestions = Integer.parseInt(request.getParameter("numberOfQuestions"));
            String type = request.getParameter("type");

            // Lấy arrays từ form
            String[] questionCountsParam = request.getParameterValues("questionCounts");
            String[] questionGroups = request.getParameterValues("questionGroups");

            // Validate input
            if (questionCountsParam == null || questionGroups == null ||
                    questionCountsParam.length != questionGroups.length) {
                session.setAttribute("settingErrorMessage", "Invalid input data. Please check your form.");
                response.sendRedirect("get-quiz-detail?action=view&id=" + quizId + "&tab=setting");
                return;
            }

            // Tính tổng số câu hỏi từ các groups
            int totalGroupQuestions = 0;
            List<QuizSettingGroup> newGroups = new ArrayList<>();

            for (int i = 0; i < questionGroups.length; i++) {
                if (questionGroups[i] != null && !questionGroups[i].trim().isEmpty() &&
                        questionCountsParam[i] != null && !questionCountsParam[i].trim().isEmpty()) {

                    int groupId = Integer.parseInt(questionGroups[i]);
                    int questionCount = Integer.parseInt(questionCountsParam[i]);

                    // Validate question count is positive
                    if (questionCount <= 0) {
                        session.setAttribute("settingMessage", "Question count must be greater than 0.");
                        response.sendRedirect("get-quiz-detail?action=view&id=" + quizId + "&tab=setting");
                        return;
                    }

                    totalGroupQuestions += questionCount;

                    QuizSettingGroup group = new QuizSettingGroup();
                    group.setNumberQuestion(questionCount);
                    group.setQuizSettingId(getQuizSettingId(quizId));

                    if ("lesson".equals(type)) {
                        group.setSubjectLessonId(groupId);
                        group.setSubjectDimensionId(null);
                    } else if ("dimension".equals(type)) {
                        group.setSubjectDimensionId(groupId);
                        group.setSubjectLessonId(null);
                    }

                    newGroups.add(group);
                }
            }

            // Validate that we have at least one group
            if (newGroups.isEmpty()) {
                session.setAttribute("settingMessage", "At least one question group is required.");
                response.sendRedirect("get-quiz-detail?action=view&id=" + quizId + "&tab=setting");
                return;
            }

            // Kiểm tra tổng số câu hỏi
            if (totalGroupQuestions != totalQuestions) {
                String message = String.format(
                        "Total questions in groups (%d) must equal total quiz questions (%d). Please adjust your settings.",
                        totalGroupQuestions, totalQuestions
                );
                session.setAttribute("settingErrorMessage", message);
                response.sendRedirect("get-quiz-detail?action=view&id=" + quizId + "&tab=setting");
                return;
            }

            // Thực hiện update
            QuizSettingDAO quizSettingDAO = new QuizSettingDAO();
            QuizSettingGroupDAO groupDAO = new QuizSettingGroupDAO();

            int quizSettingId = getQuizSettingId(quizId);

            // Xóa tất cả setting groups cũ của quiz setting này theo type
            if ("lesson".equals(type)) {
                groupDAO.deleteByQuizSettingIdAndType(quizSettingId, "lesson");
            } else if ("dimension".equals(type)) {
                groupDAO.deleteByQuizSettingIdAndType(quizSettingId, "dimension");
            }

            // Thêm các setting groups mới
            for (QuizSettingGroup group : newGroups) {
                groupDAO.insertQuizSettingGroup(group);
            }

            // Update quiz setting
            quizSettingDAO.updateQuizSetting(quizSettingId, totalQuestions);

            session.setAttribute("settingMessage", "Quiz settings updated successfully!");
            response.sendRedirect("get-quiz-detail?action=view&id=" + quizId + "&tab=setting");

        } catch (NumberFormatException e) {
            session.setAttribute("settingErrorMessage", "Invalid number format. Please check your input.");
            response.sendRedirect("get-quiz-detail?action=view&id=" +
                    Integer.parseInt(request.getParameter("id")) + "&tab=setting");
        } catch (Exception e) {
            session.setAttribute("settingErrorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect("get-quiz-detail?action=view&id=" +
                    Integer.parseInt(request.getParameter("id")) + "&tab=setting");
        }
    }

    // Helper method để lấy quiz setting id từ quiz id
    private int getQuizSettingId(int quizId) {
        QuizSettingDAO dao = new QuizSettingDAO();
        return dao.getQuizSettingIdByQuizId(quizId);
    }
}