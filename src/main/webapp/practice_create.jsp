<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 10/06/2025
  Time: 6:44 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Practice</title>
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
</head>
<body>
<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<button onclick="window.history.back(); return false;" class="btn btn-outline-secondary"
        style="position: fixed; left: 50px; top: 100px; z-index: 1000;">
    <i class="bi bi-arrow-left"></i> Back
</button>

<div class="container" style="margin-top: 100px; max-width: 600px;">
    <div class="form-container">
        <h2 class="text-center mb-2">Create New Practice</h2>

        <form id="practiceForm" method="POST" action="${pageContext.request.contextPath}/practices/create">
            <div class="mb-3">
                <label for="name" class="form-label">Practice Name</label>
                <input type="text" class="form-control" id="name" name="name"
                       placeholder="Enter practice name" required>
            </div>

            <div class="mb-3">
                <label for="subjectId" class="form-label">Subject</label>
                <select class="form-select" id="subjectId" name="subjectId" required>
                    <option value="" selected disabled>Select subject</option>
                    <c:forEach var="subject" items="${requestScope.registrationSubjects}">
                        <option value="${subject.getId()}">${subject.getName()}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="numberOfQuestions" class="form-label">Number of Questions</label>
                <input type="number" class="form-control" id="numberOfQuestions"
                       name="numberOfQuestions" min="1" placeholder="Enter number of questions" required>
            </div>

            <div class="mb-3">
                <label class="form-label d-block mb-2">Questions are selected by subject lesson or dimension:</label>
                <div class="form-check form-check-inline" style="margin-right: 100px">
                    <label class="form-check-label" for="byDimension">Dimension</label>
                    <input class="form-check-input" type="radio" name="selectionType"
                           id="byDimension" value="dimension" checked>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="byLesson">Lesson</label>
                    <input class="form-check-input" type="radio" name="selectionType"
                           id="byLesson" value="lesson">
                </div>
            </div>

            <div class="mb-3" id="dimensionSection">
                <label for="subjectDimensionIds" class="form-label">Subject Dimension</label>
                <select class="form-select" id="subjectDimensionIds" name="subjectDimensionId" required>
                    <option value="" disabled selected>Select dimension</option>
                </select>
            </div>

            <div class="mb-3 d-none" id="lessonSection">
                <label for="subjectLessonIds" class="form-label">Subject Lesson</label>
                <select class="form-select" id="subjectLessonIds" name="subjectLessonId">
                    <option value="" disabled selected>Select lesson</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="questionLevelIds" class="form-label">Question Level</label>
                <select class="form-select" id="questionLevelIds" name="questionLevelIds"
                        data-placeholder="Select question level" multiple required>
                    <c:forEach var="level" items="${requestScope.questionLevels}">
                        <option value="${level.getId()}">${level.getName()}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary w-100 p-1">Practice</button>
            </div>
        </form>
    </div>
</div>

<script>

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

    //show dimension select list when dimension radio is clicked and hide lesson select list
    dimensionRadioBtn.addEventListener("click", (e) => {
        dimensionSection.classList.remove("d-none")
        lessonSection.classList.add("d-none")
        lessonSelect.removeAttribute("required");
        dimensionSelect.setAttribute("required", "");
    });

    //show lesson select list when lesson radio is clicked and hide dimension select list
    lessonRadioBtn.addEventListener("click", (e) => {
        lessonSection.classList.remove("d-none")
        dimensionSection.classList.add("d-none")
        dimensionSelect.removeAttribute("required");
        lessonSelect.setAttribute("required", "");
    });

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

    //init select multiple
    $('#questionLevelIds').select2({
        theme: "bootstrap-5",
        width: '100%',
        placeholder: 'Select question level',
        closeOnSelect: false,
    });

    //validate name with many spaces
    document.getElementById("practiceForm").addEventListener("submit", function (e) {
        const nameInputElement = document.getElementById("name");
        const nameValue = nameInputElement.value.trim();
        if (nameValue === "") {
            e.preventDefault();
            nameInputElement.classList.add("is-invalid");
            if (!document.getElementById("name-error")) {
                const errorDiv = document.createElement("div");
                errorDiv.id = "name-error";
                errorDiv.classList.add("text-danger", "mt-1");
                errorDiv.textContent = "Practice name cannot be empty or just spaces.";
                nameInputElement.parentNode.appendChild(errorDiv);
            }
        }
    });

</script>
</body>
</html>
