package dao;

import dal.DBContext;
import dto.PracticeDTO;
import dto.PracticeQuestionLevelDTO;
import entity.*;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class PracticeDAO extends DBContext {

    public Practice insert(Practice practice) {
        String sql = "INSERT INTO [practices] ([name], [number_question], [subject_lesson_id], [subject_dimension_id], [user_id]) VALUES(?,?,?,?,?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setString(1, practice.getName());
            pstm.setInt(2, practice.getNumberOfQuestions());
            pstm.setObject(3, practice.getSubjectLessonId(), Types.INTEGER);
            pstm.setObject(4, practice.getSubjectDimensionId(), Types.INTEGER);
            pstm.setInt(5, practice.getUserId());
            int affectedRows = pstm.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        practice.setId(generatedKeys.getInt(1));
                    }
                }
                return practice;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public PracticeDTO findById(int practiceId) {
        String sql = "select t.*, l.name as lName, d.name as dName, s.id as sId, s.[name] as sName, e.[id] as eId, e.[start_date], e.[duration], e.[number_correct_question]\n" +
                "from (select * from practices where id = ?) t\n" +
                "left join [lessons] l on t.subject_lesson_id = l.id\n" +
                "left join [dimensions] d on t.subject_dimension_id = d.id\n" +
                "join [subjects] s on s.id = COALESCE(l.subject_id, d.subject_id)\n" +
                "left join [exam_attempts] e on e.practice_id = t.id";
        try(PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, practiceId);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()) {
                PracticeDTO practiceDTO = new PracticeDTO();
                practiceDTO.setId(rs.getInt("id"));
                practiceDTO.setName(rs.getString("name"));
                practiceDTO.setNumberOfQuestions(rs.getInt("number_question"));

                ExamAttempt examAttempt = new ExamAttempt();
                examAttempt.setId(rs.getInt("eId"));
                examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                examAttempt.setDuration(rs.getInt("duration"));
                examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                practiceDTO.setExamAttempt(examAttempt);

                int dimensionId = rs.getInt("subject_dimension_id");
                if(!rs.wasNull()){
                    Dimension dimension = new Dimension();
                    dimension.setId(dimensionId);
                    dimension.setName(rs.getString("dName"));
                    practiceDTO.setSubjectDimension(dimension);
                }
                else{
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("subject_lesson_id"));
                    lesson.setName(rs.getString("lName"));
                    practiceDTO.setSubjectLesson(lesson);
                }

                Subject subject = new Subject();
                subject.setId(rs.getInt("sId"));
                subject.setName(rs.getString("sName"));
                practiceDTO.setSubject(subject);

                practiceDTO.setPracticeQuestionLevels(new PracticeQuestionLevelDAO().findAllByPracticeIds(List.of(practiceId)));
                return practiceDTO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PracticeDTO> findAllByUserIdAndSubjectIdsWithPagination(int userId, List<Integer> subjectIds, int page, int size) throws SQLException {
        ArrayList<PracticeDTO> practiceDTOs = new ArrayList<>();
        if(subjectIds == null && subjectIds.isEmpty()) {
            return practiceDTOs;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT t.*, s.[name] as sName, e.[id] as eId, e.[start_date], e.[duration], e.[number_correct_question] "
                + "FROM (SELECT p.*, l.subject_id FROM [practices] p JOIN [lessons] l ON p.subject_lesson_id = l.id "
                        + "UNION ALL "
                        + "SELECT p.*, d.subject_id FROM [practices] p JOIN [dimensions] d ON p.subject_dimension_id = d.id) t "
                + "LEFT JOIN [subjects] s on s.id = t.subject_id "
                + "LEFT JOIN [exam_attempts] e on t.id = e.practice_id "
                + "WHERE t.[user_id] = ? AND [subject_id] IN (" + inClause + ") "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            pstm.setInt(index++, userId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            pstm.setInt(index++, (page - 1) * size);
            pstm.setInt(index, size);

            ResultSet rs = pstm.executeQuery();
            List<Integer> practiceIds = new ArrayList<>();
            while (rs.next()) {
                PracticeDTO practiceDTO = new PracticeDTO();
                practiceDTO.setId(rs.getInt("id"));
                practiceIds.add(practiceDTO.getId());

                practiceDTO.setName(rs.getString("name"));
                practiceDTO.setNumberOfQuestions(rs.getInt("number_question"));

                ExamAttempt examAttempt = new ExamAttempt();
                examAttempt.setId(rs.getInt("eId"));
                examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                examAttempt.setDuration(rs.getInt("duration"));
                examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                practiceDTO.setExamAttempt(examAttempt);

//                int dimensionId = rs.getInt("subject_dimension_id");
//                if(!rs.wasNull()){
//                    practiceDTO.setSubjectDimension(new DimensionDAO().findById(dimensionId));
//                }
//                int lessonId = rs.getInt("subject_lesson_id");
//                if(!rs.wasNull()){
//                    practiceDTO.setSubjectLesson(new LessonDAO().findById(lessonId));
//                }
                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                subject.setName(rs.getString("sName"));
                practiceDTO.setSubject(subject);

                practiceDTO.setPracticeQuestionLevels(null);
                practiceDTOs.add(practiceDTO);
            }

            List<PracticeQuestionLevelDTO> practiceQuestionLevels = new PracticeQuestionLevelDAO().findAllByPracticeIds(practiceIds);
            Map<Integer, List<PracticeQuestionLevelDTO>> map = new HashMap<>();
            for(PracticeQuestionLevelDTO practiceQuestionLevel : practiceQuestionLevels){
                if(map.containsKey(practiceQuestionLevel.getPracticeId())){
                    map.get(practiceQuestionLevel.getPracticeId()).add(practiceQuestionLevel);
                }else{
                    List<PracticeQuestionLevelDTO> list = new ArrayList<>();
                    list.add(practiceQuestionLevel);
                    map.put(practiceQuestionLevel.getPracticeId(), list);
                }
            }
            for(PracticeDTO practiceDTO : practiceDTOs){
                if(map.containsKey(practiceDTO.getId())){
                    practiceDTO.setPracticeQuestionLevels(map.get(practiceDTO.getId()));
                }else{
                    List<PracticeQuestionLevelDTO> list = new ArrayList<>();
                    practiceDTO.setPracticeQuestionLevels(list);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return practiceDTOs;
    }

    public int countByUserIdAndSubjectIds(int userId, List<Integer> subjectIds) throws SQLException {
        if(subjectIds == null || subjectIds.isEmpty()){
            return 0;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT COUNT(*) "
                + "FROM (SELECT p.*, l.subject_id FROM [practices] p JOIN [lessons] l ON p.subject_lesson_id = l.id "
                    + "UNION ALL "
                    + "SELECT p.*, d.subject_id FROM [practices] p JOIN [dimensions] d ON p.subject_dimension_id = d.id) t "
                + "WHERE [user_id] = ? AND [subject_id] IN (" + inClause + ")";
        try{
            PreparedStatement pstm = connection.prepareStatement(sql);
            int index = 1;
            pstm.setInt(index++, userId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            rs.next();
            return rs.getInt(1);
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

}


