package dao;

import dal.DBContext;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO extends DBContext {
    public List<Subject> getAllSubjectsWithPagination(int page, int size, int categoryId, boolean isDesc, boolean isFeatured, String searchParam) {
        List<Subject> subjects = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                    SELECT [id], [name], [tag_line], [thumbnail], [featured_subject], [category_id], [update_date]
                    FROM [subjects]
                    WHERE [status] = 1
                """);
        if(categoryId != 0){
            sql.append(" AND [category_id] = ?");
        }
        if(isFeatured){
            sql.append(" AND [featured_subject] = 1");
        }
        if(searchParam != null && !searchParam.isBlank()){
            sql.append(" AND [name] LIKE ?");
        }
        sql.append(" ORDER BY [update_date] ").append(isDesc ? "DESC" : "ASC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if(searchParam != null && !searchParam.isBlank()){
                pstm.setString(paramIndex++, "%" + searchParam + "%");
            }
            pstm.setInt(paramIndex++, (page - 1) * size);
            pstm.setInt(paramIndex++, size);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subjects.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return subjects;
    }

    public int getTotalSubjects(int categoryId, boolean isFeatured, String searchParam) {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) FROM subjects
                WHERE [status] = 1
                """) ;
        if(categoryId != 0){
            sql.append(" AND [category_id] = ?");
        }
        if(isFeatured){
            sql.append(" AND [featured_subject] = 1");
        }
        if(searchParam != null && !searchParam.isBlank()){
            sql.append(" AND [name] LIKE ?");
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if(searchParam != null && !searchParam.isBlank()){
                pstm.setString(paramIndex++, "%" + searchParam + "%");
            }
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return 0;
    }
    
    public Subject getSubjectById(int id){
        Subject subject = new Subject();
        String sql = "Select * from [subjects] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                subject.setId(rs.getInt("id"));
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setShortDescription(rs.getString("short_description"));
                subject.setLongDescription(rs.getString("detail_description").replace("\\n", "<br>"));
                subject.setFeaturedSubject(rs.getBoolean("featured_subject"));
                subject.setPublished(rs.getBoolean("status"));
                subject.setCategoryId(rs.getInt("category_id"));
                subject.setOwnerId(rs.getInt("owner_id"));
                subject.setUpdateDate(rs.getTimestamp("update_date").toLocalDateTime());
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return subject;
    }

    public Subject getForUserRegistration(int subjectId){
        String sql = "select [name], [thumbnail], [category_id] from [subjects] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                Subject subject = new Subject();
                subject.setName(rs.getString("name"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setCategoryId(rs.getInt("category_id"));
                return subject;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
}
