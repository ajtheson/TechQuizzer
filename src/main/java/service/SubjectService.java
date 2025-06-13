package service;

import dao.*;
import dto.SubjectDTO;
import entity.Subject;

public class SubjectService {
    public SubjectDTO toSubjectDTO(Subject subject){
        if(subject == null) return null;
        else{
            PricePackageDAO pricePackageDAO = new PricePackageDAO();
            UserDAO userDAO = new UserDAO();
            LessonDAO lessonDAO = new LessonDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            SubjectDTO subjectDTO = new SubjectDTO();
            subjectDTO.setId(subject.getId());
            subjectDTO.setName(subject.getName());
            subjectDTO.setTagLine(subject.getTagLine());
            subjectDTO.setThumbnail(subject.getThumbnail());
            subjectDTO.setShortDescription(subject.getShortDescription());
            subjectDTO.setLongDescription(subject.getLongDescription());
            subjectDTO.setFeaturedSubject(subject.isFeaturedSubject());
            subjectDTO.setPublished(subject.isPublished());
            subjectDTO.setCategoryId(subject.getCategoryId());
            subjectDTO.setOwnerId(subject.getOwnerId());
            subjectDTO.setUpdateDate(subject.getUpdateDate());
            subjectDTO.setMinListPrice(pricePackageDAO.getMinListPrice(subject.getId()));
            subjectDTO.setMinSalePrice(pricePackageDAO.getMinSalePrice(subject.getId()));
            subjectDTO.setNumberOfLesson(lessonDAO.getTotalLessons(subject.getId()));
            subjectDTO.setCategoryName(categoryDAO.getCategoryNameById(subject.getCategoryId()));
            return subjectDTO;
        }
    }
}
