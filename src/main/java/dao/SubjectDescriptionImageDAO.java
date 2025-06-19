package dao;

import dal.DBContext;
import entity.SubjectDescriptionImage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDescriptionImageDAO extends DBContext {
    public List<SubjectDescriptionImage> getAllImageBySubjectId(int subjectId){
        List<SubjectDescriptionImage> list = new ArrayList<>();
        String sql = "select [id], [url], [caption] from [subject_description_images] where [subject_id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                SubjectDescriptionImage image = new SubjectDescriptionImage();
                image.setSubjectId(subjectId);
                image.setId(rs.getInt("id"));
                image.setUrl(rs.getString("url"));
                image.setCaption(rs.getString("caption"));
                list.add(image);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public SubjectDescriptionImage getById(int id){
        String sql = "Select * from [subject_description_images] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                SubjectDescriptionImage image = new SubjectDescriptionImage();
                image.setSubjectId(rs.getInt("subject_id"));
                image.setId(rs.getInt("id"));
                image.setUrl(rs.getString("url"));
                image.setCaption(rs.getString("caption"));
                return image;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean add(SubjectDescriptionImage sdi){
        String sql = "insert into [subject_description_images] ([subject_id], [url], [caption]) values (?, ?, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, sdi.getSubjectId());
            pstm.setString(2, sdi.getUrl());
            pstm.setString(3, sdi.getCaption());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean delete(int id){
        String sql = "delete from [subject_description_images] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }

    public boolean update(SubjectDescriptionImage sdi){
        String sql = "UPDATE [subject_description_images] SET [url] = ?, [caption] = ? WHERE [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, sdi.getUrl());
            pstm.setString(2, sdi.getCaption());
            pstm.setInt(3, sdi.getId());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }
}
