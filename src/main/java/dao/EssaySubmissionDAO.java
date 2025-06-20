package dao;

import dal.DBContext;
import entity.EssaySubmission;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class EssaySubmissionDAO extends DBContext {

    public List<EssaySubmission> findAllByEssayAttemptIds(List<Integer> essayAttemptIds) {
        List<EssaySubmission> essaySubmissions = new ArrayList<>();
        if (essayAttemptIds == null || essayAttemptIds.isEmpty()) {
            return essaySubmissions;
        }
        String inClause = essayAttemptIds.stream().map(e -> "?").collect(Collectors.joining(", "));
        String sql = "select [id], [fileName], [essay_attempt_id] from [essay_submissions] where [essay_attempt_id] in (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : essayAttemptIds) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                EssaySubmission essaySubmission = new EssaySubmission();
                essaySubmission.setId(rs.getInt("id"));
                essaySubmission.setEssayAttemptId(rs.getInt("essay_attempt_id"));
                essaySubmission.setFileName(rs.getString("fileName"));
                essaySubmissions.add(essaySubmission);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return essaySubmissions;
    }

    public boolean insert(List<EssaySubmission> essaySubmissions) {
        String sql = "insert into [essay_submissions] ([fileName], [essay_attempt_id]) values (?, ?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            for(EssaySubmission essaySubmission : essaySubmissions) {
                pstm.setString(1, essaySubmission.getFileName());
                pstm.setInt(2, essaySubmission.getEssayAttemptId());
                pstm.addBatch();
            }
            pstm.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
