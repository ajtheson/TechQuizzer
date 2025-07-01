package dao;

import dal.DBContext;
import entity.Subject;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SubjectDAO extends DBContext {
    public Subject getForRegister(int subjectId) {
        String sql = "select [name], [thumbnail] from [subjects] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                Subject subject = new Subject();
                subject.setName(rs.getString("name"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setId(subjectId);
                return subject;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public List<Subject> getAllSubjects(int owner_id) {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subjects WHERE status = 1 and owner_id=? ORDER BY name ASC ";
        try (
                PreparedStatement ps = connection.prepareStatement(sql);
             ) {
            ps.setInt(1, owner_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("tag_line"),
                        rs.getString("thumbnail"),
                        rs.getString("detail_description"),
                        rs.getBoolean("featured_subject"),
                        rs.getBoolean("status"),
                        rs.getInt("category_id"),
                        rs.getInt("owner_id"),
                        rs.getTimestamp("update_date").toLocalDateTime()
                );
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Subject findById(int id) {
        String sql = """
                    SELECT
                        [name],
                        [tag_line],
                        [thumbnail],
                        [detail_description],
                        [featured_subject],
                        [status],
                        [category_id],
                        [owner_id]
                    FROM [subjects]
                    WHERE [id] = ?
                """;
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                Subject subject = new Subject();
                subject.setId(id);
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setLongDescription(rs.getString("detail_description"));
                subject.setFeaturedSubject(rs.getBoolean("featured_subject"));
                subject.setPublished(rs.getBoolean("status"));
                subject.setCategoryId(rs.getInt("category_id"));
                subject.setOwnerId(rs.getInt("owner_id"));
                return subject;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Just get subjects is publish
    public List<Subject> getAllPublishSubjectsWithPagination(int page, int size, int categoryId, boolean isDesc, boolean isFeatured, String searchParam) {
        List<Subject> subjects = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                    SELECT [id], [name], [tag_line], [thumbnail], [featured_subject], [category_id], [update_date], [owner_id]
                    FROM [subjects]
                    WHERE [status] = 1
                """);
        if (categoryId != 0) {
            sql.append(" AND [category_id] = ?");
        }
        if (isFeatured) {
            sql.append(" AND [featured_subject] = 1");
        }
        if (searchParam != null && !searchParam.isBlank()) {
            sql.append(" AND [name] LIKE ?");
        }
        sql.append(" ORDER BY [update_date] ").append(isDesc ? "DESC" : "ASC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if (searchParam != null && !searchParam.isBlank()) {
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
                subject.setOwnerId(rs.getInt("owner_id"));
                subjects.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return subjects;
    }

    //Get all subject with all status, if admin the ownerId = 0
    public List<Subject> getAllSubjectsWithPagination(int page, int size, int categoryId, String searchParam, String status, int ownerId) {
        List<Subject> subjects = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                    SELECT [id], [name], [category_id], [status], [owner_id]
                    FROM [subjects]
                    WHERE 1 = 1
                """);
        if (categoryId != 0) {
            sql.append(" AND [category_id] = ?");
        }
        if (searchParam != null && !searchParam.isBlank()) {
            sql.append(" AND [name] LIKE ?");
        }
        if (!status.isBlank()) {
            if (status.equalsIgnoreCase("Published")) {
                sql.append(" AND [status] = 1");
            } else sql.append(" AND [status] = 0");
        }
        if (ownerId != 0) {
            sql.append(" AND [owner_id] = ?");
        }
        sql.append(" ORDER BY [id]");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if (searchParam != null && !searchParam.isBlank()) {
                pstm.setString(paramIndex++, "%" + searchParam + "%");
            }
            if (ownerId != 0) {
                pstm.setInt(paramIndex++, ownerId);
            }
            pstm.setInt(paramIndex++, (page - 1) * size);
            pstm.setInt(paramIndex++, size);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setName(rs.getString("name"));
                subject.setCategoryId(rs.getInt("category_id"));
                subject.setPublished(rs.getBoolean("status"));
                subject.setOwnerId(rs.getInt("owner_id"));
                subjects.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return subjects;
    }

    public List<Subject> findByIds(List<Integer> ids) {
        List<Subject> subjects = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return subjects;
        }
        String inClause = ids.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "SELECT " +
                "[id]," +
                "[name]," +
                "[tag_line]," +
                "[thumbnail]," +
                "[detail_description]," +
                "[featured_subject]," +
                "[status]," +
                "[category_id]," +
                "[owner_id]" +
                "FROM [subjects] WHERE id IN (" + inClause + ")";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            int index = 1;
            for (Integer id : ids) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setName(rs.getString("name"));
                subject.setTagLine(rs.getString("tag_line"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setLongDescription(rs.getString("detail_description"));
                subjects.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return subjects;
    }

    //Get total number of Publish subjects
    public int getTotalPublishSubjects(int categoryId, boolean isFeatured, String searchParam) {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) FROM subjects
                WHERE [status] = 1
                """);
        if (categoryId != 0) {
            sql.append(" AND [category_id] = ?");
        }
        if (isFeatured) {
            sql.append(" AND [featured_subject] = 1");
        }
        if (searchParam != null && !searchParam.isBlank()) {
            sql.append(" AND [name] LIKE ?");
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if (searchParam != null && !searchParam.isBlank()) {
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

    //Get total number of subjects
    public int getTotalSubjects(int categoryId, String searchParam, String status, int ownerId) {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) FROM subjects
                WHERE 1 = 1
                """);
        if (categoryId != 0) {
            sql.append(" AND [category_id] = ?");
        }
        if (searchParam != null && !searchParam.isBlank()) {
            sql.append(" AND [name] LIKE ?");
        }
        if (!status.isBlank()) {
            if (status.equalsIgnoreCase("Published")) {
                sql.append(" AND [status] = 1");
            } else sql.append(" AND [status] = 0");
        }
        if (ownerId != 0) {
            sql.append(" AND [owner_id] = ?");
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != 0) {
                pstm.setInt(paramIndex++, categoryId);
            }
            if (searchParam != null && !searchParam.isBlank()) {
                pstm.setString(paramIndex++, "%" + searchParam + "%");
            }
            if (ownerId != 0) {
                pstm.setInt(paramIndex++, ownerId);
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

    public Subject getSubjectById(int id) {
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
                subject.setLongDescription(rs.getString("detail_description"));
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

    public Subject getForUserRegistration(int subjectId) {
        String sql = "select [name], [thumbnail], [category_id] from [subjects] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                Subject subject = new Subject();
                subject.setName(rs.getString("name"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setCategoryId(rs.getInt("category_id"));
                return subject;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean updateSubjectName(int id, String name) {
        String sql = "UPDATE [subjects] SET [name] = ? WHERE [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating subject name: " + e.getMessage());
        }
        return false;
    }

    public boolean update(Subject subject) {
        String sql = """
                UPDATE [subjects]
                SET [name] = ?,[tag_line] = ?, [thumbnail] = ?, [detail_description] = ?, [featured_subject] = ?, [status] = ?, [category_id] = ?, [owner_id] = ?, [update_date] = ?
                WHERE [id] = ?
                """;
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, subject.getName());
            pstm.setString(2, subject.getTagLine());
            pstm.setString(3, subject.getThumbnail());
            pstm.setString(4, subject.getLongDescription());
            pstm.setBoolean(5, subject.isFeaturedSubject());
            pstm.setBoolean(6, subject.isPublished());
            pstm.setInt(7, subject.getCategoryId());
            pstm.setInt(8, subject.getOwnerId());
            pstm.setTimestamp(9, Timestamp.valueOf(subject.getUpdateDate()));
            pstm.setInt(10, subject.getId());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }

    public List<Subject> getAllSubjectsForQuestionList(int owner_id) {
        List<Subject> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [subjects] WHERE 1=1");
        if (owner_id != 0) {
            sql.append(" AND [owner_id] = ?");
        }
        sql.append(" ORDER BY name ASC");
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            if (owner_id != 0) {
                ps.setInt(1, owner_id);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new Subject(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("tag_line"),
                        rs.getString("thumbnail"),
                        rs.getString("detail_description"),
                        rs.getBoolean("featured_subject"),
                        rs.getBoolean("status"),
                        rs.getInt("category_id"),
                        rs.getInt("owner_id"),
                        rs.getTimestamp("update_date").toLocalDateTime()
                );
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int insertSubject(Subject subject) {
        String sql = "INSERT INTO subjects " +
                "(name, tag_line, thumbnail, detail_description, featured_subject, status, category_id, owner_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setString(1, subject.getName());
            pstm.setString(2, subject.getTagLine());
            pstm.setString(3, subject.getThumbnail());
            pstm.setString(4, subject.getLongDescription());
            pstm.setBoolean(5, subject.isFeaturedSubject());
            pstm.setBoolean(6, subject.isPublished());
            pstm.setInt(7, subject.getCategoryId());
            pstm.setInt(8, subject.getOwnerId());
            int affectedRows = pstm.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating subject failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating subject failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public Subject getLatestSubjectByNameAndOwner(String name, int ownerId) {
        String sql = "SELECT TOP 1 * FROM subjects WHERE name = ? AND owner_id = ? ORDER BY id DESC";

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, name);
            pstm.setInt(2, ownerId);

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    Subject subject = new Subject();
                    subject.setId(rs.getInt("id"));
                    subject.setName(rs.getString("name"));
                    subject.setTagLine(rs.getString("tag_line"));
                    subject.setThumbnail(rs.getString("thumbnail"));
                    subject.setLongDescription(rs.getString("detail_description"));
                    subject.setFeaturedSubject(rs.getBoolean("featured_subject"));
                    subject.setPublished(rs.getBoolean("status"));
                    subject.setCategoryId(rs.getObject("category_id") != null ? rs.getInt("category_id") : null);
                    subject.setOwnerId(rs.getInt("owner_id"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

}
