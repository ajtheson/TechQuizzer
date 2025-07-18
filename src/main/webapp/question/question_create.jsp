<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 21/06/2025
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>New Question</title>
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
<h2 style="text-align: center; margin-top: 20px">Create Question</h2>
<button onclick="window.history.back(); return false;" class="btn btn-outline-secondary"
        style="position: fixed; left: 50px; top: 100px; z-index: 1000;">
    <i class="bi bi-arrow-left"></i> Back
</button>

<div class="container" style="margin-top: 50px; max-width: 800px">
    <div class="form-container">
        <form id="questionForm" method="post" action="${pageContext.request.contextPath}/management/question/create" enctype="multipart/form-data">
            <div class="row mb-3" style="display: flex">
                <div class="form-group" style="flex: 1">
                    <label for="subjectId" class="form-label">Subject</label>
                    <select class="form-select" id="subjectId" name="subjectId" required>
                        <option value="" selected disabled>Select Subject</option>
                        <c:forEach var="subject" items="${requestScope.registrationSubjects}">
                            <option value="${subject.getId()}">${subject.getName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" style="flex: 1" id="dimensionSection">
                    <label for="subjectDimensionIds" class="form-label">Dimension</label>
                    <select class="form-select" id="subjectDimensionIds" name="subjectDimensionId">
                        <option value="" selected>None</option>
                    </select>
                </div>
                <div class="form-group" style="flex: 1" id="lessonSection">
                    <label for="subjectLessonIds" class="form-label">Subject Lesson</label>
                    <select class="form-select" id="subjectLessonIds" name="subjectLessonId">
                        <option value="" selected>None</option>
                    </select>
                </div>
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Level</label>
                    <select name="questionLevelId" class="form-select" required>
                        <c:forEach var="level" items="${requestScope.questionLevels}">
                            <option value="${level.getId()}">${level.getName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select" required>
                        <option value="activate">Activate</option>
                        <option value="inactivate">Inactivate</option>
                    </select>
                </div>
            </div>

            <!-- Question Content  -->
            <div class="mb-3">
                <label class="form-label">Question Content</label>
                <textarea
                        name="content"
                        rows="3"
                        class="form-control"
                        placeholder="Enter question content"
                ></textarea>
            </div>

            <!-- Question Media -->
            <div class="mb-3">
                <label class="form-label">Question Media</label>
                <div class="border rounded p-3 d-flex flex-column justify-content-between">
                    <div id="media-list" class="media-name mb-2"></div>
                    <div class="text-end">
                        <button type="button" class="btn btn-secondary btn-sm" onclick="openMediaPopup()">
                            Add Media
                        </button>
                    </div>
                </div>
            </div>

            <!-- Hidden Media Metadata Inputs -->
            <div id="media-metadata-container"></div>

            <!-- Media Hidden Files Input -->
            <input type="file" name="media" id="media-hidden" multiple hidden>



            <div class="mb-3">
                <label class="form-label">Question Format</label><br/>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="format" value="multiple"
                           onclick="toggleChoice(true)"/>
                    <label class="form-check-label">Multiple Choice</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="format" value="essay"
                           onclick="toggleChoice(false)"/>
                    <label class="form-check-label">Essay</label>
                </div>
            </div>

            <!-- Choice Section with border -->
            <div id="choice-section" class="mb-3" style="display: none">
                <div class="border rounded p-3">
                    <label class="form-label">Answer Options</label>
                    <div id="choices">
                        <div class="input-group mb-2">
                            <input type="text" name="choiceText0" class="form-control" placeholder="Enter choice"/>
                            <div class="input-group-text">
                                <input type="checkbox" name="isCorrect0" class="form-check-input"/>
                            </div>
                            <button class="btn btn-outline-danger" type="button" onclick="removeChoice(this)">Remove
                            </button>
                        </div>
                    </div>
                    <button type="button" class="btn btn-success btn-sm mt-2" onclick="addChoice()">Add new choice
                    </button>
                </div>
            </div>

            <!-- Explanation -->
            <div class="mb-3">
                <label class="form-label">Explanation</label>
                <textarea
                        name="explanation"
                        rows="3"
                        class="form-control"
                        placeholder="Enter explanation"
                ></textarea>
            </div>

            <!-- Error -->
            <div id="error" class="text-danger mb-3"></div>

            <!-- Buttons -->
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button type="button" class="btn btn-secondary">Cancel</button>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
        </form>
    </div>
</div>

<!-- Media Popup -->
<div id="media-popup">
    <h5>Add Media</h5>
    <div class="mb-2">
        <label class="form-label">Media Type</label>
        <select id="mediaType" class="form-select">
            <option value="image">Image</option>
            <option value="video">Video</option>
            <option value="audio">Audio</option>
        </select>
    </div>
    <div class="mb-2">
        <input type="file" id="mediaFile" class="form-control"/>
    </div>
    <div class="mb-2">
        <textarea
                id="mediaDesc"
                class="form-control"
                placeholder="Description (optional)"
        ></textarea>
    </div>
    <div class="d-flex justify-content-end gap-2">
        <button class="btn btn-success" onclick="addMedia()">Add</button>
        <button class="btn btn-secondary" onclick="closeMediaPopup()">Cancel</button>
    </div>
</div>


<script>
    function toggleChoice(show) {
        document.getElementById("choice-section").style.display = show
            ? "block"
            : "none";
    }

    let choiceIndex = 1;

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

        // Chặn file trùng tên
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

        dimensionSelect.innerHTML = "<option value=''  selected>None</option>";
        lessonSelect.innerHTML = "<option value=''  selected>None</option>";

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
</body>
</html>
