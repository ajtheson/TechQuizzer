package controller.quiz;

import dao.EssayAttemptDAO;
import dao.EssaySubmissionDAO;
import dao.ExamAttemptDAO;
import dto.EssayAttemptDTO;
import entity.EssaySubmission;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import util.ImageUploader;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateEssaySubmissionServlet", value = "/quiz/update-essay-attempt")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // Kích thước file tạm trên RAM (1MB)
        maxFileSize = 1024 * 1024 * 20,       // Kích thước tối đa của 1 file (10MB)
        maxRequestSize = 1024 * 1024 * 100     // Tổng kích thước toàn bộ request (50MB)
)
public class UpdateEssaySubmissionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get parameter
        List<EssaySubmission> submissions = new ArrayList<>();
        List<EssayAttemptDTO> attemptDTOs = new ArrayList<>();
        HttpSession session = request.getSession(false);

        try{
            boolean isMultipart = request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/"); //check headers type
            int duration = 0;
            int examAttemptId = 0;
            if (!isMultipart) {
                String durationParam = request.getParameter("duration");
                String examAttemptIdParam = request.getParameter("examAttemptId");
                duration = Integer.parseInt(durationParam);
                examAttemptId = Integer.parseInt(examAttemptIdParam);
            }else {
                Part durationParam = request.getPart("duration");
                Part examAttemptIdParam = request.getPart("examAttemptId");
                String durationString = new String(durationParam.getInputStream().readAllBytes());
                String examAttemptIdString = new String(examAttemptIdParam.getInputStream().readAllBytes());
                duration = Integer.parseInt(durationString);
                examAttemptId = Integer.parseInt(examAttemptIdString);
            }

            boolean isUpdatedExamAttempt = new ExamAttemptDAO().updateDuration(duration, examAttemptId);
            if(!isUpdatedExamAttempt){
                throw new Exception("exam attempt not updated");
            }
            for(Part part : request.getParts()) {
                String partName = part.getName();
                //get submit files; eg: examAttempt0.submission0
                if(partName.startsWith("essayAttempt")){
                    String[] parts = partName.split("\\.");
                    int essayAttemptId = Integer.parseInt(parts[0].replace("essayAttempt", ""));
                    String fileName = part.getSubmittedFileName();

                    //upload file
                    String uploadDirectory = getServletContext().getRealPath("assets/files/essay/" + essayAttemptId);
                    boolean isUploaded = ImageUploader.uploadFileFromServlet(uploadDirectory, fileName, part);

                    if(isUploaded){
                        EssaySubmission submission = new EssaySubmission();
                        submission.setEssayAttemptId(essayAttemptId);
                        submission.setFileName(fileName);
                        submissions.add(submission);
                    }
                //get mark; eg: mark1
                }else if(partName.startsWith("mark")){
                    String isMarkedParam = request.getParameter(partName);
                    int essayAttemptId = Integer.parseInt(partName.replace("mark", ""));
                    boolean isMarked = Boolean.parseBoolean(isMarkedParam);
                    EssayAttemptDTO attemptDTO = new EssayAttemptDTO();
                    attemptDTO.setId(essayAttemptId);
                    attemptDTO.setMarked(isMarked);
                    attemptDTOs.add(attemptDTO);
                }
            }
            if(!submissions.isEmpty()){
                boolean isInsertedEssaySubmission = new EssaySubmissionDAO().insert(submissions);
                if(!isInsertedEssaySubmission){
                    throw new Exception("Essay submission insert failed");
                }
            }
            boolean isUpdatedEssayAttempt = new EssayAttemptDAO().updateEssayAttemptsDuringExamAttempt(attemptDTOs);
            if(!isUpdatedEssayAttempt){
                throw new Exception("Essay attempt not updated");
            }
        } catch (Exception e) {
            session.invalidate();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    }
}