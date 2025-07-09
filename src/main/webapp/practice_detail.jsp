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
        <h2 class="text-center mb-2">Practice Detail #${requestScope.practice.getId()}</h2>

        <form id="practiceForm" method="POST" action="${pageContext.request.contextPath}/practice/detail">
            <input type="hidden" name="practiceId" value="${requestScope.practice.getId()}">

            <div class="mb-3">
                <label for="name" class="form-label">Practice Name</label>
                <input type="text" class="form-control" id="name" name="name" value="${requestScope.practice.getName()}" disabled>
            </div>

            <div class="mb-3">
                <label for="subjectId" class="form-label">Subject</label>
                <select class="form-select" id="subjectId" name="subjectId" disabled>
                    <option value="" selected disabled>Select subject</option>
                    <c:forEach var="subject" items="${requestScope.registrationSubjects}">
                        <option ${requestScope.practice.getSubject().getId() == subject.getId() ? 'selected' : '' } value="${subject.getId()}">
                                ${subject.getName()}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label d-block mb-2">Exam format:</label>
                <div class="form-check form-check-inline" style="margin-right: 100px">
                    <label class="form-check-label" for="multiple">Multiple choice</label>
                    <input class="form-check-input" type="radio" name="examFormat"
                           id="multiple" value="multiple" disabled
                    ${requestScope.practice.format.equalsIgnoreCase("multiple") ? 'checked' : '' }>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="essay">Essay</label>
                    <input class="form-check-input" type="radio" name="examFormat"
                           id="essay" value="essay" disabled
                    ${requestScope.practice.format.equalsIgnoreCase("essay") ? 'checked' : '' }>
                </div>
            </div>

            <div class="mb-3">
                <label for="numberOfQuestions" class="form-label">Number of Questions</label>
                <input type="number" class="form-control" id="numberOfQuestions"
                       name="numberOfQuestions" value="${requestScope.practice.getNumberOfQuestions()}" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label d-block mb-2">Questions are selected by subject lesson or dimension:</label>
                <div class="form-check form-check-inline" style="margin-right: 100px">
                    <label class="form-check-label" for="byDimension">Dimension</label>
                    <input class="form-check-input" type="radio" name="selectionType"
                           id="byDimension" value="dimension" ${requestScope.practice.getSubjectDimension() != null ? 'checked' : ''} disabled>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="byLesson">Lesson</label>
                    <input class="form-check-input" type="radio" name="selectionType"
                           id="byLesson" value="lesson" ${requestScope.practice.getSubjectLesson() != null ? 'checked' : ''} disabled>
                </div>
            </div>

            <c:if test="${requestScope.practice.getSubjectDimension() != null}">
                <div class="mb-3" id="dimensionSection">
                    <label for="subjectDimensionIds" class="form-label">Subject Dimension</label>
                    <select class="form-select" id="subjectDimensionIds" name="subjectDimensionIds" disabled>
                        <option value="${requestScope.practice.getSubjectDimension().getId()}" selected>${requestScope.practice.getSubjectDimension().getName()}</option>
                    </select>
                </div>
            </c:if>

            <c:if test="${requestScope.practice.getSubjectLesson() != null}">
                <div class="mb-3" id="lessonSection">
                    <label for="subjectLessonIds" class="form-label">Subject Lesson</label>
                    <select class="form-select" id="subjectLessonIds" name="subjectLessonIds" disabled>
                        <option value="${requestScope.practice.getSubjectLesson().getId()}" selected>${requestScope.practice.getSubjectLesson().getName()}</option>
                    </select>
                </div>
            </c:if>

            <div class="mb-3">
                <label for="questionLevelId" class="form-label">Question Level</label>
                <select class="form-select" id="questionLevelId" name="questionLevelId" disabled>
                    <option selected value="${requestScope.practice.getQuestionLevel().getId()}">${requestScope.practice.getQuestionLevel().getName()}</option>
                </select>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary w-100 p-1">Practice Review</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
