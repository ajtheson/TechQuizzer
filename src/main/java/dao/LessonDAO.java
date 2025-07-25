package dao;

import dal.DBContext;
import dto.LessonDTO;
import dto.SubjectDTO;
import entity.Lesson;
import entity.LessonType;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class LessonDAO extends DBContext {

    public Lesson findById(int id) {
        String sql = "select [id], [name], [subject_id] from [lessons] where id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                Lesson lesson = new Lesson();
                lesson.setId(rs.getInt("id"));
                lesson.setName(rs.getString("name"));
                lesson.setSubjectId(rs.getInt("subject_id"));
                return lesson;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public LessonDTO getLessonDTOById(int id) {
        LessonDTO lesson = null;
        String sql = "SELECT l.id, l.name, l.[order],l.topic, l.video_link, l.content, l.status, " +
                "l.subject_id,l.lesson_quiz_id, s.name AS subject_name, " +
                "l.lesson_type_id, lt.name AS lesson_type_name,u.name AS owner_name " +
                "FROM lessons l " +
                "LEFT JOIN subjects s ON l.subject_id = s.id " +
                "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                "LEFT JOIN users u ON s.owner_id = u.id "+
                "WHERE l.id = ?";

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setInt(1, id);
            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    lesson = new LessonDTO();
                    lesson.setId(rs.getInt("id"));
                    lesson.setName(rs.getString("name"));
                    lesson.setOrder(rs.getInt("order"));
                    lesson.setTopic(rs.getString("topic"));
                    lesson.setVideoLink(rs.getString("video_link"));
                    lesson.setContent(rs.getString("content"));
                    lesson.setStatus(rs.getBoolean("status"));
                    lesson.setQuizId(rs.getInt("lesson_quiz_id"));

                    // Subject
                    Subject subject = new Subject();
                    subject.setId(rs.getInt("subject_id"));
                    subject.setName(rs.getString("subject_name"));
                    lesson.setSubject(subject);

                    // SubjectDTO (nếu cần)
                    SubjectDTO subjectDTO = new SubjectDTO();
                    subjectDTO.setId(rs.getInt("subject_id"));
                    subjectDTO.setName(rs.getString("subject_name"));
                    subjectDTO.setOwnerName(rs.getString("owner_name"));
                    lesson.setSubjectDTO(subjectDTO);

                    // LessonType
                    LessonType lessonType = new LessonType();
                    lessonType.setId(rs.getInt("lesson_type_id"));
                    lessonType.setName(rs.getString("lesson_type_name"));
                    lesson.setLessonType(lessonType);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesson;
    }

    public List<Lesson> findAllBySubjectIds(List<Integer> subjectIds) {
        List<Lesson> lessons = new ArrayList<>();
        if(subjectIds == null || subjectIds.isEmpty()){
            return lessons;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT [id], [name], [subject_id] FROM [lessons] where [subject_id] in (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : subjectIds){
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Lesson lesson = new Lesson();
                lesson.setId(rs.getInt("id"));
                lesson.setName(rs.getString("name"));
                lesson.setSubjectId(rs.getInt("subject_id"));
                lessons.add(lesson);
                   }
        } catch (Exception e) {
            e.printStackTrace();
        }
            return lessons;
    }

    public int getTotalLessons(int subjectId){
        String sql = "SELECT COUNT(*) FROM [lessons] where [subject_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }catch (Exception e) {}
        return 0;
    }

    public List<Lesson> selectAllLesson(int subjectID) {
        List<Lesson> lessons = new ArrayList<Lesson>();
        String sql = "select * from [lessons] join [subjects] on [lessons].[subject_id]=subjects.id where subjects.id =?";

        try (
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, subjectID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson l = new Lesson(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("topic"),
                        rs.getInt("order"),
                        rs.getString("video_link"),
                        rs.getString("content"),
                        rs.getBoolean("status"),
                        rs.getInt("subject_id"),
                        rs.getObject("lesson_type_id") == null
                                ? null
                                : rs.getInt("lesson_type_id")
                );
                lessons.add(l);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }
    public List<LessonDTO> getLessonsByPage(String subjectName, String lessonTypeName, String searchText,
                                            int page, int pageSize, String sortField, String sortOrder) {
        List<LessonDTO> lessons = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT l.id, l.name, l.[order],l.topic, l.video_link, l.content, l.status, " +
                        "s.id AS subject_id, s.owner_id, s.name AS subject_name, " +
                        "u.name AS owner_name, " +
                        "lt.id AS lesson_type_id, lt.name AS lesson_type_name " +
                        "FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN users u ON s.owner_id = u.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                        "WHERE 1=1 "
        );
        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("l.name", "l.order","l.video_link","l.topic", "l.id", "s.name", "lt.name");
        if (!validSortFields.contains(sortField)) sortField = "l.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC")) sortOrder = "ASC";

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LessonDTO dto = new LessonDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setOrder(rs.getInt("order"));
                dto.setTopic(rs.getString("topic"));
                dto.setVideoLink(rs.getString("video_link"));
                dto.setContent(rs.getString("content"));
                dto.setStatus(rs.getBoolean("status"));

                SubjectDTO subjectDTO = new SubjectDTO();
                subjectDTO.setId(rs.getInt("subject_id"));
                subjectDTO.setName(rs.getString("subject_name"));
                subjectDTO.setOwnerName(rs.getString("owner_name"));

                dto.setSubjectDTO(subjectDTO);

                LessonType lessonType = new LessonType();
                lessonType.setId(rs.getInt("lesson_type_id"));
                lessonType.setName(rs.getString("lesson_type_name"));
                dto.setLessonType(lessonType);

                lessons.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lessons;
    }
    public int getTotalLessons(String subjectName, String lessonTypeName, String searchText) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id "
                + "WHERE 1=1"
        );

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<LessonDTO> getLessonsByPageForExpert(String subjectName, String lessonTypeName, String searchText,
                                                     int page, int pageSize, String sortField, String sortOrder, int expertId) {
        List<LessonDTO> lessons = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT l.id, l.name, l.[order],l.topic, l.video_link, l.content, l.status, " +
                        "s.id AS subject_id, s.name AS subject_name, " +
                        "lt.id AS lesson_type_id, lt.name AS lesson_type_name " +
                        "FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                        "WHERE s.owner_id = ?"
        );

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("l.name", "l.order","l.video_link","l.topic", "l.id", "s.name", "lt.name");
        if (!validSortFields.contains(sortField)) sortField = "l.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC")) sortOrder = "ASC";

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LessonDTO dto = new LessonDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setOrder(rs.getInt("order"));
                dto.setTopic(rs.getString("topic"));
                dto.setVideoLink(rs.getString("video_link"));
                dto.setContent(rs.getString("content"));
                dto.setStatus(rs.getBoolean("status"));
                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                subject.setName(rs.getString("subject_name"));
                dto.setSubject(subject);

                LessonType lessonType = new LessonType();
                lessonType.setId(rs.getInt("lesson_type_id"));
                lessonType.setName(rs.getString("lesson_type_name"));
                dto.setLessonType(lessonType);

                lessons.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lessons;
    }

    public int getTotalLessonsForExpert(String subjectName, String lessonTypeName, String searchText, int expertId) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                        "WHERE s.owner_id = ?"
        );

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }


    public boolean changeLessonStatus(int id, int status) {
        String sql = "UPDATE [lessons] SET status = ? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return false;
    }
    public boolean updateLesson(int id, String name, String topic, String videoLink, int order, String content, int status, int subjectId, int lessonTypeId,Integer quizId) {
        String sql = "UPDATE [lessons] SET name = ?, topic = ?, [order] = ?, video_link = ?, content = ?, status = ?, subject_id = ?, lesson_type_id = ?, lesson_quiz_id=? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setString(2, topic);
            pstm.setInt(3, order);
            pstm.setString(4, videoLink);
            pstm.setString(5, content);
            pstm.setInt(6, status);
            pstm.setInt(7, subjectId);
            pstm.setInt(8, lessonTypeId);
            pstm.setInt(9, quizId);
            pstm.setInt(10, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error updating lesson: " + e.getMessage());
        }
        return false;
    }
    public boolean insertLesson(String name, String topic, String videoLink, int order, String content, int status, int subjectId, int lessonTypeId) {
        String sql = "INSERT INTO [lessons] (name, topic, [order], video_link, content, status, subject_id, lesson_type_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setString(2, topic);
            pstm.setInt(3, order);
            pstm.setString(4, videoLink);
            pstm.setString(5, content);
            pstm.setInt(6, status);
            pstm.setInt(7, subjectId);
            pstm.setInt(8, lessonTypeId);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error inserting lesson: " + e.getMessage());
        }
        return false;
    }
    public boolean insertLessonQuiz(String name, String topic, int order, String content, int status, int subjectId, int lessonTypeId, Integer quizId) {
        String sql = "INSERT INTO [lessons] (name, topic, [order], content, status, subject_id, lesson_type_id, lesson_quiz_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setString(2, topic);
            pstm.setInt(3, order);
            pstm.setString(4, content);
            pstm.setInt(5, status);
            pstm.setInt(6, subjectId);
            pstm.setInt(7, lessonTypeId);
            pstm.setInt(8, quizId);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error inserting lesson: " + e.getMessage());
        }
        return false;
    }
    public List<Lesson> getAllLessonsNameBySubject(int subjectId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = """
                SELECT id, name
                FROM lessons
                WHERE subject_id = ? And status = 1
                ORDER BY topic\s
                """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson l = new Lesson();
                l.setId(rs.getInt("id"));
                l.setName(rs.getString("name"));
                lessons.add(l);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }
}
