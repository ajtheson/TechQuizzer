package controller.subject;

import dao.CategoryDAO;
import dao.SubjectDAO;
import dao.SubjectDescriptionImageDAO;
import dao.UserDAO;
import dto.SubjectDTO;
import entity.Category;
import entity.Subject;
import entity.SubjectDescriptionImage;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.SubjectService;
import util.ImageUploader;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet(name = "EditSubjectServlet", urlPatterns = {"/edit-subject"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 1000 * 1024 * 1024)
public class EditSubjectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get id from url
        int id = Integer.parseInt(request.getParameter("subject_id"));

        //Init needed DAO
        SubjectDAO subjectDAO = new SubjectDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        UserDAO userDAO = new UserDAO();
        SubjectDescriptionImageDAO subjectDescriptionImageDAO = new SubjectDescriptionImageDAO();

        List<Category> categories = categoryDAO.getAllCategory();
        ArrayList<User> experts = userDAO.getAllExpert();
        SubjectService subjectService = new SubjectService();
        SubjectDTO subject = subjectService.toSubjectDTO(subjectDAO.getSubjectById(id));
        subject.setOwnerName(userDAO.getUserById(subject.getOwnerId()).getName());
        subject.setLongDescription(subject.getLongDescription().replace("\\n", "\n"));
        List<SubjectDescriptionImage> subjectDescriptionImages = subjectDescriptionImageDAO.getAllImageBySubjectId(subject.getId());

        //Set attribute to request to pass to setting_edit.jsp
        request.setAttribute("subject", subject);
        request.setAttribute("categories", categories);
        if (!subjectDescriptionImages.isEmpty()) {
            request.setAttribute("subjectDescriptionImages", subjectDescriptionImages);
        }
        request.setAttribute("experts", experts);
        request.getRequestDispatcher("manage_subject_detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subjectIdParam = request.getParameter("subjectId");
        String categoryIdParam = request.getParameter("subjectCategory");
        String ownerIdParam = request.getParameter("owner");

        String name = request.getParameter("subjectName");
        String status = request.getParameter("status");
        String subjectDescription = request.getParameter("subjectDescription").replace("\n", "\\n");
        String tagLine = request.getParameter("tagLine");
        boolean isFeatured = request.getParameter("featured") != null;
        Part thumbnailPart = request.getPart("thumbnail");

        int subjectId = 0;
        int categoryId = 0;
        int ownerId = 0;
        try {
            subjectId = Integer.parseInt(subjectIdParam);
            categoryId = Integer.parseInt(categoryIdParam);
            ownerId = Integer.parseInt(ownerIdParam);
        } catch (NumberFormatException e) {
            System.out.println("Number format exception: " + e.getMessage());
        }

        SubjectDAO subjectDAO = new SubjectDAO();
        Subject subject = new Subject();
        subject.setId(subjectId);
        subject.setName(name);
        subject.setLongDescription(subjectDescription);
        subject.setTagLine(tagLine);
        subject.setFeaturedSubject(isFeatured);
        subject.setPublished(status.equals("Published"));
        subject.setCategoryId(categoryId);
        subject.setOwnerId(ownerId);
        subject.setUpdateDate(LocalDateTime.now());

        if (thumbnailPart.getSize() > 0) {
            String thumbnailDirectory = getServletContext().getRealPath("assets/images/thumbnail/subject");
            String thumbnailOriginalName = thumbnailPart.getSubmittedFileName();
            String extension = thumbnailOriginalName.substring(thumbnailOriginalName.lastIndexOf("."));
            String thumbnailName = "subject" + "_" + subjectId + "_" + Instant.now().toEpochMilli() + extension;
            ImageUploader.deleteImage(thumbnailDirectory, subjectDAO.getSubjectById(subjectId).getThumbnail());
            subject.setThumbnail(thumbnailName);
            ImageUploader.saveImage(thumbnailDirectory, thumbnailName, thumbnailPart);
        }
        else{
            subject.setThumbnail(subjectDAO.getSubjectById(subjectId).getThumbnail());
        }

        subjectDAO.update(subject);

        //Subject description images handle
        SubjectDescriptionImageDAO subjectDescriptionImageDAO = new SubjectDescriptionImageDAO();
        String descriptionImageDirectory = getServletContext().getRealPath("assets/images/subject_description");

        //Get all old subject description image from database
        List<SubjectDescriptionImage> existingImages = subjectDescriptionImageDAO.getAllImageBySubjectId(subjectId);
        List<Integer> existingImageIds = new ArrayList<>();
        for (SubjectDescriptionImage img : existingImages) {
            existingImageIds.add(img.getId());
        }

        //Get all part from form
        Collection<Part> imageParts = request.getParts();
        List<Part> descriptionImageParts = new ArrayList<>();
        List<String> descriptionImageCaptions = new ArrayList<>();

        // Get all images of input with name = "subjectDescriptionImageInput"
        for (Part part : imageParts) {
            if ("subjectDescriptionImageInput".equals(part.getName())) {
                descriptionImageParts.add(part);
            }
        }

        // Get all captions of textarea with name = "subjectDescriptionImageCaption"
        String[] captions = request.getParameterValues("subjectDescriptionImageCaption");
        if (captions != null) {
            for (String caption : captions) {
                descriptionImageCaptions.add(caption != null ? caption.trim() : "");
            }
        }

        // Get Id of existed description Image from front-end
        List<Integer> submittedExistingIds = new ArrayList<>();
        String[] existedIds = request.getParameterValues("existedImageId");
        if (existedIds != null) {
            for (String idStr : existedIds) {
                try {
                    submittedExistingIds.add(Integer.parseInt(idStr));
                } catch (NumberFormatException e) {
                    System.out.println("Invalid existing image ID: " + idStr);
                }
            }
        }

        //1. Delete old image if the id not in submitted list id
        for (Integer existingId : existingImageIds) {
            if (!submittedExistingIds.contains(existingId)) {
                // This image is deleted from FE
                SubjectDescriptionImage imageToDelete = subjectDescriptionImageDAO.getById(existingId);
                if (imageToDelete != null) {
                    // Delete image from assests/images/subject_description
                    ImageUploader.deleteImage(descriptionImageDirectory, imageToDelete.getUrl());
                    // Delete image from database
                    subjectDescriptionImageDAO.delete(existingId);
                    System.out.println("Deleted image with ID: " + existingId);
                }
            }
        }

        // 2. Handle all description images (Old and new)
        for (int i = 0; i < descriptionImageParts.size(); i++) {
            Part imagePart = descriptionImageParts.get(i);
            String caption = i < descriptionImageCaptions.size() ? descriptionImageCaptions.get(i) : "";

            boolean hasNewImage = imagePart.getSize() > 0;
            boolean hasCaption = !caption.isEmpty();

            // Continue if the are no image and no caption
            if (!hasNewImage && !hasCaption) {
                continue;
            }

            if (i < submittedExistingIds.size()) {
                // 3. Update old image
                Integer existingImageId = submittedExistingIds.get(i);
                SubjectDescriptionImage existingImage = subjectDescriptionImageDAO.getById(existingImageId);

                if (existingImage != null) {
                    // Update caption
                    existingImage.setCaption(caption);

                    // If there is new image with existed id, update it
                    if (hasNewImage) {
                        String originalName = imagePart.getSubmittedFileName();
                        String extension = originalName.substring(originalName.lastIndexOf("."));
                        String newImageName = "subject_desc_" + subjectId + "_" + Instant.now().toEpochMilli() + extension;

                        // Delete old image
                        ImageUploader.deleteImage(descriptionImageDirectory, existingImage.getUrl());

                        // Save new image
                        ImageUploader.saveImage(descriptionImageDirectory, newImageName, imagePart);
                        existingImage.setUrl(newImageName);

                        System.out.println("Updated image for existing ID: " + existingImageId + " with new image: " + newImageName);
                    } else {
                        System.out.println("Updated caption for existing ID: " + existingImageId);
                    }

                    // Update in database
                    subjectDescriptionImageDAO.update(existingImage);
                }
            } else {
                // 4. Add new description image
                if (hasNewImage) {
                    String originalName = imagePart.getSubmittedFileName();
                    String extension = originalName.substring(originalName.lastIndexOf("."));
                    String newImageName = "subject_desc_" + subjectId + "_" + Instant.now().toEpochMilli() + extension;

                    // Save image
                    ImageUploader.saveImage(descriptionImageDirectory, newImageName, imagePart);

                    // Create new record in database
                    SubjectDescriptionImage newImage = new SubjectDescriptionImage();
                    newImage.setSubjectId(subjectId);
                    newImage.setUrl(newImageName);
                    newImage.setCaption(caption);

                    subjectDescriptionImageDAO.add(newImage);
                    System.out.println("Added new image: " + newImageName);
                }
            }
        }

        HttpSession session = request.getSession();
        session.setAttribute("toastNotification", "Subject has been updated successfully.");
        // Redirect về trang detail
        response.sendRedirect("edit-subject?subject_id=" + subjectId);
    }
}
