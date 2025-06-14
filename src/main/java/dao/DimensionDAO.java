package dao;

import dal.DBContext;
import entity.Dimension;
import entity.Lesson;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DimensionDAO extends DBContext {
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
