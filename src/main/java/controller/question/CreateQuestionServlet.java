package controller.question;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.*;
import dto.UserDTO;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.ImageUploader;

/**
 *
 * @author Dell
 */
@WebServlet(name="CreateQuestionServlet", urlPatterns={"/create_question"})
@MultipartConfig
public class CreateQuestionServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            SubjectDAO sDAO = new SubjectDAO();

            if(session.getAttribute("user") == null) {
                session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }

            UserDTO user = (UserDTO)session.getAttribute("user");

            List<Subject> subjects = null;
            if(user.getRoleId() == 1){
                subjects = sDAO.getAllSubjects();
            }
            if(user.getRoleId() == 2){
                subjects = sDAO.getAllSubjectsByOwnerId(user.getId());
            }

            List<Integer> subjectIds = subjects.stream().map(s -> s.getId()).toList();

            List<Dimension> dimensions = new DimensionDAO().findAllBySubjectIds(subjectIds);
            List<Lesson> lessons = new LessonDAO().findAllBySubjectIds(subjectIds);

            List<QuestionLevel> questionLevels = new QuestionLevelDAO().findAll();

            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("dimensions", dimensions);
            request.setAttribute("lessons", lessons);
            request.setAttribute("questionLevels", questionLevels);
            request.getRequestDispatcher("question_create.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            request.setCharacterEncoding("UTF-8");

            // Extract basic question info
            String content = request.getParameter("content");
            String explanation = request.getParameter("explanation");
            String format = request.getParameter("format");
            boolean status = request.getParameter("status").equals("activate");
            int questionLevelId = Integer.parseInt(request.getParameter("questionLevelId"));

            String dimensionStr = request.getParameter("subjectDimensionId");
            String lessonStr = request.getParameter("subjectLessonId");

            Integer subjectDimensionId = (dimensionStr != null && !dimensionStr.isEmpty()) ? Integer.parseInt(dimensionStr) : null;
            Integer subjectLessonId = (lessonStr != null && !lessonStr.isEmpty()) ? Integer.parseInt(lessonStr) : null;

            Question q = new Question();
            q.setContent(content);
            q.setExplaination(explanation);
            q.setStatus(status);
            q.setQuestionFormat(format);
            q.setQuestionLevelId(questionLevelId);
            q.setSubjectDimensionId(subjectDimensionId != null ? subjectDimensionId : 0);
            q.setSubjectLessonId(subjectLessonId != null ? subjectLessonId : 0);

            int questionId = new QuestionDAO().create(q);

            // Parse metadata description for media
            Map<String, String> mediaDescMap = new HashMap<>();
            String[] metaInputs = request.getParameterValues("mediaMeta");
            if (metaInputs != null) {
                for (String meta : metaInputs) {
                    String[] parts = meta.split("\\|", 3);
                    if (parts.length == 3) {
                        mediaDescMap.put(parts[0], parts[2]); // filename -> desc
                    }
                }
            }

            // Prepare media folder path
            String relativePath = "assets/files/media/" + questionId;
            String absolutePath = getServletContext().getRealPath("/") + relativePath;
            File folder = new File(absolutePath);
            if (!folder.exists()) folder.mkdirs();

            // Upload media
            for (Part part : request.getParts()) {
                if ("media".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    ImageUploader.uploadFileFromServlet(absolutePath, fileName, part);
                    QuestionMedia media = new QuestionMedia();
                    media.setQuestionId(questionId);
                    media.setType(detectMediaType(fileName));
                    media.setLink(fileName);
                    media.setDescription(mediaDescMap.getOrDefault(fileName, ""));
                    new QuestionMediaDAO().insert(media);
                }
            }

            // If multiple choice, handle options
            if ("multiple".equals(format)) {
                // Lặp qua toàn bộ parameterNames
                Map<String, String[]> paramMap = request.getParameterMap();
                for (String param : paramMap.keySet()) {
                    if (param.startsWith("choiceText")) {
                        String index = param.replace("choiceText", "");
                        String text = request.getParameter(param).trim();
                        if (!text.isEmpty()) {
                            boolean isCorrect = request.getParameter("isCorrect" + index) != null;

                            QuestionOption opt = new QuestionOption();
                            opt.setOptionContent(text);
                            opt.setAnswer(isCorrect);
                            opt.setQuestionId(questionId);
                            new QuestionOptionDAO().insert(opt);
                        }
                    }
                }
            }
            session.setAttribute("toastNotification", "Question has been created successfully.");
            response.sendRedirect("questions");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastNotification", "Question has been created failed. Please try again later.");
            response.sendRedirect("questions");
        }
    }

    private String detectMediaType(String fileName) {
        String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        return switch (ext) {
            case "jpg", "jpeg", "png", "gif" -> "image";
            case "mp4", "webm" -> "video";
            case "mp3", "wav" -> "audio";
            default -> "unknown";
        };
    }
}


