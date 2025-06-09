package dao;

import dal.DBContext;
import entity.Quiz;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class QuizDAO extends DBContext {

    public Quiz findById(int id) {
        String sql = "SELECT [name], [level], [duration], [pass_rate], [description], [test_type_id], [quiz_setting_id], [subject_id] FROM [quizzes] WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    Quiz quiz = new Quiz();
                    quiz.setId(id);
                    quiz.setName(rs.getString("name"));
                    quiz.setLevel(rs.getString("level"));
                    quiz.setDuration(rs.getInt("duration"));
                    quiz.setPassRate(rs.getInt("pass_rate"));
                    quiz.setDescription(rs.getString("description"));
                    quiz.setTestTypeId(rs.getInt("test_type_id"));
                    quiz.setQuizSettingId(rs.getInt("quiz_setting_id"));
                    quiz.setSubjectId(rs.getInt("subject_id"));
                    return quiz;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Quiz> findAllByTestTypeIdAndSubjectIdsWithPagination(int testTypeId, List<Integer> subjectIds, int page, int size, String search) throws SQLException {
        ArrayList<Quiz> quizzes = new ArrayList<>();

        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT [id], [name], [level], [duration], [pass_rate], [description], [test_type_id], [quiz_setting_id], [subject_id] "
                + "FROM [quizzes] "
                + "WHERE [test_type_id] = ? AND [subject_id] IN (" + inClause + ") AND [name] LIKE ? "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            pstm.setInt(index++, testTypeId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            pstm.setString(index++, "%" + search + "%");
            pstm.setInt(index++, (page - 1) * size);
            pstm.setInt(index, size);

            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setName(rs.getString("name"));
                quiz.setLevel(rs.getString("level"));
                quiz.setDuration(rs.getInt("duration"));
                quiz.setPassRate(rs.getInt("pass_rate"));
                quiz.setDescription(rs.getString("description"));
                quiz.setTestTypeId(rs.getInt("test_type_id"));
                quiz.setQuizSettingId(rs.getInt("quiz_setting_id"));
                quiz.setSubjectId(rs.getInt("subject_id"));
                quizzes.add(quiz);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return quizzes;
    }

    public int countByTestTypeIdAndSubjectIds(int testTypeId, List<Integer> subjectIds) throws SQLException {
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT COUNT(*) FROM [quizzes] WHERE [test_type_id] = ? AND [subject_id] IN (" + inClause + ")";
        try{
            PreparedStatement pstm = connection.prepareStatement(sql);
            int index = 1;
            pstm.setInt(index++, testTypeId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            rs.next();
            return rs.getInt(1);
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

}
