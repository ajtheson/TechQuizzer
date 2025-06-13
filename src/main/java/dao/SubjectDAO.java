package dao;

import dal.DBContext;
import entity.Quiz;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SubjectDAO extends DBContext {
    public List<Subject> getAllSubjects(int owner_id) {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subjects WHERE status = 1 and owner_id=? ORDER BY name ASC ";

        try (
                PreparedStatement ps = connection.prepareStatement(sql);
             ) {
            ps.setInt(1, owner_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subject s = new Subject(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("tag_line"),
                        rs.getString("thumbnail"),
                        rs.getString("short_description"),
                        rs.getString("detail_description"),
                        rs.getBoolean("featured_subject"),
                        rs.getBoolean("status"),
                        rs.getInt("category_id"),
                        rs.getInt("owner_id"),
                        rs.getTimestamp("update_date")
                );
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public Subject findById(int id) {
        String sql = """
                    SELECT
                        [name],
                        [tag_line],
                        [thumbnail],
                        [short_description],
                        [detail_description],
                        [featured_subject],
                        [status],
                        [category_id],
                        [owner_id]
                    FROM [subjects]
                    WHERE [id] = ?
                """;
        try{
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()) {
                Subject subject = new Subject();
                subject.setId(id);
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setShortDescription(rs.getString("short_description"));
                subject.setLongDescription(rs.getString("detail_description"));
                subject.setFeaturedSubject(rs.getBoolean("featured_subject"));
                subject.setPublished(rs.getBoolean("status"));
                subject.setCategoryId(rs.getInt("category_id"));
                subject.setOwnerId(rs.getInt("owner_id"));
                return subject;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Subject> findByIds(List<Integer> ids) {
        List<Subject> subjects = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return subjects;
        }
        String inClause = ids.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql =
                "SELECT " +
                        "[id]," +
                        "[name]," +
                        "[tag_line]," +
                        "[thumbnail]," +
                        "[short_description]," +
                        "[detail_description]," +
                        "[featured_subject]," +
                        "[status]," +
                        "[category_id]," +
                        "[owner_id]" +
                        "FROM [subjects] WHERE id IN (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : ids) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while(rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setShortDescription(rs.getString("short_description"));
                subject.setLongDescription(rs.getString("detail_description"));
                subject.setFeaturedSubject(rs.getBoolean("featured_subject"));
                subject.setPublished(rs.getBoolean("status"));
                subject.setCategoryId(rs.getInt("category_id"));
                subject.setOwnerId(rs.getInt("owner_id"));
                subjects.add(subject);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return subjects;
    }
    public boolean updateSubjectName(int id, String name) {
        String sql = "UPDATE [subjects] SET [name] = ? WHERE [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating subject name: " + e.getMessage());
        }
        return false;
    }

}
