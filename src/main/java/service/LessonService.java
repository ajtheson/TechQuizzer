package service;

import dao.LessonTypeDAO;
import dao.SubjectDAO;
import dto.LessonDTO;
import entity.Lesson;
import entity.LessonType;
import entity.Subject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class LessonService {
    public List<LessonDTO> convertLessonToLessonDTO(List<Lesson> lessons) {
        List<LessonDTO> lessonDTOList = new ArrayList<>();

        // Lấy danh sách các id duy nhất
        List<Integer> subjectIds = lessons.stream().map(Lesson::getSubjectId).distinct().toList();
        List<Integer> lessonTypeIds = lessons.stream().map(Lesson::getLessonTypeId).distinct().toList();

        // Truy xuất từ DB một lần duy nhất
        List<Subject> subjects = new SubjectDAO().findByIds(subjectIds);
        List<LessonType> lessonTypes = new LessonTypeDAO().findByIds(lessonTypeIds);

        // Map id -> entity
        Map<Integer, Subject> subjectMap = subjects.stream()
                .collect(Collectors.toMap(Subject::getId, s -> s));
        Map<Integer, LessonType> lessonTypeMap = lessonTypes.stream()
                .collect(Collectors.toMap(LessonType::getId, lt -> lt));

        // Tạo danh sách DTO
        for (Lesson lesson : lessons) {
            LessonDTO dto = new LessonDTO();
            dto.setId(lesson.getId());
            dto.setName(lesson.getName());
            dto.setOrder(lesson.getOrder());
            dto.setVideoLink(lesson.getVideoLink());
            dto.setContent(lesson.getContent());
            dto.setStatus(lesson.isStatus());
            dto.setSubject(subjectMap.get(lesson.getSubjectId()));
            dto.setLessonType(lessonTypeMap.get(lesson.getLessonTypeId()));

            lessonDTOList.add(dto);
        }

        return lessonDTOList;
    }
    public LessonDTO convertLessonToLessonDTO(Lesson lesson) {
        LessonDTO dto = new LessonDTO();
        dto.setId(lesson.getId());
        dto.setName(lesson.getName());
        dto.setOrder(lesson.getOrder());
        dto.setVideoLink(lesson.getVideoLink());
        dto.setContent(lesson.getContent());
        dto.setStatus(lesson.isStatus());
        dto.setSubject(new SubjectDAO().findById(lesson.getSubjectId()));
        dto.setLessonType(new LessonTypeDAO().findById(lesson.getLessonTypeId()));

        return dto;
    }


}
