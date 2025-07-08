package dao;

import dal.DBContext;
import entity.LessonType;
import entity.QuestionLevel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class LessonTypeDAO extends DBContext {
    public List<LessonType> findByIds(List<Integer> ids) {
            List<LessonType> list = new ArrayList<>();
            if (ids == null || ids.isEmpty()) return list;

            String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
            String sql = "SELECT * FROM lesson_types WHERE id IN (" + placeholders + ")";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                for (int i = 0; i < ids.size(); i++) {
                    ps.setInt(i + 1, ids.get(i));
                }

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    LessonType lessonType = new LessonType();
                    lessonType.setId(rs.getInt("id"));
                    lessonType.setName(rs.getString("name"));
                    list.add(lessonType);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return list;
    }
    public LessonType findById(int id) {
        String sql = "SELECT * FROM lesson_types WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LessonType lessonType = new LessonType();
                lessonType.setId(rs.getInt("id"));
                lessonType.setName(rs.getString("name"));
                return lessonType;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<LessonType> getAllLessonTypes() {
        List<LessonType> list = new ArrayList<>();
        String sql = "SELECT * FROM lesson_types ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LessonType lessonType = new LessonType();
                lessonType.setId(rs.getInt("id"));
                lessonType.setName(rs.getString("name"));
                list.add(lessonType);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
