package dao;

import dal.DBContext;
import entity.Dimension;
import entity.Lesson;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class DimensionDAO extends DBContext {
    public Dimension findById(int id) {
        String sql = "select [id], [name], [subject_id] from [dimensions] where id = ? and status = 1";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                Dimension dimension = new Dimension();
                dimension.setId(rs.getInt("id"));
                dimension.setName(rs.getString("name"));
                dimension.setSubjectId(rs.getInt("subject_id"));
                return dimension;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Dimension> findAllBySubjectIds(List<Integer> subjectIds) {
        List<Dimension> dimensions = new ArrayList<>();
        if(subjectIds == null || subjectIds.isEmpty()){
            return dimensions;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT [id], [name], [subject_id] FROM [dimensions] where status = 1 AND [subject_id] in (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : subjectIds){
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Dimension dimension = new Dimension();
                dimension.setId(rs.getInt("id"));
                dimension.setName(rs.getString("name"));
                dimension.setSubjectId(rs.getInt("subject_id"));
                dimensions.add(dimension);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dimensions;
    }

    public List<Dimension> selectAllDimension(int subjectID) {
        List<Dimension> list = new ArrayList<Dimension>();
        String sql = "SELECT dimensions.id, type, dimensions.name, description, subject_id FROM dimensions join [subjects] on dimensions.[subject_id]=subjects.id where subjects.id =?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, subjectID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Dimension d = new Dimension(
                        rs.getInt("id"),
                        rs.getString("type"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("subject_id")
                );
                list.add(d);
                    }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
