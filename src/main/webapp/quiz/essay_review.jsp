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

        .question-box.answered {
            background-color: grey;
            color: black;
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

        .upload-label {
            display: inline-block;
            padding: 5px;
            border: 2px solid black;
            border-radius: 20px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        /*file item upload */
        .file-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: 1px solid #dadce0;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 8px;
            background-color: #fff;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: relative;
            min-height: 60px;
            cursor: pointer;
        }

        .file-item:hover {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            border-color: #1a73e8;
            background-color: #f8f9fa;
        }

        .file-content {
            display: flex;
            align-items: center;
            flex-grow: 1;
            min-width: 0;
        }

        .file-icon {
            width: 40px;
            height: 40px;
            margin-right: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            font-size: 18px;
            color: white;
            flex-shrink: 0;
        }

        /* File type colors */
        .file-icon.pdf {
            background-color: #ea4335;
        }

        .file-icon.doc, .file-icon.docx {
            background-color: #4285f4;
        }

        .file-icon.xls, .file-icon.xlsx {
            background-color: #34a853;
        }

        .file-icon.ppt, .file-icon.pptx {
            background-color: #ff6d01;
        }

        .file-icon.image {
            background-color: #9c27b0;
        }

        .file-icon.video {
            background-color: #f44336;
        }

        .file-icon.audio {
            background-color: #ff9800;
        }

        .file-icon.zip, .file-icon.rar {
            background-color: #795548;
        }

        .file-icon.txt {
            background-color: #607d8b;
        }

        .file-icon.default {
            background-color: #757575;
        }

        .file-info {
            flex-grow: 1;
            min-width: 0;
        }

        .file-name {
            font-weight: 500;
            color: #3c4043;
            font-size: 14px;
            margin-bottom: 2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            line-height: 1.4;
            transition: color 0.2s ease; /* THÊM */
        }

        .file-item:hover .file-name {
            color: #1a73e8;
            text-decoration: underline;
        }

        .file-size {
            font-size: 12px;
            color: #5f6368;
        }

        .file-action-btn {
            border: none;
            background: none;
            color: #5f6368;
            cursor: pointer;
            padding: 6px;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .file-action-btn:hover {
            background-color: #f1f3f4;
            color: #1a73e8;
        }

        .file-action-btn.remove:hover {
            background-color: #fce8e6;
            color: #d93025;
        }

        .file-preview {
            width: 40px;
            height: 40px;
            margin-right: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            flex-shrink: 0;
            position: relative;
            overflow: hidden;
        }

        .file-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .upload-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 16px;
            border: 2px dashed #dadce0;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 10px;
            background-color: #fafbfc;
            transition: all 0.2s ease;
            color: #5f6368;
            font-weight: 500;
        }

        .upload-label:hover {
            border-color: #1a73e8;
            background-color: #f8f9ff;
            color: #1a73e8;
        }

        .upload-label i {
            font-size: 16px;
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
            0 )
        </div>
        <div id="qId" class="text-secondary small">
            Question ID:
        </div>
    </div>

    <!--quiz content-->
    <div class="flex-grow-1 d-flex flex-column justify-content-between" style="padding: 20px 40px;">
        <div class="row flex-grow-1" style="padding: 0 100px">
            <%--question area--%>
            <div class="col-8" style="max-height: 490px; overflow-y:auto">
                <%--question content--%>
                <div id="qContent" class="fs-5 mb-4 mx-5">
                    <p>
                        No Content
                    </p>
                </div>

                <%--question media--%>
                <div id="qMedia" class="mb-4 mx-5">

                </div>
            </div>

            <%--submit file area--%>
            <div class="col-3 ms-auto mb-3">
                <div class="p-3 border rounded bg-light">
                    <h5 class="mb-3">Submit file</h5>
                    <input type="hidden" name="essayAttemptId" value="${requestScope.essayAttempt.id}"/>

                    <div>
                        <div id="upload-area" style="max-height: 221px; overflow-y: auto; overflow-x: hidden">
                            <%--                            <!-- eg PDF file -->--%>
                            <%--                            <div class="file-item">--%>
                            <%--                                <div class="file-content">--%>
                            <%--                                    <div class="file-icon pdf">--%>
                            <%--                                        <i class="fas fa-file-pdf"></i>--%>
                            <%--                                    </div>--%>
                            <%--                                    <div class="file-info">--%>
                            <%--                                        <div class="file-name" title="sample-document.pdf">sample-document.pdf</div>--%>
                            <%--                                        <div class="file-size">2.5 MB</div>--%>
                            <%--                                    </div>--%>
                            <%--                                </div>--%>
                            <%--                                <button class="file-action-btn remove" title="Xóa file">--%>
                            <%--                                    <i class="fas fa-times"></i>--%>
                            <%--                                </button>--%>
                            <%--                            </div>--%>

                            <%--                            <!-- eg Image file -->--%>
                            <%--                            <div class="file-item">--%>
                            <%--                                <div class="file-content">--%>
                            <%--                                    <div class="file-preview">--%>
                            <%--                                        <img src="https://via.placeholder.com/40x40/9c27b0/ffffff?text=IMG"--%>
                            <%--                                             alt="screenshot.png">--%>
                            <%--                                    </div>--%>
                            <%--                                    <div class="file-info">--%>
                            <%--                                        <div class="file-name" title="screenshot-2024.png">screenshot-2024.png</div>--%>
                            <%--                                        <div class="file-size">856 KB</div>--%>
                            <%--                                    </div>--%>
                            <%--                                </div>--%>
                            <%--                                <div class="file-actions">--%>
                            <%--                                    <button class="file-action-btn view" title="Xem file">--%>
                            <%--                                        <i class="fas fa-eye"></i>--%>
                            <%--                                    </button>--%>
                            <%--                                    <button class="file-action-btn remove" title="Xóa file">--%>
                            <%--                                        <i class="fas fa-times"></i>--%>
                            <%--                                    </button>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                        </div>
                    </div>
                    <hr/>
                    <p class="text-muted small mb-0">You can submit many files like PDF, Word, Image, Video,...</p>
                </div>
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
        <input type="hidden" name="examAttemptId" value="${requestScope.essayAttempts[0].examAttempt.id}"/>
    </form>

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
                        <button id="rpUnansweredBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-square"></i> UNANSWERED
                        </button>
                        <button id="rpMarkedBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-bookmark-fill" style="color: orange;"></i> MARKED
                        </button>
                        <button id="rpAnsweredBtn" class="btn fw-semibold" style="border: grey solid 2px; color: grey"
                                onclick="selectFilterButton(this)">
                            <i class="bi bi-square-fill"></i> ANSWERED
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
    let allEssayAttempts = [];
    const timerElement = document.getElementById("timer");
    const prevButton = document.getElementById("prevBtn");
    const nextBtn = document.getElementById("nextBtn");
    const popupReviewProgress = document.getElementById("popupReviewProgress");
    let countSecond = ${requestScope.essayAttempts[0].examAttempt.duration};
    const fileInput = document.getElementById("fileInput");
    const uploadArea = document.getElementById("upload-area");
    const contextPath = '${pageContext.request.contextPath}';


    //init question array
    <c:forEach var="ea" items="${requestScope.essayAttempts}">
    allEssayAttempts.push({
        id: ${ea.getId()},
        marked: ${ea.isMarked()},
        question: {
            id: ${ea.getQuestion().getId()},
            content: '${fn:escapeXml(ea.getQuestion().getContent())}',
            explaination: '${fn:escapeXml(ea.getQuestion().getExplaination())}'
        },
        questionMedias: [
            <c:forEach var="media" items="${ea.getQuestionMedias()}" varStatus="loop">
            {
                id: ${media.getId()},
                type: '${media.getType()}',
                link: '${media.getLink()}',
                description: '${media.getDescription()}'
            }<c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ],
        submissions: [
            <c:forEach var="submission" items="${ea.getSubmissions()}" varStatus="loop">
            '${submission.fileName}' <c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        ]
    });
    </c:forEach>
    // end


    //render button
    const renderButton = () => {
        //render prev, next
        if (currentIndex === 0) {
            nextBtn.classList.remove("invisible");
            prevButton.classList.add("invisible");
        } else if (currentIndex > 0 && currentIndex < allEssayAttempts.length) {
            prevButton.classList.remove("invisible");
            if (currentIndex === allEssayAttempts.length - 1) {
                nextBtn.classList.add("invisible");
            } else {
                nextBtn.classList.remove("invisible");
            }
        }
    }
    //end render button


    //action on prev, next btn
    prevButton.addEventListener("click", (e) => {
        if (currentIndex > 0) {
            currentIndex--;
            renderButton();
            renderQuestion(currentIndex);
        }
    });
    nextBtn.addEventListener("click", (e) => {
        if (currentIndex < allEssayAttempts.length - 1) {
            currentIndex++;
            renderButton();
            renderQuestion(currentIndex);
        }
    });
    // end


    // Get file extension
    function getFileExtension(filename) {
        return filename.split('.').pop().toLowerCase();
    }

    // Get file icon and color based on extension
    function getFileIcon(extension) {
        const icons = {
            pdf: {icon: 'fas fa-file-pdf', cssClass: 'pdf'},
            doc: {icon: 'fas fa-file-word', cssClass: 'doc'},
            docx: {icon: 'fas fa-file-word', cssClass: 'docx'},
            xls: {icon: 'fas fa-file-excel', cssClass: 'xls'},
            xlsx: {icon: 'fas fa-file-excel', cssClass: 'xlsx'},
            ppt: {icon: 'fas fa-file-powerpoint', cssClass: 'ppt'},
            pptx: {icon: 'fas fa-file-powerpoint', cssClass: 'pptx'},
            jpg: {icon: 'fas fa-file-image', cssClass: 'image'},
            jpeg: {icon: 'fas fa-file-image', cssClass: 'image'},
            png: {icon: 'fas fa-file-image', cssClass: 'image'},
            gif: {icon: 'fas fa-file-image', cssClass: 'image'},
            svg: {icon: 'fas fa-file-image', cssClass: 'image'},
            mp4: {icon: 'fas fa-file-video', cssClass: 'video'},
            avi: {icon: 'fas fa-file-video', cssClass: 'video'},
            mov: {icon: 'fas fa-file-video', cssClass: 'video'},
            wmv: {icon: 'fas fa-file-video', cssClass: 'video'},
            mp3: {icon: 'fas fa-file-audio', cssClass: 'audio'},
            wav: {icon: 'fas fa-file-audio', cssClass: 'audio'},
            zip: {icon: 'fas fa-file-archive', cssClass: 'zip'},
            rar: {icon: 'fas fa-file-archive', cssClass: 'rar'},
            txt: {icon: 'fas fa-file-alt', cssClass: 'txt'}
        };

        return icons[extension] || {icon: 'fas fa-file', cssClass: 'default'};
    }

    // Format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Check if file is image
    function isImageFile(extension) {
        return ['jpg', 'jpeg', 'png', 'gif', 'svg', 'webp'].includes(extension);
    }

    // Create file preview for images
    function createImagePreview(file) {
        if (file.size > 20 * 1024 * 1024) {
            throw new Error('File too large');
        }
        if (!file.type.startsWith('image/')) {
            throw new Error('Not an image file');
        }
        return URL.createObjectURL(file);
    }

    // create file item for each file in submissions of current essay attempt
    function renderFile(fileName, index) {
        const fileItem = document.createElement("div");
        fileItem.className = "file-item";
        fileItem.dataset.fileIndex = index;

        const extension = getFileExtension(fileName);
        const fileIconInfo = getFileIcon(extension);

        // const fileSize = formatFileSize(file.size);

        // Create file content
        const fileContent = document.createElement("div");
        fileContent.className = "file-content";

        // Create file icon or preview
        const fileIcon = document.createElement("div");
        fileIcon.className = `file-icon \${fileIconInfo.cssClass}`;

        // check extension to define class css
        if (isImageFile(extension)) {
            try {
                const essayAttemptId = allEssayAttempts[currentIndex].id;
                fileIcon.innerHTML = `<img src="\${contextPath}/assets/files/essay/\${essayAttemptId}/\${fileName}" alt="\${fileName}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 4px;">`;
                fileIcon.className = "file-preview";
            } catch (error) {
                fileIcon.innerHTML = `<i class="\${fileIconInfo.icon}"></i>`;
            }
        } else {
            fileIcon.innerHTML = `<i class="\${fileIconInfo.icon}"></i>`;
        }

        // Create file info
        const fileInfo = document.createElement("div");
        fileInfo.className = "file-info";
        fileInfo.innerHTML = `
        <div class="file-name" title="\${fileName}">\${fileName}</div>`;

        // <div class="file-size">\${fileSize}</div>`;

        fileContent.appendChild(fileIcon);
        fileContent.appendChild(fileInfo);
        fileItem.appendChild(fileContent);
        uploadArea.appendChild(fileItem);
    }

    // end create file item


    // render question
    const renderQuestion = (index) => {
        const currentQuestionAttempt = allEssayAttempts[index];
        if (!currentQuestionAttempt) return;

        document.getElementById("location").textContent = '' + (index + 1) + '/' + allEssayAttempts.length;
        document.getElementById("stt").textContent = '' + (index + 1) + ' )';
        document.getElementById("qId").textContent = 'Question ID: ' + currentQuestionAttempt.question.id;
        document.getElementById("qContent").textContent = currentQuestionAttempt.question.content;

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
                        mediaElement.src = `../assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
                        mediaElement.style.maxWidth = "100%";
                        mediaElement.style.height = "auto";
                        break;

                    case 'video':
                        mediaElement = document.createElement("video");
                        mediaElement.src = `../assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
                        mediaElement.controls = true;
                        mediaElement.style.maxWidth = "100%";
                        break;

                    case 'audio':
                        mediaElement = document.createElement("audio");
                        mediaElement.src = `../assets/files/media/\${currentQuestionAttempt.question.id}/\${media.link}`;
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

        // Clear upload area
        uploadArea.innerHTML = "";

        // Render existing files
        const submissions = allEssayAttempts[index].submissions;
        for (let i = 0; i < submissions.length; i++) {
            renderFile(submissions[i], i);
        }
    };
    // end render question


    //insert content to popup review progress
    const renderQuestionBoxes = (filterType) => {
        const container = document.getElementById("questionBoxContainer");
        container.innerHTML = "";

        const filteredQuestions = allEssayAttempts.filter((ea) => {
            switch (filterType) {
                case "ALL":
                    return true;
                case "ANSWERED":
                    return ea.submissions.length > 0;
                case "UNANSWERED":
                    return ea.submissions.length === 0;
                case "MARKED":
                    return ea.marked;
            }
        });

        filteredQuestions.forEach((ea) => {
            const index = allEssayAttempts.indexOf(ea);

            const btn = document.createElement("button");
            btn.className = "question-box";
            if (ea.submissions.length > 0) {
                btn.classList.add("answered");
            }
            if (ea.marked) {
                btn.classList.add("marked");
            }
            btn.id = `questionBox\${index}`;
            btn.innerHTML = `
                <span>\${index + 1}</span>
                \${ea.marked ? '<i class="bi bi-bookmark-fill mark-flag"></i>' : ''}
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
        } else {
            renderQuestionBoxes("ANSWERED");
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
    //end insert content to popup review progress


    //download file
    const downloadFile = (fileName) => {
        const essayAttemptId = allEssayAttempts[currentIndex].id;
        const downloadUrl = `\${contextPath}/assets/files/essay/\${essayAttemptId}/\${fileName}`;
        const link = document.createElement('a');
        link.href = downloadUrl;
        link.download = fileName; //notice browser download file instead of open file in href, assign fileName to set name of downloaded file
        link.style.display = 'none';
        document.body.appendChild(link); //click() active when tag a in DOM so need to append
        link.click();
        document.body.removeChild(link);
    }

    //add action download file when user click name
    document.addEventListener('click', (e) => {
        const fileItem = e.target.closest('.file-item');
        if (fileItem && !e.target.closest('.file-action-btn')) {
            const fileName = fileItem.querySelector('.file-name').getAttribute('title') || fileItem.querySelector('.file-name').textContent;
            downloadFile(fileName);
        }
    });
    //end download file


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
