package entity;

public class EssaySubmission {

    private int id;
    private String fileName;
    private int essayAttemptId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getEssayAttemptId() {
        return essayAttemptId;
    }

    public void setEssayAttemptId(int essayAttemptId) {
        this.essayAttemptId = essayAttemptId;
    }
}
