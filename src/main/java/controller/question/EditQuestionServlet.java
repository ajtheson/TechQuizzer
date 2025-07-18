package controller.question;

import dao.*;
import dto.UserDTO;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.ImageUploader;

import java.io.File;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "EditQuestionServlet", urlPatterns = {"/management/question/edit"})
@MultipartConfig
public class EditQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            int questionId = Integer.parseInt(request.getParameter("id"));

            QuestionDAO qDAO = new QuestionDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            QuestionLevelDAO levelDAO = new QuestionLevelDAO();
            QuestionMediaDAO mediaDAO = new QuestionMediaDAO();
            QuestionOptionDAO optionDAO = new QuestionOptionDAO();
            DimensionDAO dimensionDAO = new DimensionDAO();
            LessonDAO lessonDAO = new LessonDAO();

            Question question = qDAO.findById(questionId);
            if (question == null) throw new Exception("Question not found");




            int subjectID = qDAO.findSubjectIdByQuestionId(questionId);

            if(session.getAttribute("user") == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/account/login");
                return;
            }

            UserDTO user = (UserDTO)session.getAttribute("user");
            List<Subject> subjects = null;
            if(user.getRoleId() == 1){
                subjects = subjectDAO.getAllSubjects();
            }

            if(user.getRoleId() == 2){
                if(!subjectDAO.isExpertHasSubject(subjectID, user.getId())){
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/account/login");
                    return;
                }
                subjects = subjectDAO.getAllSubjectsByOwnerId(user.getId());
            }

            List<Integer> subjectIds = subjects.stream().map(s -> s.getId()).toList();

            List<Dimension> dimensions = dimensionDAO.findAllBySubjectIds(subjectIds);
            List<Lesson> lessons = lessonDAO.findAllBySubjectIds(subjectIds);
            List<QuestionLevel> levels = levelDAO.findAll();
            List<QuestionMedia> medias = mediaDAO.findByQuestionId(questionId);
            List<QuestionOption> options = optionDAO.findByQuestionId(questionId);



            request.setAttribute("question", question);
            request.setAttribute("mediaList", medias);
            request.setAttribute("optionList", options);
            request.setAttribute("registrationSubjects", subjects);
            request.setAttribute("dimensions", dimensions);
            request.setAttribute("lessons", lessons);
            request.setAttribute("questionLevels", levels);
            request.setAttribute("subjectID", subjectID);
            request.getRequestDispatcher("/question/question_edit.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error loading edit question: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            QuestionDAO qDAO = new QuestionDAO();
            QuestionMediaDAO mediaDAO = new QuestionMediaDAO();
            QuestionOptionDAO optionDAO = new QuestionOptionDAO();
            request.setCharacterEncoding("UTF-8");

            int oldQuestionId = Integer.parseInt(request.getParameter("oldid"));
            qDAO.markAsDeleted(oldQuestionId);

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
            q.setQuestionFormat(format);
            q.setQuestionLevelId(questionLevelId);
            q.setStatus(status);
            q.setSubjectDimensionId(subjectDimensionId != null ? subjectDimensionId : 0);
            q.setSubjectLessonId(subjectLessonId != null ? subjectLessonId : 0);

            int questionId = qDAO.create(q);

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

            // Handling with old media
            Map<String, String[]> paramMap = request.getParameterMap();
            for (String param : paramMap.keySet()) {
                if (param.startsWith("mediaReuse")) {
                    String index = param.replace("mediaReuse", "");
                    QuestionMedia qmedia = mediaDAO.findById(Integer.parseInt(index));
                    qmedia.setQuestionId(questionId);
                    mediaDAO.insert(qmedia);
                    ImageUploader.copyFile(getServletContext().getRealPath("/") + "assets/files/media/" + oldQuestionId, absolutePath, qmedia.getLink());
                }
            }


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
                    mediaDAO.insert(media);
                }
            }

            // If multiple choice, handle options
            if ("multiple".equals(format)) {
                // Lặp qua toàn bộ parameterNames
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
                            optionDAO.insert(opt);
                        }
                    }
                }
            }
            session.setAttribute("toastNotification", "Question has been edited successfully.");
            response.sendRedirect("list");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastNotification", "Question has been edited failed. Please try again later.");
            response.sendRedirect("list");
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
