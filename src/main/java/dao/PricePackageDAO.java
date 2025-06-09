package dao;

import dal.DBContext;
import entity.PricePackage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PricePackageDAO extends DBContext {

    public PricePackage findById(int id) {
        String sql = "select * from [price_packages] where id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            try(ResultSet rs = pstm.executeQuery()) {
                if(rs.next()) {
                    PricePackage p = new PricePackage();
                    p.setId(id);
                    p.setSubjectId(rs.getInt("subject_id"));
                    return p;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
