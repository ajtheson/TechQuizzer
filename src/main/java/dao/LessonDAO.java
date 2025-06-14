package dao;

import dal.DBContext;
import entity.Lesson;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
