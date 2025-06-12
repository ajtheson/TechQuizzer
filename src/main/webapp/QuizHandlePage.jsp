<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Handle Page</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .quiz-container {
            min-height: 100vh;
            padding: 20px 0;
        }

        .question-sidebar {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
            max-height: calc(100vh - 40px);
            overflow-y: auto;
            position: sticky;
            top: 20px;
        }

        .question-list-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .question-item {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .question-item:hover {
            border-color: #007bff;
            background-color: #f8f9ff;
            transform: translateY(-2px);
        }

        .question-item.active {
            border-color: #007bff;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .question-item.answered {
            border-color: #28a745;
            background-color: #d4edda;
        }

        .question-item.answered.active {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: white;
        }

        .question-status {
            font-size: 12px;
            padding: 2px 8px;
            border-radius: 10px;
            background-color: #6c757d;
            color: white;
        }

        .question-status.answered {
            background-color: #28a745;
        }

        .quiz-content {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 30px;
            min-height: calc(100vh - 40px);
        }

        .quiz-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .question-content {
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        .answer-option {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .answer-option:hover {
            border-color: #007bff;
            background-color: #f8f9ff;
        }

        .answer-option.selected {
            border-color: #007bff;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            color: #1565c0;
        }

        .answer-option input[type="radio"] {
            margin-right: 15px;
            transform: scale(1.2);
        }

        .quiz-navigation {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .quiz-info {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .progress-bar {
            height: 8px;
            border-radius: 10px;
            margin-top: 15px;
        }

        .btn-custom {
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .time-warning {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
    </style>
</head>
<body>
<div class="container-fluid quiz-container">
    <div class="row">
        <!-- Left Sidebar - Question List -->
        <div class="col-lg-3 col-md-4">
            <div class="question-sidebar">
                <div class="question-list-header">
                    <h5 class="mb-2"><i class="fas fa-list-ol"></i> Danh sách câu hỏi</h5>
                    <div class="quiz-info">
                        <div class="d-flex justify-content-between">
                            <span><i class="fas fa-clock"></i> Thời gian còn lại:</span>
                            <span id="timer" class="fw-bold">45:00</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar" role="progressbar" style="width: 20%" id="progressBar"></div>
                        </div>
                    </div>
                </div>

                <div id="questionList">
                    <!-- Questions will be populated here -->
                </div>

                <div class="mt-3">
                    <button class="btn btn-success btn-custom w-100" onclick="submitQuiz()">
                        <i class="fas fa-paper-plane"></i> Nộp bài
                    </button>
                </div>
            </div>
        </div>

        <!-- Right Content - Quiz Content -->
        <div class="col-lg-9 col-md-8">
            <div class="quiz-content">
                <div class="quiz-header">
                    <h3 class="text-primary mb-3">
                        <i class="fas fa-graduation-cap"></i> Bài kiểm tra: Lập trình Web
                    </h3>
                    <div class="row">
                        <div class="col-md-6">
                            <small class="text-muted">
                                <i class="fas fa-user"></i> Sinh viên: <strong>Nguyễn Văn A</strong>
                            </small>
                        </div>
                        <div class="col-md-6 text-end">
                            <small class="text-muted">
                                <i class="fas fa-calendar"></i> Ngày thi: <strong>10/06/2025</strong>
                            </small>
                        </div>
                    </div>
                </div>

                <div id="questionContent">
                    <!-- Question content will be populated here -->
                </div>

                <div class="quiz-navigation">
                    <button class="btn btn-outline-secondary btn-custom" id="prevBtn" onclick="previousQuestion()" disabled>
                        <i class="fas fa-chevron-left"></i> Câu trước
                    </button>

                    <div class="text-center">
                            <span class="badge bg-info fs-6 px-3 py-2">
                                Câu <span id="currentQuestionNum">1</span> / <span id="totalQuestions">10</span>
                            </span>
                    </div>

                    <button class="btn btn-primary btn-custom" id="nextBtn" onclick="nextQuestion()">
                        Câu tiếp <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Sample quiz data - Normally this would come from your servlet
    const quizData = {
        title: "Lập trình Web",
        duration: 45, // minutes
        questions: [
            {
                id: 1,
                question: "HTML là viết tắt của từ gì?",
                options: [
                    "HyperText Markup Language",
                    "High Tech Modern Language",
                    "Home Tool Markup Language",
                    "Hyperlink and Text Markup Language"
                ],
                correctAnswer: 0
            },
            {
                id: 2,
                question: "CSS được sử dụng để làm gì?",
                options: [
                    "Tạo cơ sở dữ liệu",
                    "Định dạng và trang trí trang web",
                    "Xử lý logic phía server",
                    "Tạo hiệu ứng JavaScript"
                ],
                correctAnswer: 1
            },
            {
                id: 3,
                question: "Servlet trong Java được sử dụng để làm gì?",
                options: [
                    "Tạo giao diện người dùng",
                    "Xử lý các yêu cầu HTTP",
                    "Kết nối cơ sở dữ liệu",
                    "Tạo file CSS"
                ],
                correctAnswer: 1
            },
            {
                id: 4,
                question: "JSP là viết tắt của gì?",
                options: [
                    "Java Server Pages",
                    "JavaScript Programming",
                    "Java Simple Protocol",
                    "Java System Process"
                ],
                correctAnswer: 0
            },
            {
                id: 5,
                question: "Bootstrap là gì?",
                options: [
                    "Một ngôn ngữ lập trình",
                    "Một framework CSS",
                    "Một cơ sở dữ liệu",
                    "Một server web"
                ],
                correctAnswer: 1
            }
        ]
    };

    let currentQuestion = 0;
    let userAnswers = {};
    let timeRemaining = 45 * 60; // 45 minutes in seconds

    function initializeQuiz() {
        populateQuestionList();
        displayQuestion(0);
        startTimer();
    }

    function populateQuestionList() {
        const questionList = document.getElementById('questionList');
        questionList.innerHTML = '';

        quizData.questions.forEach((question, index) => {
            const questionItem = document.createElement('div');
            questionItem.className = 'question-item';
            questionItem.onclick = () => displayQuestion(index);

            questionItem.innerHTML = `
                    <span><i class="fas fa-question-circle"></i> Câu ${index + 1}</span>
                    <span class="question-status" id="status-${index}">Chưa làm</span>
                `;

            if (index === currentQuestion) {
                questionItem.classList.add('active');
            }

            questionList.appendChild(questionItem);
        });
    }

    function displayQuestion(questionIndex) {
        if (questionIndex < 0 || questionIndex >= quizData.questions.length) return;

        currentQuestion = questionIndex;
        const question = quizData.questions[questionIndex];

        // Update question content
        const questionContent = document.getElementById('questionContent');
        questionContent.innerHTML = `
                <div class="question-content">
                    <h4><i class="fas fa-question-circle text-primary"></i> ${question.question}</h4>
                </div>
                <div class="answers">
                    ${question.options.map((option, index) => `
                        <div class="answer-option" onclick="selectAnswer(${index})" id="option-${index}">
                            <input type="radio" name="answer" value="${index}" ${userAnswers[question.id] === index ? 'checked' : ''}>
                            <span>${String.fromCharCode(65 + index)}. ${option}</span>
                        </div>
                    `).join('')}
                </div>
            `;

        // Update navigation
        document.getElementById('currentQuestionNum').textContent = questionIndex + 1;
        document.getElementById('totalQuestions').textContent = quizData.questions.length;
        document.getElementById('prevBtn').disabled = questionIndex === 0;
        document.getElementById('nextBtn').textContent =
            questionIndex === quizData.questions.length - 1 ? 'Hoàn thành' : 'Câu tiếp';

        // Update question list highlighting
        updateQuestionList();

        // Restore selected answer if exists
        if (userAnswers[question.id] !== undefined) {
            selectAnswer(userAnswers[question.id]);
        }
    }

    function selectAnswer(answerIndex) {
        const question = quizData.questions[currentQuestion];
        userAnswers[question.id] = answerIndex;

        // Update visual selection
        document.querySelectorAll('.answer-option').forEach((option, index) => {
            option.classList.remove('selected');
            const radio = option.querySelector('input[type="radio"]');
            radio.checked = false;

            if (index === answerIndex) {
                option.classList.add('selected');
                radio.checked = true;
            }
        });

        // Update question status
        updateQuestionStatus(currentQuestion, 'answered');
        updateProgress();
    }

    function updateQuestionStatus(questionIndex, status) {
        const statusElement = document.getElementById(`status-${questionIndex}`);
        if (status === 'answered') {
            statusElement.textContent = 'Đã làm';
            statusElement.classList.add('answered');

            // Update question item
            const questionItems = document.querySelectorAll('.question-item');
            questionItems[questionIndex].classList.add('answered');
        }
    }

    function updateQuestionList() {
        const questionItems = document.querySelectorAll('.question-item');
        questionItems.forEach((item, index) => {
            item.classList.remove('active');
            if (index === currentQuestion) {
                item.classList.add('active');
            }
        });
    }

    function updateProgress() {
        const answeredCount = Object.keys(userAnswers).length;
        const progress = (answeredCount / quizData.questions.length) * 100;
        document.getElementById('progressBar').style.width = progress + '%';
    }

    function previousQuestion() {
        if (currentQuestion > 0) {
            displayQuestion(currentQuestion - 1);
        }
    }

    function nextQuestion() {
        if (currentQuestion < quizData.questions.length - 1) {
            displayQuestion(currentQuestion + 1);
        } else {
            // Last question - show completion option
            if (confirm('Bạn có muốn nộp bài không?')) {
                submitQuiz();
            }
        }
    }

    function startTimer() {
        const timer = document.getElementById('timer');

        const timerInterval = setInterval(() => {
            const minutes = Math.floor(timeRemaining / 60);
            const seconds = timeRemaining % 60;

            timer.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

            // Warning when less than 5 minutes
            if (timeRemaining <= 300) {
                timer.classList.add('time-warning');
                timer.style.color = '#dc3545';
            }

            if (timeRemaining <= 0) {
                clearInterval(timerInterval);
                alert('Hết thời gian! Bài thi sẽ được nộp tự động.');
                submitQuiz();
            }

            timeRemaining--;
        }, 1000);
    }

    function submitQuiz() {
        const answeredCount = Object.keys(userAnswers).length;
        const totalQuestions = quizData.questions.length;

        if (answeredCount < totalQuestions) {
            if (!confirm(`Bạn chỉ làm ${answeredCount}/${totalQuestions} câu. Bạn có chắc muốn nộp bài?`)) {
                return;
            }
        }

        // Calculate score
        let correctAnswers = 0;
        quizData.questions.forEach(question => {
            if (userAnswers[question.id] === question.correctAnswer) {
                correctAnswers++;
            }
        });

        const score = (correctAnswers / totalQuestions) * 100;

        // In a real application, you would send this data to your servlet
        alert(`Bài thi đã được nộp!\nĐiểm số: ${score.toFixed(1)}/100\nSố câu đúng: ${correctAnswers}/${totalQuestions}`);

        // Simulate form submission to servlet
        console.log('Submitting to servlet:', {
            answers: userAnswers,
            score: score,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions
        });
    }

    // Initialize the quiz when page loads
    document.addEventListener('DOMContentLoaded', initializeQuiz);
</script>
</body>
</html>