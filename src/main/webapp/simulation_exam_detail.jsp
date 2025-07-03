<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 09/06/2025
  Time: 7:37 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simulation Exam Detail</title>
</head>
<body>

<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<button onclick="window.history.back(); return false;" class="btn btn-outline-secondary"
        style="position: fixed; left: 50px; top: 100px; z-index: 1000;">
    <i class="bi bi-arrow-left"></i> Back
</button>

<div class="container" style="margin-top: 100px">

    <h2 class="text-center mb-4">Exam Detail #${requestScope.quiz.getId()}</h2>

    <div class="mx-auto" style="max-width: 720px;">
        <div class="row g-3">
            <div class="col-6 mb-3">
                <label for="examTitle" class="form-label">Subject</label>
                <input type="text" class="form-control" value="${requestScope.quiz.getSubject().getName()}" disabled>
            </div>
            <div class="col-6 mb-3">
                <label for="examTitle" class="form-label">Simulation Exam</label>
                <input type="text" class="form-control" value="${requestScope.quiz.getName()}" disabled>
            </div>
            <div class="col-6 mb-3">
                <label for="duration" class="form-label">Level</label>
                <input type="text" class="form-control" value="${requestScope.quiz.getQuestionLevel().getName()}" disabled>
            </div>
            <div class="col-6 mb-3">
                <label for="duration" class="form-label">Duration (minutes)</label>
                <input type="text" class="form-control" value="${requestScope.quiz.getDuration()}" disabled>
            </div>
            <div class="col-6 mb-3">
                <label for="duration" class="form-label"># Questions</label>
                <input type="text" class="form-control"
                       value="${requestScope.quiz.getQuizSetting().getNumberOfQuestions()}" disabled>
            </div>
            <div class="col-6 mb-3">
                <label for="duration" class="form-label">Pass rate (%)</label>
                <input type="text" class="form-control" value="${requestScope.quiz.getPassRate()}" disabled>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/simulation-exam/detail">
                <input type="hidden" name="quizId" value="${requestScope.quiz.getId()}">
                <div class="col-12">
                    <button type="submit" class="btn btn-primary w-100">Start</button>
                </div>
            </form>

        </div>
    </div>
</div>


</body>
</html>
