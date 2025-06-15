package dao;

import dal.DBContext;
import entity.Lesson;
import entity.QuestionLevel;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

public class LessonDAO extends DBContext {
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
}
