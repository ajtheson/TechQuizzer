package dao;

import dal.DBContext;
import entity.PricePackage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class PricePackageDAO extends DBContext {
    public List<PricePackage> getOfSubject(int subjectID){
        String sql = "select * from [price_packages] where [subject_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            List<PricePackage> list = new ArrayList<>();
            pstm.setInt(1, subjectID);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                PricePackage p = new PricePackage();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDuration(rs.getObject("duration", Integer.class));
                p.setListPrice(rs.getDouble("list_price"));
                p.setSalePrice(rs.getDouble("sale_price"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getBoolean("status"));
                p.setSubjectId(subjectID);
                list.add(p);
            }
            return list;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean updateStatus(int id, boolean status){
        String sql = "update [price_packages] set [status] = ? where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, status ? 1 : 0);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public int getSubjectId(int id){
        String sql = "select [subject_id] from [price_packages] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getInt("subject_id");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public boolean checkNameExist(String name, int subjectID){
        String sql = "select 1 from [price_packages] where [name] = ? and [subject_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, name);
            pstm.setInt(2, subjectID);
            if(pstm.executeQuery().next()){
                return true;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean checkNameExist(String name, int subjectID, int id){
        String sql = "select 1 from [price_packages] where [name] = ? and [subject_id] = ? and [id] != ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, name);
            pstm.setInt(2, subjectID);
            pstm.setInt(3, id);
            if(pstm.executeQuery().next()){
                return true;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean add(PricePackage p){
        String sql = "insert into [price_packages] ([name], [duration], [list_price], [sale_price], \n" +
                "    [description], [status], [subject_id]) values (?, ?, ?, ?, ?, ?, ?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, p.getName());
            pstm.setObject(2, p.getDuration(), Types.INTEGER);
            pstm.setDouble(3, p.getListPrice());
            pstm.setDouble(4, p.getSalePrice());
            pstm.setString(5, p.getDescription());
            pstm.setBoolean(6, p.isStatus());
            pstm.setInt(7, p.getSubjectId());
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public PricePackage get(int id){
        String sql = "select * from [price_packages] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                PricePackage p = new PricePackage();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDuration(rs.getObject("duration", Integer.class));
                p.setListPrice(rs.getDouble("list_price"));
                p.setSalePrice(rs.getDouble("sale_price"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getBoolean("status"));
                p.setSubjectId(rs.getInt("subject_id"));
                return p;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean update(PricePackage p){
        String sql = "UPDATE [price_packages] SET [name] = ?, [duration] = ?, [list_price] = ?, " +
                "[sale_price] = ?, [description] = ?, [status] = ?, [subject_id] = ? " +
                "WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, p.getName());
            pstm.setObject(2, p.getDuration(), Types.INTEGER);
            pstm.setDouble(3, p.getListPrice());
            pstm.setDouble(4, p.getSalePrice());
            pstm.setString(5, p.getDescription());
            pstm.setBoolean(6, p.isStatus());
            pstm.setInt(7, p.getSubjectId());
            pstm.setInt(8, p.getId());
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
    public static void main(String[] args) {
        PricePackageDAO dao = new PricePackageDAO();
        System.out.println(dao.get(1));
    }
}
