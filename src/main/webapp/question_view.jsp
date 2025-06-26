<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 22/06/2025
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./common/headload.jsp"/>
    <title>View Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>

    <!-- Select2 Bootstrap 5 Theme -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css"/>

    <!-- jQuery (phải load trước Select2) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <!-- Select2 JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <style>
        .media-name {
            margin-top: 5px;
            font-style: italic;
        }

        #media-popup {
            position: fixed;
            top: 20%;
            left: 35%;
            width: 30%;
            background: #fff;
            border: 1px solid #ccc;
            padding: 20px;
            display: none;
            z-index: 1000;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        #media-list img,
        #media-list video,
        #media-list audio {
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<h2 style="text-align: center; margin-top: 20px">View Question</h2>
<button onclick="window.history.back(); return false;" class="btn btn-outline-secondary"
        style="position: fixed; left: 50px; top: 100px; z-index: 1000;">
    <i class="bi bi-arrow-left"></i> Back
</button>

<div class="container" style="margin-top: 50px; max-width: 800px">
    <div class="form-container">
        <form>
            <!-- Subject -->
            <div class="mb-3">
                <label class="form-label">Subject</label>
                <select class="form-control" disabled>
                    <c:forEach var="subject" items="${registrationSubjects}">
                        <option ${subject.id == subjectID ? "selected" : ""}>
                                ${subject.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Lesson -->
            <div class="mb-3">
                <label class="form-label">Lesson</label>
                <select class="form-control" disabled>
                    <option>None</option>
                    <c:forEach var="lesson" items="${lessons}">
                        <option ${lesson.id == question.subjectLessonId ? "selected" : ""}>${lesson.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Dimension -->
            <div class="mb-3">
                <label class="form-label">Dimension</label>
                <select class="form-control" disabled>
                    <option>None</option>
                    <c:forEach var="dimension" items="${dimensions}">
                        <option ${dimension.id == question.subjectDimensionId ? "selected" : ""}>${dimension.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Level -->
            <div class="mb-3">
                <label class="form-label">Level</label>
                <select class="form-control" disabled>
                    <c:forEach var="level" items="${questionLevels}">
                        <option ${level.id == question.questionLevelId ? "selected" : ""}>${level.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Status -->
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select class="form-control" disabled>
                    <option selected>${question.status ? "Activate" : "Inactivate"}</option>
                </select>
            </div>

            <!-- Content -->
            <div class="mb-3">
                <label class="form-label">Question Content</label>
                <textarea class="form-control" rows="3" disabled>${question.content}</textarea>
            </div>

            <!-- Media -->
            <c:if test="${not empty medias}">
                <div class="mb-3">
                    <label class="form-label">Media</label>
                    <div class="d-flex flex-column gap-2">
                        <c:forEach var="m" items="${medias}">
                            <c:choose>
                                <c:when test="${m.type == 'image'}">
                                    <img src="assets/files/media/${question.id}/${m.link}"
                                         style="max-width: 100%; height: auto;"/>
                                </c:when>
                                <c:when test="${m.type == 'video'}">
                                    <video src="assets/files/media/${question.id}/${m.link}" controls
                                           style="max-width: 100%;"></video>
                                </c:when>
                                <c:when test="${m.type == 'audio'}">
                                    <audio src="assets/files/media/${question.id}/${m.link}" controls></audio>
                                </c:when>
                            </c:choose>
                            <c:if test="${not empty m.description}">
                                <p class="fst-italic">${m.description}</p>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Format -->
            <div class="mb-3">
                <label class="form-label">Question Format</label>
                <input type="text" class="form-control"
                       <c:if test="${question.questionFormat == 'multiple'}">value="Multiple"</c:if>
                       <c:if test="${question.questionFormat == 'essay'}">value="Essay"</c:if>
                       disabled/>
            </div>

            <!-- Multiple Choices (if format is multiple) -->
            <c:if test="${question.questionFormat == 'multiple'}">
                <div class="mb-3">
                    <label class="form-label">Answer Options</label>
                    <div class="d-flex flex-column gap-2">
                        <c:forEach var="o" items="${options}">
                            <div class="input-group">
                                <input type="text" class="form-control" value="${o.optionContent}" disabled/>
                                <div class="input-group-text">
                                    <input class="form-check-input" type="checkbox" ${o.answer ? 'checked' : ''}
                                           disabled/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Explanation -->
            <div class="mb-3">
                <label class="form-label">Explanation</label>
                <textarea class="form-control" rows="3" disabled>${question.explaination}</textarea>
            </div>

            <!-- Action -->
            <div class="d-flex justify-content-end">
                <a href="edit_question?id=${question.id}" class="btn btn-success">Update</a>
                <c:if test="${question.status}"><a href="toggle_question_status?id=${question.id}&mode=deactivate" class="btn btn-secondary" style="margin-left: 10px">Deactivate</a></c:if>
                <c:if test="${!question.status}"><a href="toggle_question_status?id=${question.id}&mode=activate" class="btn btn-secondary" style="margin-left: 10px">Activate</a></c:if>
            </div>

        </form>
    </div>
</div>
<!-- Toast Notification -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="toast" class="toast align-items-center border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<script>
    function toggleChoice(show) {
        document.getElementById("choice-section").style.display = show
            ? "block"
            : "none";
    }

    let choiceIndex = 1; // index bắt đầu từ 1 nếu đã có sẵn 1 choice

    function addChoice() {
        const choice = document.createElement("div");
        choice.className = "input-group mb-2";
        choice.innerHTML = `
        <input type="text" name="choiceText\${choiceIndex}" class="form-control" placeholder="Enter choice">
        <div class="input-group-text">
            <input type="checkbox" name="isCorrect\${choiceIndex}" class="form-check-input">
        </div>
        <button class="btn btn-outline-danger" type="button" onclick="removeChoice(this)">Remove</button>
    `;
        document.getElementById("choices").appendChild(choice);
        choiceIndex++;
    }

    function removeChoice(btn) {
        btn.closest(".input-group").remove();
    }

    function openMediaPopup() {
        document.getElementById("media-popup").style.display = "block";
    }

    function closeMediaPopup() {
        document.getElementById("media-popup").style.display = "none";
        document.getElementById("mediaFile").value = "";
    }

    let mediaFiles = [];

    function addMedia() {
        const type = document.getElementById("mediaType").value;
        const fileInput = document.getElementById("mediaFile");
        const file = fileInput.files[0];
        const desc = document.getElementById("mediaDesc").value.trim();

        const allowed = {
            image: ["jpg", "jpeg", "png", "gif"],
            video: ["mp4", "webm"],
            audio: ["mp3", "wav"]
        };

        if (!file) {
            alert("Please select a file.");
            return;
        }

        const ext = file.name.split(".").pop().toLowerCase();
        if (!allowed[type].includes(ext)) {
            alert("Invalid file type for " + type);
            return;
        }

        // 🔴 Chặn file trùng tên
        const alreadyExists = mediaFiles.some(f => f.name === file.name);
        if (alreadyExists) {
            alert("This file has already been added.");
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            mediaFiles.push({name: file.name, type, desc, src: e.target.result});
            renderMediaList();

            const metaInput = document.createElement("input");
            metaInput.type = "hidden";
            metaInput.name = "mediaMeta";
            metaInput.value = `\${file.name}|\${type}|\${desc}`;
            document.getElementById("media-metadata-container").appendChild(metaInput);

            const dt = new DataTransfer();
            const fileHidden = document.getElementById("media-hidden");
            for (let i = 0; i < fileHidden.files.length; i++) {
                dt.items.add(fileHidden.files[i]);
            }
            dt.items.add(file);
            fileHidden.files = dt.files;
        };
        reader.readAsDataURL(file);

        closeMediaPopup();
    }


    function removeMedia(index) {
        mediaFiles.splice(index, 1);
        renderMediaList();
    }

    function renderMediaList() {
        const mediaListDiv = document.getElementById("media-list");
        mediaListDiv.innerHTML = "";

        mediaFiles.forEach((file, index) => {
            const wrapper = document.createElement("div");
            wrapper.className = "mb-2";

            // File name + remove button
            const nameRow = document.createElement("div");
            nameRow.className = "d-flex justify-content-between align-items-center";

            const fileName = document.createElement("span");
            fileName.textContent = file.name;

            const removeBtn = document.createElement("button");
            removeBtn.className = "btn btn-sm btn-danger";
            removeBtn.textContent = "Remove";
            removeBtn.onclick = () => removeMedia(index);

            nameRow.appendChild(fileName);
            nameRow.appendChild(removeBtn);
            wrapper.appendChild(nameRow);

            // Preview
            const preview = document.createElement(file.type === "image" ? "img" : (file.type === "video" ? "video" : "audio"));
            preview.src = file.src;
            preview.controls = true;
            preview.className = "mt-1";
            preview.style.maxWidth = "100%";
            preview.style.maxHeight = "200px";

            wrapper.appendChild(preview);
            mediaListDiv.appendChild(wrapper);
        });
    }


    //

    const dimensionRadioBtn = document.getElementById("byDimension")
    const dimensionSection = document.getElementById("dimensionSection")
    const dimensionSelect = document.getElementById('subjectDimensionIds')

    const lessonRadioBtn = document.getElementById("byLesson")
    const lessonSection = document.getElementById("lessonSection")
    const lessonSelect = document.getElementById('subjectLessonIds')

    const subjectSelect = document.getElementById("subjectId")

    //init object array to contain all dimension owned by user registered subject
    const allDimensions = [];
    <c:forEach var="dimension" items="${requestScope.dimensions}">
    allDimensions.push({
        id: ${dimension.getId()},
        name: "${dimension.getName()}",
        subjectId: ${dimension.getSubjectId()}
    })
    </c:forEach>

    //init object array to contain all lesson owned by user registered subject
    const allLessons = [];
    <c:forEach var="lesson" items="${requestScope.lessons}">
    allLessons.push({
        id: ${lesson.id},
        name: "${lesson.name}",
        subjectId: ${lesson.subjectId}
    })
    </c:forEach>


    //prevent select dimension option when subject hasn't chosen yet
    dimensionSelect.addEventListener("click", (e) => {
        if (!subjectSelect.value) {
            e.preventDefault();
            alert("Vui lòng chọn Subject trước khi chọn Dimension");
            this.blur();
        }
    });

    //prevent select lesson option when subject hasn't chosen yet
    lessonSelect.addEventListener("click", (e) => {
        if (!subjectSelect.value) {
            e.preventDefault();
            alert("Vui lòng chọn Subject trước khi chọn Lesson");
            this.blur();
        }
    });

    //filter option for dimension and lesson list when subject is chosen
    subjectSelect.addEventListener("change", (e) => {
        const subjectId = parseInt(e.target.value);

        dimensionSelect.innerHTML = "<option value='' disabled selected>Select dimension</option>";
        lessonSelect.innerHTML = "<option value='' disabled selected>Select lesson</option>";

        const filteredDims = allDimensions.filter(d => d.subjectId === subjectId);
        filteredDims.forEach(d => {
            const opt = document.createElement("option");
            opt.value = d.id;
            opt.text = d.name;
            dimensionSelect.appendChild(opt);
        });

        const filteredLessons = allLessons.filter(l => l.subjectId === subjectId);
        filteredLessons.forEach(l => {
            const opt = document.createElement("option");
            opt.value = l.id;
            opt.text = l.name;
            lessonSelect.appendChild(opt);
        });
    });


    //


    document.getElementById("questionForm").addEventListener("submit", function (e) {
        const errorDiv = document.getElementById("error");
        errorDiv.innerText = "";

        const subject = document.getElementById("subjectId").value;
        const dimension = document.getElementById("subjectDimensionIds").value;
        const lesson = document.getElementById("subjectLessonIds").value;
        const contentField = document.querySelector("textarea[name='content']");
        const content = contentField.value.trim();
        const format = document.querySelector("input[name='format']:checked");

        if (!subject) {
            e.preventDefault();
            errorDiv.innerText = "Please select a subject.";
            return;
        }

        if (!dimension && !lesson) {
            e.preventDefault();
            errorDiv.innerText = "Please select at least one: Dimension or Lesson.";
            return;
        }

        const level = document.querySelector("select[name='questionLevelId']").value;
        if (!level) {
            e.preventDefault();
            errorDiv.innerText = "Please select a level.";
            return;
        }

        if (!content) {
            e.preventDefault();
            errorDiv.innerText = "Question content cannot be empty or just spaces.";
            return;
        }

        if (!format) {
            e.preventDefault();
            errorDiv.innerText = "Please select a question format.";
            return;
        }

        if (format.value === "multiple") {
            const choices = document.querySelectorAll("#choices input[name^='choiceText']");
            const corrects = document.querySelectorAll("#choices input[name^='isCorrect']:checked");

            const validChoices = Array.from(choices).filter(c => c.value.trim() !== "");

            if (validChoices.length < 2) {
                e.preventDefault();
                errorDiv.innerText = "Please provide at least 2 valid choices.";
                return;
            }

            if (corrects.length === 0) {
                e.preventDefault();
                errorDiv.innerText = "Please mark at least one correct answer.";
                return;
            }

            validChoices.forEach(c => c.value = c.value.trim());
        }

        contentField.value = content;
        const explanation = document.querySelector("textarea[name='explanation']");
        explanation.value = explanation.value.trim();
    });
</script>
<!-- Toast script -->
<%
    String toastNotification = (String) session.getAttribute("toastNotification");
    if (toastNotification != null) {
        boolean isSuccess = toastNotification.contains("successfully");
        session.removeAttribute("toastNotification");
%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toastElement = document.getElementById('toast');
        const toastElementBody = toastElement.querySelector('.toast-body');
        toastElementBody.textContent = "<%= toastNotification %>";
        toastElement.classList.remove('<%= isSuccess ? "text-bg-danger" : "text-bg-success" %>');
        toastElement.classList.add('<%= isSuccess ? "text-bg-success" : "text-bg-danger" %>');
        const toast = new bootstrap.Toast(toastElement, { autohide: true, delay: 2000 });
        toast.show();
    });
</script>
<% } %>
</body>
</html>
