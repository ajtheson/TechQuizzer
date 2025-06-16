<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quiz Handle</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .option-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }

        .option-radio {
            width: 32px;
            height: 32px;
            background-color: grey;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            cursor: pointer;
        }

        .option-radio::after {
            content: '';
            width: 16px;
            height: 16px;
            background-color: white;
            border-radius: 50%;
            display: block;
            transition: background-color 0.2s ease;
        }

        .option-item.selected .option-radio::after {
            background-color: black;
        }

        .marked {
            background-color: #64c281 !important;
            color: white !important;
            border-color: #64c281 !important;
        }

        .unmarked {
            background-color: white !important;
            color: #64c281 !important;
            border-color: #64c281 !important;
        }

        .question-box {
            width: 45px;
            height: 45px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 0.25rem;
            padding: 0;
            color: black;
            background: white;
            border: grey solid 2px;
        }

        .question-box:hover {
            background-color: grey !important;
            color: white !important;
            border: grey solid 2px !important;
        }

        .question-box.answered {
            background-color: grey;
            color: black;
        }

        .question-box.marked {
            border: 2px solid orangered;
            color: orangered;
        }

    </style>
</head>
<body>

<%--quiz--%>
<div class="d-flex flex-column" style="min-height: 100vh;">
    <%--quiz header--%>
    <!--location + timer-->
    <div class="d-flex justify-content-end px-2 pt-2">
        <div class="d-flex align-items-center gap-4 px-4">
            <div class="d-flex align-items-center text-secondary fs-5">
                <i class="bi bi-geo-alt me-2 fa-lg"></i>
                <span id="location">1/20</span>
            </div>
            <div class="d-flex align-items-center fs-5 py-2 px-2" style="background: #a6bee3">
                <i class="fas fa-hourglass-half me-2 fa-lg"></i>
                <span id="timer">00:10:34</span>
            </div>
        </div>
    </div>

    <!--black header-->
    <div class="d-flex justify-content-between align-items-center px-4 py-2 bg-dark text-white mt-2">
        <div id="stt" class="fw-bold">...</div>
        <div id="qId" class="text-secondary small">...</div>
    </div>

    <!--quiz content-->
    <div class="flex-grow-1 d-flex flex-column" style="padding: 20px 40px">
        <%--question content--%>
        <div id="qContent" class="fs-5 mb-4 mx-5">
            ...
        </div>

        <%--question option--%>
        <div class="mb-4 mx-5">
            <ul id="qOption" class="list-unstyled m-0 p-0">
                <li class="option-item">
                    <div class="option-radio"></div>
                    <span>...</span>
                </li>
            </ul>
        </div>

        <%--right bottom corner button--%>
        <div class="d-flex justify-content-end gap-3 mt-auto">
            <button id="peekBtn"
                    class="btn ${requestScope.questionAttempts[0].examAttempt.type.equalsIgnoreCase("Practice") ? '' : 'invisible'}"
                    style="border: grey solid 2px; color: grey">
                Peek at answer
            </button>
            <button id="markBtn" class="btn"
                    style="border: #64c281 solid 2px; color: #64c281">
                <i class="bi bi-bookmark"></i> Mark for review
            </button>
        </div>
    </div>

    <!--quiz footer-->
    <div class="d-flex justify-content-between align-items-center px-5 py-4 border-top"
         style="background-color: #64c281;">
        <button class="btn text-white" data-bs-toggle="modal" data-bs-target="#popupReviewProgress"
                style="background-color: transparent; width: 180px; border: white solid 2px">
            Review progress
        </button>
        <div class="d-flex gap-2">
            <button id="prevBtn" class="btn text-white"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                <i class="bi bi-arrow-left"></i> Previous
            </button>

            <button id="nextBtn" class="btn text-white"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                Next <i class="bi bi-arrow-right"></i>
            </button>

            <button id="scoreExamBtn" class="btn text-white" data-bs-toggle="modal" data-bs-target="#popupScoreExam"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                Score Exam
            </button>
        </div>
    </div>
</div>

