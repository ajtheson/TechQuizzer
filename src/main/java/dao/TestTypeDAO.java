package dao;

import dal.DBContext;
import entity.TestType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestTypeDAO extends DBContext {

    public TestType findByName(String name) throws SQLException {
        String sql = """
                SELECT 
                    [id],
                    [name]
                FROM [test_types]
                WHERE [name] = ?
                """;
        try{
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, name);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                TestType testType = new TestType();
                testType.setId(rs.getInt("id"));
                testType.setName(rs.getString("name"));
                return testType;
            }
        } catch (Exception e) {
            e. printStackTrace();
        }
        finally {
            connection.close();
        }
        return null;
    }

}
