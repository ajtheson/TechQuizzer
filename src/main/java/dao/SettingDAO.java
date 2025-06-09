package dao;

import dal.DBContext;
import entity.Setting;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SettingDAO extends DBContext {

    public ArrayList<Setting> getAllSettings() {
        ArrayList<Setting> settings = new ArrayList<>();
        String sql = "select * from [system_settings] order by [type] desc, [order]";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                settings.add(new Setting(rs.getInt("id"),
                        rs.getString("type"),
                        rs.getString("value"),
                        rs.getString("description"),
                        rs.getInt("order"),
                        rs.getBoolean("status")
                ));
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return settings;
    }

    public Setting getSettingById(int id) {
        Setting setting = new Setting();
        String sql = "select * from [system_settings] where [id] = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                setting = new Setting(rs.getInt("id"),
                        rs.getString("type"),
                        rs.getString("value"),
                        rs.getString("description"),
                        rs.getInt("order"),
                        rs.getBoolean("status")
                );
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return setting;
    }

    public boolean add(Setting setting){
        int result = 0;
        String sql = "INSERT INTO [system_settings] ([type], [value], [description], [order], [status])\n" +
                "VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, setting.getType());
            pstm.setString(2, setting.getValue());
            pstm.setString(3, setting.getDescription());
            pstm.setInt(4, setting.getOrder());
            pstm.setInt(5, setting.isActivated() ? 1 : 0);
            result = pstm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return result > 0;
    }

    public boolean update(Setting setting){
        int result = 0;
        String sql = "UPDATE [system_settings]\n" +
                "SET [type] = ?, [value] = ?, [description] = ?, [order] = ?, [status] = ?\n" +
                "WHERE [id] = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, setting.getType());
            pstm.setString(2, setting.getValue());
            pstm.setString(3, setting.getDescription());
            pstm.setInt(4, setting.getOrder());
            pstm.setInt(5, setting.isActivated() ? 1 : 0);
            pstm.setInt(6, setting.getId());
            result = pstm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return result > 0;
    }

    public boolean checkValueExist(String value, String type){
        String sql = "select 1 from [system_settings] where [value] = ? and [type] = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, value);
            pstm.setString(2, type);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean checkValueExist(String value, String type, int id){
        String sql = "select 1 from [system_settings] where [value] = ? and [type] = ? and [id] != ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, value);
            pstm.setString(2, type);
            pstm.setInt(3, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateStatus(int id, boolean status){
        String sql = "UPDATE [system_settings]\n" +
                "SET [status] = ?\n" +
                "WHERE [id] = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, status ? 1 : 0);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {}
        return false;
    }
}
