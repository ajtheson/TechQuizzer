package entity;

public class QuizSettingGroup {
    private int id;
    private int numberQuestion;
    private Integer subjectLessonId;        // có thể null -> dùng Integer
    private Integer subjectDimensionId;     // có thể null -> dùng Integer
    private int quizSettingId;

    // Constructor mặc định
    public QuizSettingGroup() {
    }

    // Constructor đầy đủ
    public QuizSettingGroup(int id, int numberQuestion, Integer subjectLessonId, Integer subjectDimensionId, int quizSettingId) {
        this.id = id;
        this.numberQuestion = numberQuestion;
        this.subjectLessonId = subjectLessonId;
        this.subjectDimensionId = subjectDimensionId;
        this.quizSettingId = quizSettingId;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumberQuestion() {
        return numberQuestion;
    }

    public void setNumberQuestion(int numberQuestion) {
        this.numberQuestion = numberQuestion;
    }

    public Integer getSubjectLessonId() {
        return subjectLessonId;
    }

    public void setSubjectLessonId(Integer subjectLessonId) {
        this.subjectLessonId = subjectLessonId;
    }

    public Integer getSubjectDimensionId() {
        return subjectDimensionId;
    }

    public void setSubjectDimensionId(Integer subjectDimensionId) {
        this.subjectDimensionId = subjectDimensionId;
    }

    public int getQuizSettingId() {
        return quizSettingId;
    }

    public void setQuizSettingId(int quizSettingId) {
        this.quizSettingId = quizSettingId;
    }
}

