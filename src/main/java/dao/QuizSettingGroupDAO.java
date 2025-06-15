package dao;

import dal.DBContext;
import entity.QuizSettingGroup;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizSettingGroupDAO extends DBContext {
    public void deleteByQuizSettingIdAndType(int quizSettingId, String type) {
        String sql;

        if ("lesson".equals(type)) {
            sql = """
            DELETE FROM quiz_setting_groups 
            WHERE quiz_setting_id = ? AND subject_lesson_id IS NOT NULL
            """;
        } else {
            sql = """
            DELETE FROM quiz_setting_groups 
            WHERE quiz_setting_id = ? AND subject_dimension_id IS NOT NULL
            """;
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizSettingId);
            pstm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error deleteByQuizSettingIdAndType: " + e.getMessage());
        }
    }

    public void insertQuizSettingGroup(QuizSettingGroup group) {
        String sql = """
        INSERT INTO quiz_setting_groups 
        (number_question, subject_lesson_id, subject_dimension_id, quiz_setting_id) 
        VALUES (?, ?, ?, ?)
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, group.getNumberQuestion());

            if (group.getSubjectLessonId() != null) {
                pstm.setInt(2, group.getSubjectLessonId());
            } else {
                pstm.setNull(2, java.sql.Types.INTEGER);
            }

            if (group.getSubjectDimensionId() != null) {
                pstm.setInt(3, group.getSubjectDimensionId());
            } else {
                pstm.setNull(3, java.sql.Types.INTEGER);
            }

            pstm.setInt(4, group.getQuizSettingId());
            pstm.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error insertQuizSettingGroup: " + e.getMessage());
        }
    }


    public void updateQuizSettingGroup(QuizSettingGroup group) {
        String sql = """
        UPDATE quiz_setting_groups 
        SET number_question = ?, subject_lesson_id = ?, subject_dimension_id = ?
        WHERE id = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, group.getNumberQuestion());

            if (group.getSubjectLessonId() != null) {
                pstm.setInt(2, group.getSubjectLessonId());
            } else {
                pstm.setNull(2, java.sql.Types.INTEGER);
            }

            if (group.getSubjectDimensionId() != null) {
                pstm.setInt(3, group.getSubjectDimensionId());
            } else {
                pstm.setNull(3, java.sql.Types.INTEGER);
            }

            pstm.setInt(4, group.getId());
            pstm.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error updateQuizSettingGroup: " + e.getMessage());
        }
    }
    public boolean deleteByQuizSettingIdAndLessonId(int quizSettingId, int lessonId) {
        String sql = "DELETE FROM quiz_setting_group WHERE quiz_setting_id = ? AND subject_lesson_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, quizSettingId);
            ps.setInt(2, lessonId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting quiz setting group by lesson ID: " + e.getMessage());
            return false;
        }
    }


    public boolean deleteByQuizSettingIdAndDimensionId(int quizSettingId, int dimensionId) {
        String sql = "DELETE FROM quiz_setting_group WHERE quiz_setting_id = ? AND subject_dimension_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, quizSettingId);
            ps.setInt(2, dimensionId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting quiz setting group by dimension ID: " + e.getMessage());
            return false;
        }
    }

    public List<QuizSettingGroup> getByQuizSettingIdAndType(int quizSettingId, String type) {
        List<QuizSettingGroup> groups = new ArrayList<>();
        String sql;

        if ("lesson".equals(type)) {
            sql = "SELECT * FROM quiz_setting_group WHERE quiz_setting_id = ? AND subject_lesson_id IS NOT NULL";
        } else if ("dimension".equals(type)) {
            sql = "SELECT * FROM quiz_setting_group WHERE quiz_setting_id = ? AND subject_dimension_id IS NOT NULL";
        } else {
            return groups; // Return empty list for invalid type
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, quizSettingId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    QuizSettingGroup group = new QuizSettingGroup();
                    group.setId(rs.getInt("id"));
                    group.setQuizSettingId(rs.getInt("quiz_setting_id"));
                    group.setNumberQuestion(rs.getInt("number_question"));

                    // Set lesson or dimension ID based on type
                    if ("lesson".equals(type)) {
                        group.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                    } else {
                        group.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                    }

                    groups.add(group);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting quiz setting groups by type: " + e.getMessage());
        }

        return groups;
    }

    public boolean createQuizSettingGroup(QuizSettingGroup group) throws SQLException {
        String sql = "INSERT INTO [quiz_setting_groups] ([number_question], [subject_lesson_id], " +
                "[subject_dimension_id], [quiz_setting_id]) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {

            ps.setInt(1, group.getNumberQuestion());

            if (group.getSubjectLessonId() != null) {
                ps.setInt(2, group.getSubjectLessonId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            if (group.getSubjectDimensionId() != null) {
                ps.setInt(3, group.getSubjectDimensionId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }

            ps.setInt(4, group.getQuizSettingId());

            return ps.executeUpdate() > 0;


        }catch(Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
}
