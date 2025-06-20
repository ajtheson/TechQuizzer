package dao;

import dal.DBContext;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SubjectDAO extends DBContext {

    public Subject findById(int id) {
        String sql = """
                    SELECT
                        [name],
                        [tag_line],
                        [thumbnail],
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

}
