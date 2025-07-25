package dao;

import dal.DBContext;
import entity.Setting;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    public boolean isMandatorySetting(int id){
        String sql = """
                SELECT *
                FROM [system_settings]
                where [id] = ? and [mandatory] = 1
                """;
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return true;
            }
        }
        catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    // Thêm vào SettingDAO class

    /**
     * Check if a setting value is being used in related tables
     * @param settingId ID of the system setting
     * @return true if the setting value is being used, false otherwise
     */
    public boolean isSettingValueInUse(int settingId) {
        try {
            Setting setting = getSettingById(settingId);
            if (setting.getId() == 0) return false; // Setting not found

            String type = setting.getType();
            String value = setting.getValue();

            switch (type) {
                case "User Roles":
                    return isRoleInUse(value);
                case "Subject Categories":
                    return isSubjectCategoryInUse(value);
                case "Test Types":
                    return isTestTypeInUse(value);
                case "Question Levels":
                    return isQuestionLevelInUse(value);
                case "Lesson Types":
                    return isLessonTypeInUse(value);
                default:
                    return false;
            }
        } catch (Exception e) {
            System.out.println("Error checking setting usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a role is being used in users table
     */
    private boolean isRoleInUse(String roleName) {
        String sql = """
        SELECT 1 FROM [users] u 
        INNER JOIN [roles] r ON u.[role_id] = r.[id] 
        WHERE r.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, roleName);
            ResultSet rs = pstm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking role usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a subject category is being used in subjects table
     */
    private boolean isSubjectCategoryInUse(String categoryName) {
        String sql = """
        SELECT 1 FROM [subjects] s 
        INNER JOIN [subject_categories] sc ON s.[category_id] = sc.[id] 
        WHERE sc.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, categoryName);
            ResultSet rs = pstm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking subject category usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a test type is being used in quizzes table
     */
    private boolean isTestTypeInUse(String testTypeName) {
        String sql = """
        SELECT 1 FROM [quizzes] q 
        INNER JOIN [test_types] tt ON q.[test_type_id] = tt.[id] 
        WHERE tt.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, testTypeName);
            ResultSet rs = pstm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking test type usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a question level is being used in questions, quizzes, or practices tables
     */
    private boolean isQuestionLevelInUse(String questionLevelName) {
        // Check in questions table
        String sqlQuestions = """
        SELECT 1 FROM [questions] q 
        INNER JOIN [question_levels] ql ON q.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        // Check in quizzes table
        String sqlQuizzes = """
        SELECT 1 FROM [quizzes] q 
        INNER JOIN [question_levels] ql ON q.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        // Check in practices table
        String sqlPractices = """
        SELECT 1 FROM [practices] p 
        INNER JOIN [question_levels] ql ON p.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        try {
            // Check questions
            try (PreparedStatement pstm = connection.prepareStatement(sqlQuestions)) {
                pstm.setString(1, questionLevelName);
                ResultSet rs = pstm.executeQuery();
                if (rs.next()) return true;
            }

            // Check quizzes
            try (PreparedStatement pstm = connection.prepareStatement(sqlQuizzes)) {
                pstm.setString(1, questionLevelName);
                ResultSet rs = pstm.executeQuery();
                if (rs.next()) return true;
            }

            // Check practices
            try (PreparedStatement pstm = connection.prepareStatement(sqlPractices)) {
                pstm.setString(1, questionLevelName);
                ResultSet rs = pstm.executeQuery();
                if (rs.next()) return true;
            }

            return false;
        } catch (SQLException e) {
            System.out.println("Error checking question level usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a lesson type is being used in lessons table
     */
    private boolean isLessonTypeInUse(String lessonTypeName) {
        String sql = """
        SELECT 1 FROM [lessons] l 
        INNER JOIN [lesson_types] lt ON l.[lesson_type_id] = lt.[id] 
        WHERE lt.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, lessonTypeName);
            ResultSet rs = pstm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking lesson type usage: " + e.getMessage());
            return false;
        }
    }

    /**
     * Get detailed usage information for a setting
     * @param settingId ID of the system setting
     * @return String describing where the setting is being used
     */
    public String getSettingUsageDetails(int settingId) {
        try {
            Setting setting = getSettingById(settingId);
            if (setting.getId() == 0) return "Setting not found";

            String type = setting.getType();
            String value = setting.getValue();

            switch (type) {
                case "User Roles":
                    return getRoleUsageDetails(value);
                case "Subject Categories":
                    return getSubjectCategoryUsageDetails(value);
                case "Test Types":
                    return getTestTypeUsageDetails(value);
                case "Question Levels":
                    return getQuestionLevelUsageDetails(value);
                case "Lesson Types":
                    return getLessonTypeUsageDetails(value);
                default:
                    return "Unknown setting type";
            }
        } catch (Exception e) {
            System.out.println("Error getting setting usage details: " + e.getMessage());
            return "Error occurred while checking usage";
        }
    }

    private String getRoleUsageDetails(String roleName) {
        String sql = """
        SELECT COUNT(*) as count FROM [users] u 
        INNER JOIN [roles] r ON u.[role_id] = r.[id] 
        WHERE r.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, roleName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0 ? "Used by " + count + " user(s)" : "Not being used";
            }
        } catch (SQLException e) {
            System.out.println("Error getting role usage details: " + e.getMessage());
        }
        return "Unable to check usage";
    }

    private String getSubjectCategoryUsageDetails(String categoryName) {
        String sql = """
        SELECT COUNT(*) as count FROM [subjects] s 
        INNER JOIN [subject_categories] sc ON s.[category_id] = sc.[id] 
        WHERE sc.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, categoryName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0 ? "Used by " + count + " subject(s)" : "Not being used";
            }
        } catch (SQLException e) {
            System.out.println("Error getting subject category usage details: " + e.getMessage());
        }
        return "Unable to check usage";
    }

    private String getTestTypeUsageDetails(String testTypeName) {
        String sql = """
        SELECT COUNT(*) as count FROM [quizzes] q 
        INNER JOIN [test_types] tt ON q.[test_type_id] = tt.[id] 
        WHERE tt.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, testTypeName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0 ? "Used by " + count + " quiz(zes)" : "Not being used";
            }
        } catch (SQLException e) {
            System.out.println("Error getting test type usage details: " + e.getMessage());
        }
        return "Unable to check usage";
    }

    private String getQuestionLevelUsageDetails(String questionLevelName) {
        StringBuilder details = new StringBuilder();
        int totalUsage = 0;

        // Check questions
        String sqlQuestions = """
        SELECT COUNT(*) as count FROM [questions] q 
        INNER JOIN [question_levels] ql ON q.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sqlQuestions)) {
            pstm.setString(1, questionLevelName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
                    details.append(count).append(" question(s)");
                    totalUsage += count;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking questions: " + e.getMessage());
        }

        // Check quizzes
        String sqlQuizzes = """
        SELECT COUNT(*) as count FROM [quizzes] q 
        INNER JOIN [question_levels] ql ON q.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sqlQuizzes)) {
            pstm.setString(1, questionLevelName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
                    if (details.length() > 0) details.append(", ");
                    details.append(count).append(" quiz(zes)");
                    totalUsage += count;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking quizzes: " + e.getMessage());
        }

        // Check practices
        String sqlPractices = """
        SELECT COUNT(*) as count FROM [practices] p 
        INNER JOIN [question_levels] ql ON p.[question_level_id] = ql.[id] 
        WHERE ql.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sqlPractices)) {
            pstm.setString(1, questionLevelName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
                    if (details.length() > 0) details.append(", ");
                    details.append(count).append(" practice(s)");
                    totalUsage += count;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking practices: " + e.getMessage());
        }

        return totalUsage > 0 ? "Used by " + details.toString() : "Not being used";
    }

    private String getLessonTypeUsageDetails(String lessonTypeName) {
        String sql = """
        SELECT COUNT(*) as count FROM [lessons] l 
        INNER JOIN [lesson_types] lt ON l.[lesson_type_id] = lt.[id] 
        WHERE lt.[name] = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, lessonTypeName);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0 ? "Used by " + count + " lesson(s)" : "Not being used";
            }
        } catch (SQLException e) {
            System.out.println("Error getting lesson type usage details: " + e.getMessage());
        }
        return "Unable to check usage";
    }
}