<%--popup confirm score exam--%>
<div class="modal fade" id="popupScoreExam" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 700px;">
        <div class="modal-content">
            <div class="modal-body p-4">
                <h5 class="mb-3 fw-bold">...</h5>
                <p>
                    ...
                </p>
                <div class="d-flex justify-content-end gap-3 mt-4">
                    <button class="btn" style="border: grey solid 2px; color: grey" data-bs-dismiss="modal">
                        <i class="bi bi-arrow-left"></i> Back
                    </button>
                    <button id="seSubmitBtn" class="btn" style="width: 150px; border: #64c281 solid 2px; color: #64c281">
                        ...
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--popup review progress--%>
<div class="modal fade" id="popupReviewProgress" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 1050px;">
        <div class="modal-content">
            <div class="modal-body p-4">
                <div class="d-flex justify-content-between">
                    <h5 class="mb-4 fw-bold">Review Progress</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="mb-3">
                    <span>Review before scoring exam.</span>
                </div>

                <%--line of 5 buttons--%>
                <div class="d-flex justify-content-between">
                    <div id="filterQuestionBtn">
                        <button id="rpUnansweredBtn" class="btn fw-semibold"
                                style="border: grey solid 2px; color: grey">
                            <i class="bi bi-square"></i> UNANSWERED
                        </button>
                        <button id="rpMarkedBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey">
                            <i class="bi bi-bookmark-fill" style="color: orangered;"></i> MARKED
                        </button>
                        <button id="rpAnsweredBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey">
                            <i class="bi bi-square-fill"></i> ANSWERED
                        </button>
                        <button id="rpAllQuestionsBtn" class="btn fw-semibold"
                                style="border: grey solid 2px; color: grey">
                            ALL QUESTIONS
                        </button>
                    </div>
                    <div>
                        <button id="rpScoreExamBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey">
                            SCORE EXAM NOW
                        </button>
                    </div>
                </div>
            </div>

            <%--question box--%>
            <div id="questionBoxArea" class="px-4 pb-4">
                <div class="d-flex flex-wrap gap-2">
                    <c:forEach var="question" items="${requestScope.questionAttempts}" varStatus="status">
                        <button class="question-box"
                                onclick="clickQuestionInPopup(${status.index})"
                                id="questionBox${status.index}"> ${status.count}
                        </button>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>

    let currentIndex = 0;
    let allQuestions = [];
    const timerElement = document.getElementById("timer");
    const prevButton = document.getElementById("prevBtn");
    const nextBtn = document.getElementById("nextBtn");
    const scoreExamBtn = document.getElementById("scoreExamBtn");
    const markBtn = document.getElementById("markBtn");
    const popupScoreExam = document.getElementById("popupScoreExam");
    const popupReviewProgress = document.getElementById("popupReviewProgress");
    const seSubmitBtn = document.getElementById("seSubmitBtn"); //score exam submit button

    //init question array
    <c:forEach var="qa" items="${requestScope.questionAttempts}">
    allQuestions.push({
        id: ${qa.getId()},
        userChoice: ${qa.getUserChoice() == null ? 'null' : qa.getUserChoice()},
        isMarked: ${qa.isMarked()},
        question: {
            id: ${qa.getQuestion().getId()},
            content: '${fn:escapeXml(qa.getQuestion().getContent())}',
            media: '${qa.getQuestion().getMedia()}',
            explaination: '${fn:escapeXml(qa.getQuestion().getExplaination())}'
        },
        options: [
            <c:forEach var="option" items="${qa.getOptions()}" varStatus="loop">
            {
                id: ${option.getId()},
                optionContent: '${fn:escapeXml(option.getOptionContent())}',
                isAnswer: ${option.isAnswer()},
                questionId: ${option.getQuestionId()}
            }<c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ]
    });
    </c:forEach>


    //render button
    const renderButton = () => {
        //render prev, next, score exam button
        if (currentIndex === 0) {
            prevButton.classList.add("invisible");
            scoreExamBtn.classList.add("d-none");
        } else if (currentIndex > 0 && currentIndex < allQuestions.length - 1) {
            prevButton.classList.remove("invisible");
            nextBtn.classList.remove("d-none");
            scoreExamBtn.classList.add("d-none");
        } else {
            nextBtn.classList.add("d-none");
            scoreExamBtn.classList.remove("d-none");
        }

        markBtn.classList.remove("marked", "unmarked");
        if (allQuestions[currentIndex].isMarked) {
            markBtn.classList.add("marked");
        } else {
            markBtn.classList.add("unmarked");
        }
    }


    //action on prev, next btn
    prevButton.addEventListener("click", (e) => {
        if (currentIndex > 0) {
            currentIndex--;
            renderButton();
            renderQuestion(currentIndex);
        }
    });

    nextBtn.addEventListener("click", (e) => {
        if (currentIndex < allQuestions.length - 1) {
            currentIndex++;
            renderButton();
            renderQuestion(currentIndex);
        }
    });


    //render question
    const renderQuestion = index => {
        const question = allQuestions[index];
        if (!question) return;

        document.getElementById("location").textContent = '' + (index + 1) + '/' + allQuestions.length;
        document.getElementById("stt").textContent = '' + (index + 1) + ' )';
        document.getElementById("qId").textContent = 'Question ID: ' + allQuestions[index].question.id;
        document.getElementById("qContent").textContent = allQuestions[index].question.content;

        const optionList = document.getElementById("qOption");
        optionList.innerHTML = "";

        question.options.forEach((option, i) => {
            const li = document.createElement("li");
            li.className = "option-item";
            if (option.id === question.userChoice) {
                li.classList.add("selected");
            }

            li.innerHTML =
                `<div class="option-radio" onclick="selectOption(this)"></div>
                <span id="questionId" class="d-none">\${option.id}</span>
                <span class="option-text">\${option.optionContent}</span>`;

            optionList.appendChild(li);
        });
    };


    //mark question
    markBtn.addEventListener("click", () => {
        allQuestions[currentIndex].isMarked = !allQuestions[currentIndex].isMarked;
        renderButton();
    });


    //select question option
    const selectOption = radioElement => {
        const optionItemElement = radioElement.closest('.option-item');
        allQuestions[currentIndex].userChoice = Number(optionItemElement.querySelector("#questionId").textContent);

        document.querySelectorAll('.option-item').forEach(item => item.classList.remove('selected'));
        optionItemElement.classList.add('selected');
    }


    //start timer
    const updateDisplay = (timer) => {
        let hours = Math.floor(timer / 3600);
        let minutes = Math.floor((timer % 3600) / 60);
        let seconds = timer % 60;

        hours = hours.toString().padStart(2, '0');
        minutes = minutes.toString().padStart(2, '0');
        seconds = seconds.toString().padStart(2, '0');

        timerElement.textContent = hours + ":" + minutes + ":" + seconds;
    }
    //display count down
    const startCountDown = duration => {
        let timer = duration;
        updateDisplay(timer);
        let interval = setInterval(() => {
            timer--;
            if (timer < 0) {
                clearInterval(interval);
                display.textContent = "Time's up!";
            } else {
                updateDisplay();
            }
        }, 1000);
    }
    //display count up
    const startCountUp = duration => {
        let timer = duration;
        updateDisplay(timer);
        let interval = setInterval(() => {
            timer++;
            updateDisplay(timer);
        }, 1000);
    }


    //insert content to popup score exam
    popupScoreExam.addEventListener("show.bs.modal" , (e) => {
        const length = allQuestions.filter(q => q.userChoice).length;
        if(length === 0){
            popupScoreExam.querySelector("h5").textContent = "Exit Exam?";
            popupScoreExam.querySelector("p").textContent = "You have not answered any questions. By clicking on the [Exit Exam] button below, " +
                "you will complete your current exam and be returned to the dashboard.";
            seSubmitBtn.textContent = "Exit Exam";
        }else if(length === allQuestions.length){
            popupScoreExam.querySelector("h5").textContent = "Score Exam?";
            popupScoreExam.querySelector("p").textContent = "By clicking on the [Score Exam] button below, you will complete your current exam and" +
            " receive your score. You will not be able to change any answers after this point.";
            seSubmitBtn.textContent = "Score Exam";
        }else{
            popupScoreExam.querySelector("h5").textContent = "Score Exam?";
            popupScoreExam.querySelector("p").innerHTML = `
                <span style='color: red; display: block' class='mb-3'>\${length} of \${allQuestions.length} Questions Answered</span>` +
                "By clicking on the [Score Exam] button below, you will complete your current exam and" +
                " receive your score. You will not be able to change any answers after this point.";
            seSubmitBtn.textContent = "Score Exam";
        }
    });

    //insert content to popup review progress
    popupReviewProgress.addEventListener("show.bs.modal", () => {
        allQuestions.forEach((q, i) => {
            const el = document.getElementById(`questionBox\${i}`);
            if (!el) return;

            el.classList.remove('answered', 'marked');

            if (q.isMarked) {
                el.classList.add('marked');
            }
            if (q.userChoice !== null) {
                el.classList.add('answered');
            }
        });
    });

    const clickQuestionInPopup = index => {
        currentIndex = index;
        const modal = bootstrap.Modal.getOrCreateInstance(popupReviewProgress);
        modal.hide();
        renderQuestion(index);
    };


    //init UI
    document.addEventListener("DOMContentLoaded", () => {
        if (${requestScope.questionAttempts[0].examAttempt.type.equalsIgnoreCase("Practice")}) {
            startCountUp(0);
        } else {
            startCountDown(${requestScope.questionAttempts[0].examAttempt.duration});
        }
        renderButton();
        renderQuestion(currentIndex);
    });


</script>
</body>
</html>
