package service;

import dao.DimensionDAO;
import dao.SubjectDAO;
import dto.DimensionDTO;
import dto.SubjectDTO;
import entity.Dimension;
import entity.Subject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DimensionService {

    public List<DimensionDTO> convertToDimensionDTOList(List<Dimension> dimensions) {
        List<DimensionDTO> dimensionDTOList = new ArrayList<>();

        // Lấy danh sách subjectId duy nhất
        List<Integer> subjectIds = dimensions.stream()
                .map(Dimension::getSubjectId)
                .distinct()
                .toList();

        // Truy xuất 1 lần từ DB
        List<Subject> subjects = new SubjectDAO().findByIds(subjectIds);
        Map<Integer, Subject> subjectMap = subjects.stream()
                .collect(Collectors.toMap(Subject::getId, s -> s));

        for (Dimension dimension : dimensions) {
            DimensionDTO dto = new DimensionDTO();
            dto.setId(dimension.getId());
            dto.setName(dimension.getName());
            dto.setType(dimension.getType());
            dto.setDescription(dimension.getDescription());
            dto.setStatus(dimension.isStatus());

            Subject subject = subjectMap.get(dimension.getSubjectId());
            if (subject != null) {
                SubjectDTO subjectDTO = new SubjectDTO();
                subjectDTO.setId(subject.getId());
                subjectDTO.setName(subject.getName());
                dto.setSubjectDTO(subjectDTO);
            }

            dimensionDTOList.add(dto);
        }

        return dimensionDTOList;
    }

    public DimensionDTO convertToDimensionDTO(Dimension dimension) {
        DimensionDTO dto = new DimensionDTO();
        dto.setId(dimension.getId());
        dto.setName(dimension.getName());
        dto.setType(dimension.getType());
        dto.setDescription(dimension.getDescription());
        dto.setStatus(dimension.isStatus());

        Subject subject = new SubjectDAO().findById(dimension.getSubjectId());
        if (subject != null) {
            SubjectDTO subjectDTO = new SubjectDTO();
            subjectDTO.setId(subject.getId());
            subjectDTO.setName(subject.getName());
            dto.setSubjectDTO(subjectDTO);
        }
        return dto;
    }
}
