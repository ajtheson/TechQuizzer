package dao;

import dal.DBContext;
import dto.DimensionDTO;
import dto.SubjectDTO;
import entity.Dimension;
import entity.Lesson;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class DimensionDAO extends DBContext {
    public Dimension findById(int id) {
        String sql = "select [id], [name], [subject_id] from [dimensions] where id = ?";
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
        String sql = "SELECT [id], [name], [subject_id] FROM [dimensions] where [subject_id] in (" + inClause + ")";
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

    public DimensionDTO getDimensionDTOById(int dimensionId) {
        DimensionDTO dimension = null;

        String sql = "SELECT d.id, d.name, d.type, d.description, " +
                "s.id AS subject_id, s.name AS subject_name, u.name AS owner_name " +
                "FROM dimensions d " +
                "LEFT JOIN subjects s ON d.subject_id = s.id " +
                "LEFT JOIN users u ON s.owner_id = u.id " +
                "WHERE d.id = ?";

        try (PreparedStatement pstm = connection.prepareStatement(sql);) {

            pstm.setInt(1, dimensionId);

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    dimension = new DimensionDTO();
                    dimension.setId(rs.getInt("id"));
                    dimension.setName(rs.getString("name"));
                    dimension.setType(rs.getString("type"));
                    dimension.setDescription(rs.getString("description"));

                    // SubjectDTO
                    SubjectDTO subjectDTO = new SubjectDTO();
                    subjectDTO.setId(rs.getInt("subject_id"));
                    subjectDTO.setName(rs.getString("subject_name"));
                    subjectDTO.setOwnerName(rs.getString("owner_name"));

                    dimension.setSubjectDTO(subjectDTO);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dimension;
    }
    public boolean updateDimension(int id, String name, String type, String description, int subjectId) {
        String sql = "UPDATE dimensions SET name = ?, type = ?, description = ?, subject_id = ? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setString(2, type);
            pstm.setString(3, description);
            pstm.setInt(4, subjectId);
            pstm.setInt(5, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error updating dimension: " + e.getMessage());
        }
        return false;
    }
    public boolean insertDimension(String name, String type, String description, int subjectId) {
        String sql = "INSERT INTO dimensions (name, type, description, subject_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setString(2, type);
            pstm.setString(3, description);
            pstm.setInt(4, subjectId);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error inserting dimension: " + e.getMessage());
        }
        return false;
    }
    public List<DimensionDTO> getDimensionByPage(int subjectId, String searchText, int page, int pageSize, String sortField, String sortOrder) {
        List<DimensionDTO> dimensions = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT d.id, d.name, d.type, d.description, d.status, " +
                        "s.id AS subject_id, s.name AS subject_name, s.owner_id, u.name AS owner_name " +
                        "FROM dimensions d " +
                        "JOIN subjects s ON d.subject_id = s.id " +
                        "LEFT JOIN users u ON s.owner_id = u.id " +
                        "WHERE s.id = ?"
        );

        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND d.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("d.id", "d.name", "d.type", "d.description", "s.name");
        if (!validSortFields.contains(sortField)) sortField = "d.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC")) sortOrder = "ASC";

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, subjectId);
            if (searchText != null && !searchText.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchText + "%");
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DimensionDTO dto = new DimensionDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setType(rs.getString("type"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getBoolean("status"));

                SubjectDTO subjectDTO = new SubjectDTO();
                subjectDTO.setId(rs.getInt("subject_id"));
                subjectDTO.setName(rs.getString("subject_name"));
                subjectDTO.setOwnerName(rs.getString("owner_name"));

                dto.setSubjectDTO(subjectDTO);
                dimensions.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dimensions;
    }

    public int getTotalDimensionCount(int subjectId, String searchText) {
        int count = 0;

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                        "FROM dimensions d " +
                        "JOIN subjects s ON d.subject_id = s.id " +
                        "WHERE s.id = ?"
        );

        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND d.name LIKE ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, subjectId);
            if (searchText != null && !searchText.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchText + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
    public boolean toggleStatus(int id, int status) {
        String sql = "UPDATE dimensions SET status = ? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error toggling status: " + e.getMessage());
        }
        return false;
    }


}
