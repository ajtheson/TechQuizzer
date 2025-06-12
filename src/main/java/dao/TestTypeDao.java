package dao;

import dal.DBContext;
import entity.TestType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TestTypeDao extends DBContext {
    public ArrayList<TestType> getAllTestTypes() {
        ArrayList<TestType> list = new ArrayList<>();
        String sql = "select * from test_types";

        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TestType t = new TestType(rs.getInt("id"), rs.getString("name"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public TestType findById(int id) {
        String sql = "SELECT * FROM test_types WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new TestType(rs.getInt("id"), rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<TestType> findByIds(List<Integer> ids) {
        List<TestType> list = new ArrayList<>();
        if (ids == null || ids.isEmpty()) return list;

        String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
        String sql = "SELECT * FROM test_types WHERE id IN (" + placeholders + ")";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TestType(rs.getInt("id"), rs.getString("name")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
