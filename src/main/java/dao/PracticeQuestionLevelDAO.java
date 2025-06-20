package dao;

import dal.DBContext;
import dto.PracticeQuestionLevelDTO;
import entity.QuestionLevel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PracticeQuestionLevelDAO extends DBContext {

    public boolean insertByPracticeIdAndQuestionLevelIds(int practiceId, List<Integer> questionLevelIds) {
        String sql = "insert into [practice_question_levels] ([practice_id], [question_level_id]) values (?, ?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)) {
            for (int questionLevelId : questionLevelIds) {
                pstm.setInt(1, practiceId);
                pstm.setInt(2, questionLevelId);
                pstm.addBatch();
            }
            pstm.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public List<PracticeQuestionLevelDTO> findAllByPracticeId(int practiceId){
        List<PracticeQuestionLevelDTO> practiceQuestionLevelDTOs = new ArrayList<>();
        String sql = "select * from [practice_question_levels] p " +
                "join [question_levels] q on q.id = p.question_level_id " +
                "where p.practice_id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, practiceId);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                PracticeQuestionLevelDTO practiceQuestionLevelDTO = new PracticeQuestionLevelDTO();
                practiceQuestionLevelDTO.setId(rs.getInt("id"));

                QuestionLevel questionLevel = new QuestionLevel();
                questionLevel.setId(rs.getInt("question_level_id"));
                questionLevel.setName(rs.getString("name"));
                practiceQuestionLevelDTO.setQuestionLevel(questionLevel);

                practiceQuestionLevelDTOs.add(practiceQuestionLevelDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return practiceQuestionLevelDTOs;
    }

    public List<PracticeQuestionLevelDTO> findAllByPracticeIds(List<Integer> practiceIds){
        List<PracticeQuestionLevelDTO> practiceQuestionLevelDTOs = new ArrayList<>();
        if(practiceIds == null || practiceIds.isEmpty()){
            return practiceQuestionLevelDTOs;
        }
        String inClause = practiceIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT p.[id], [practice_id], [question_level_id], [name] FROM [practice_question_levels] p " +
                "JOIN [question_levels] q ON q.id = p.question_level_id " +
                "WHERE p.practice_id IN (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : practiceIds){
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                PracticeQuestionLevelDTO practiceQuestionLevel = new PracticeQuestionLevelDTO();
                practiceQuestionLevel.setId(rs.getInt("id"));
                QuestionLevel questionLevel = new QuestionLevel();
                questionLevel.setId(rs.getInt("question_level_id"));
                questionLevel.setName(rs.getString("name"));
                practiceQuestionLevel.setQuestionLevel(questionLevel);
                practiceQuestionLevel.setPracticeId(rs.getInt("practice_id"));
                practiceQuestionLevelDTOs.add(practiceQuestionLevel);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return practiceQuestionLevelDTOs;
    }

}
