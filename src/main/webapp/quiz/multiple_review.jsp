<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quiz Review</title>
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

        .option-checkbox {
            width: 24px;
            height: 24px;
            background-color: grey;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        .option-item.correct-answer .option-checkbox {
            background-color: #28a745;
        }

        .option-item.wrong-answer .option-checkbox {
            background-color: #dc3545;
        }

        .answer-badge-container {
            width: 120px;
            display: flex;
            justify-content: flex-start;
            margin-right: 12px;
        }

        .answer-badge {
            padding: 4px 12px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            text-transform: uppercase;
            display: inline-block;
            white-space: nowrap;
            background-color: #ff6b35;
            position: relative;
            border-radius: 4px 0 0 4px;
        }

        .answer-badge::after {
            content: '';
            position: absolute;
            top: -3px;
            right: -8px;
            width: 0;
            height: 0;
            border-left: 8px solid #ff6b35;
            border-top: 16px solid transparent;
            border-bottom: 16px solid transparent;
        }

        .markedBtn {
            background-color: orange !important;
            color: white !important;
            border-color: orange !important;
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
            position: relative;
        }

        .question-box:hover {
            background-color: grey !important;
            color: white !important;
            border: grey solid 2px !important;
        }

        .question-box.correct {
            background-color: #28a745;
            color: black;
            border: #28a745 solid 2px !important;
        }

        .question-box.incorrect {
            background-color: #dc3545;
            color: black;
            border: #dc3545 solid 2px !important;
        }

        .mark-flag {
            position: absolute;
            top: -8px;
            right: 1px;
            color: orangered;
            font-size: 14px;
        }

        .btn.selected {
            border: grey solid 2px;
            background: grey;
            color: white !important;
        }

        .note-text {
            font-style: italic;
            font-size: 0.9rem;
            color: #555;
        }

    </style>
</head>
<body onload="initQuiz()">

<%--quiz--%>
<div class="d-flex flex-column" style="min-height: 100vh;">
    <%--quiz header--%>
    <!--location + timer-->
    <div class="d-flex justify-content-between px-2 pt-2">
        <button onclick="window.history.back(); return false;" class="btn btn-outline-secondary mx-3 px-4">
            <i class="bi bi-arrow-left"></i> Exit Review
        </button>

        <div class="d-flex align-items-center gap-4 px-4">
            <div class="d-flex align-items-center text-secondary fs-5">
                <i class="bi bi-geo-alt me-2 fa-lg"></i>
                <span id="location">0/0</span>
            </div>
            <div class="d-flex align-items-center fs-5 py-2 px-2" style="background: #a6bee3">
                <i class="fas fa-hourglass-half me-2 fa-lg"></i>
                <span id="timer">00:00:00</span>
            </div>
        </div>
    </div>

    <!--black header-->
    <div class="d-flex justify-content-between align-items-center px-4 py-2 bg-dark text-white mt-2">
        <div id="stt" class="fw-bold">

        </div>
        <div id="qId" class="text-secondary small">

        </div>
    </div>

    <!--quiz content-->
    <div class="flex-grow-1 d-flex flex-column" style="padding: 20px 40px">
        <%--quiz wrapper--%>
        <div style="max-height: 480px; overflow: auto;">
            <%--question content--%>
            <div id="qContent" class="fs-5 mb-4 mx-5">
                <p>
                    No Content
                </p>
            </div>

            <%--question media--%>
            <div id="qMedia" class="mb-4 mx-5">

            </div>

            <%--number of correct answer    --%>
            <div id="numberAnswer" class="mb-1 mx-5">
                <span class="note-text"></span>
            </div>

            <%--question option--%>
            <div class="mb-4 mx-5">
                <ul id="qOption" class="list-unstyled m-0 p-0">
                    <li class="option-item">
                        <div class="option-radio"></div>
                        <span>

                    </span>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!--quiz footer-->
    <div class="d-flex justify-content-between align-items-center px-5 py-4 border-top"
         style="background-color: #64c281;">
        <button class="btn text-white" data-bs-toggle="modal" data-bs-target="#popupReviewProgress"
                style="background-color: transparent; width: 180px; border: white solid 2px">
            Review Result
        </button>
        <div class="d-flex gap-2">
            <button id="explanationBtn" class="btn text-white" data-bs-toggle="modal" data-bs-target="#popupExplanation"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                Explanation
            </button>

            <button id="prevBtn" class="btn text-white"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                <i class="bi bi-arrow-left"></i> Previous
            </button>

            <button id="nextBtn" class="btn text-white"
                    style="background-color: transparent; width: 150px; border: white solid 2px">
                Next <i class="bi bi-arrow-right"></i>
            </button>
        </div>
    </div>

    <form id="quizHandleForm" method="post" action="quiz-handle">
        <input type="hidden" name="examAttemptId" value="${requestScope.questionAttempts[0].examAttempt.id}"/>
    </form>

</div>

<%--popupExplanation--%>
<div class="modal fade" id="popupExplanation" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="d-flex justify-content-between">
                    <h5 class="mb-4 fw-bold">Explanation</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                </div>
                <div id="explainContainer">
                    <span style="display: block" class="mb-3">...</span>
                    <p>
                        ...
                    </p>
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
                    <h5 class="mb-4 fw-bold">Review Results</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="mb-3">
                    <span>Review specific question below.</span>
                </div>

                <%--line of 5 buttons--%>
                <div class="d-flex justify-content-between">
                    <div id="filterQuestionBtn">
                        <button id="rpMarkedBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-bookmark-fill" style="color: orangered;"></i> MARKED
                        </button>

                        <button id="rpCorrectBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-square-fill text-success"></i> CORRECT
                        </button>

                        <button id="rpInCorrectBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-square-fill text-danger"></i> INCORRECT
                        </button>

                        <button id="rpUnansweredBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-square"></i> UNANSWERED
                        </button>

                        <button id="rpAllQuestionsBtn" class="btn fw-semibold"
                                style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            ALL QUESTIONS
                        </button>
                    </div>
                </div>
            </div>

            <%--question box--%>
            <div id="questionBoxContainer" class="d-flex flex-wrap gap-2 px-4 pb-4">
                ...
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
    const popupExplanation = document.getElementById("popupExplanation");
    const popupReviewProgress = document.getElementById("popupReviewProgress");
    let countSecond = ${requestScope.questionAttempts[0].examAttempt.duration};

    //init question array
    <c:forEach var="qa" items="${requestScope.questionAttempts}">
    allQuestions.push({
        id: ${qa.getId()},
        userChoices: [
            <c:forEach var="userChoice" items="${qa.getUserChoices()}" varStatus="loop">
            ${userChoice} <c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ],
        marked: ${qa.isMarked()},
        question: {
            id: ${qa.getQuestion().getId()},
            content: '${fn:escapeXml(qa.getQuestion().getContent())}',
            explaination: '${fn:escapeXml(qa.getQuestion().getExplaination())}'
        },
        questionMedias: [
            <c:forEach var="media" items="${qa.getQuestionMedias()}" varStatus="loop">
            {
                id: ${media.getId()},
                type: '${media.getType()}',
                link: '${media.getLink()}',
                description: '${media.getDescription()}'
            }<c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ],
        options: [
            <c:forEach var="option" items="${qa.getOptions()}" varStatus="loop">
            {
                id: ${option.getId()},
                optionContent: '${fn:escapeXml(option.getOptionContent())}',
                answer: ${option.isAnswer()},
                questionId: ${option.getQuestionId()}
            }<c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ]
    });
    </c:forEach>


    //render button
    const renderButton = () => {
        //render prev, next
        if (currentIndex === 0) {
            nextBtn.classList.remove("invisible");
            prevButton.classList.add("invisible");
        } else if (currentIndex > 0 && currentIndex < allQuestions.length) {
            prevButton.classList.remove("invisible");
            if (currentIndex === allQuestions.length - 1) {
                nextBtn.classList.add("invisible");
            } else {
                nextBtn.classList.remove("invisible");
            }
        }
        if (allQuestions[currentIndex].question.explaination && allQuestions[currentIndex].question.explaination.trim() !== '') {
            document.getElementById("explanationBtn").classList.remove("invisible");
        } else {
            document.getElementById("explanationBtn").classList.add("invisible");
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
        const currentQuestionAttempt = allQuestions[index];
        if (!currentQuestionAttempt) return;

        document.getElementById("location").textContent = '' + (index + 1) + '/' + allQuestions.length;
        document.getElementById("stt").textContent = '' + (index + 1) + ' )';
        document.getElementById("qId").textContent = 'Question ID: ' + currentQuestionAttempt.question.id;
        document.getElementById("qContent").textContent = currentQuestionAttempt.question.content;
        document.querySelector("#numberAnswer span").textContent = "Choose " + currentQuestionAttempt.options.filter(o => o.answer).length + " answer(s)";


        const mediaContainer = document.getElementById("qMedia");
        mediaContainer.innerHTML = "";
        if (currentQuestionAttempt.questionMedias && currentQuestionAttempt.questionMedias.length > 0) {
            currentQuestionAttempt.questionMedias.forEach(media => {
                const mediaWrapper = document.createElement("div");
                mediaWrapper.className = "mb-2";

                let mediaElement;
                switch (media.type) {
                    case 'image':
                        mediaElement = document.createElement("img");
                        mediaElement.src = `${pageContext.request.contextPath}/assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
                        mediaElement.style.maxWidth = "100%";
                        mediaElement.style.height = "auto";
                        break;

                    case 'video':
                        mediaElement = document.createElement("video");
                        mediaElement.src = `${pageContext.request.contextPath}/assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
                        mediaElement.controls = true;
                        mediaElement.style.maxWidth = "100%";
                        break;

                    case 'audio':
                        mediaElement = document.createElement("audio");
                        mediaElement.src = `${pageContext.request.contextPath}/assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
                        mediaElement.controls = true;
                        break;
                }

                if (mediaElement) {
                    mediaWrapper.appendChild(mediaElement);

                    // // Add description if exists
                    // if (media.description && media.description.trim() !== '') {
                    //     const description = document.createElement("p");
                    //     description.className = "fst-italic mt-1";
                    //     description.textContent = media.description;
                    //     mediaWrapper.appendChild(description);
                    // }

                    mediaContainer.appendChild(mediaWrapper);
                }
            });
        }

        const optionList = document.getElementById("qOption");
        optionList.innerHTML = "";

        currentQuestionAttempt.options.forEach((option, i) => {
            const li = document.createElement("li");
            li.className = "option-item";

            const isUserSelected = currentQuestionAttempt.userChoices.includes(option.id);
            const isCorrectAnswer = option.answer;

            if (isCorrectAnswer) {
                li.classList.add("correct-answer");
            }
            if (isUserSelected && !isCorrectAnswer) {
                li.classList.add("wrong-answer");
            }

            li.innerHTML = `
            <div class="answer-badge-container">
                \${isUserSelected ? '<div class="answer-badge">YOUR ANSWER</div>' : ''}
            </div>
            <div class="option-checkbox">
                \${isCorrectAnswer ? '<i class="bi bi-check text-white"></i>' : ''}
                \${isUserSelected && !isCorrectAnswer ? '<i class="bi bi-x text-white"></i>' : ''}
            </div>
            <span id="optionId" class="d-none">\${option.id}</span>
            <span>\${option.optionContent}</span>
            `;

            optionList.appendChild(li);
        });
    };


    //insert content to popup explanation
    popupExplanation.addEventListener("show.bs.modal", (e) => {
        const answerLetter = allQuestions[currentIndex].options.filter(op => op.answer).map(op => op.optionContent.charAt(0)).join(', ');
        popupExplanation.querySelector("#explainContainer span").textContent = `The correct answer is \${answerLetter}`;
        popupExplanation.querySelector("#explainContainer p").textContent = allQuestions[currentIndex].question.explaination;
    })


    //insert content to popup review progress
    const renderQuestionBoxes = (filterType) => {
        const container = document.getElementById("questionBoxContainer");
        container.innerHTML = "";

        const filteredQuestions = allQuestions.filter((q) => {
            switch (filterType) {
                case "ALL":
                    return true;
                case "CORRECT":
                    return q.userChoices.length && q.userChoices.every(selectedId => q.options.find(opt => opt.id === selectedId)?.answer === true);
                case "INCORRECT":
                    return q.userChoices.length && q.userChoices.some(selectedId => q.options.find(opt => opt.id === selectedId)?.answer === false);
                case "UNANSWERED":
                    return q.userChoices.length === 0;
                case "MARKED":
                    return q.marked;
            }
        });

        filteredQuestions.forEach((q) => {
            const index = allQuestions.indexOf(q);

            const btn = document.createElement("button");
            btn.className = "question-box";

            const isAllCorrect = q.userChoices.every(selectedId => q.options.find(opt => opt.id === selectedId)?.answer === true);
            if (allQuestions[index].userChoices.length && isAllCorrect) {
                btn.classList.add("correct");
            }
            else if (allQuestions[index].userChoices.length && !isAllCorrect){
                btn.classList.add("incorrect");
            }
            btn.id = `questionBox\${index}`;
            btn.innerHTML = `
                <span>\${index + 1}</span>
                \${q.marked ? '<i class="bi bi-bookmark-fill mark-flag"></i>' : ''}
            `;
            btn.onclick = () => clickQuestionBoxInPopup(index);

            container.appendChild(btn);
        });
    };

    const selectFilterButton = btnElement => {
        popupReviewProgress.querySelectorAll("#filterQuestionBtn button").forEach(b => b.classList.remove("selected"));
        btnElement.classList.add("selected");

        if (btnElement.id === "rpAllQuestionsBtn") {
            renderQuestionBoxes("ALL");
        } else if (btnElement.id === "rpMarkedBtn") {
            renderQuestionBoxes("MARKED");
        } else if (btnElement.id === "rpUnansweredBtn") {
            renderQuestionBoxes("UNANSWERED");
        } else if(btnElement.id === "rpCorrectBtn"){
            renderQuestionBoxes("CORRECT");
        }else{
            renderQuestionBoxes("INCORRECT");
        }
    }

    const clickQuestionBoxInPopup = index => {
        currentIndex = index;
        const modal = bootstrap.Modal.getOrCreateInstance(popupReviewProgress);
        modal.hide();
        renderButton()
        renderQuestion(index);
    };

    popupReviewProgress.addEventListener("show.bs.modal", () => {
        selectFilterButton(document.getElementById("rpAllQuestionsBtn"));
    });


    //render timer
    const renderTimer = () => {
        let hours = Math.floor(countSecond / 3600);
        let minutes = Math.floor((countSecond % 3600) / 60);
        let seconds = countSecond % 60;

        hours = hours.toString().padStart(2, '0');
        minutes = minutes.toString().padStart(2, '0');
        seconds = seconds.toString().padStart(2, '0');

        timerElement.textContent = hours + ":" + minutes + ":" + seconds;
    }


    //init UI
    const initQuiz = () => {
        renderButton();
        renderQuestion(currentIndex);
        renderTimer();
    };


</script>
</body>
</html>
