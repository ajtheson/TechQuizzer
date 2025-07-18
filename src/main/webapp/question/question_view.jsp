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
    <jsp:include page="../common/headload.jsp"/>
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
                                    <img src="${pageContext.request.contextPath}/assets/files/media/${question.id}/${m.link}"
                                         style="max-width: 100%; height: auto;"/>
                                </c:when>
                                <c:when test="${m.type == 'video'}">
                                    <video src="${pageContext.request.contextPath}/assets/files/media/${question.id}/${m.link}" controls
                                           style="max-width: 100%;"></video>
                                </c:when>
                                <c:when test="${m.type == 'audio'}">
                                    <audio src="${pageContext.request.contextPath}/assets/files/media/${question.id}/${m.link}" controls></audio>
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
                <a href="${pageContext.request.contextPath}/management/question/edit?id=${question.id}" class="btn btn-success">Update</a>
                <c:if test="${question.status}"><a href="${pageContext.request.contextPath}/management/question/toggle_question_status?id=${question.id}&mode=deactivate" class="btn btn-secondary" style="margin-left: 10px">Deactivate</a></c:if>
                <c:if test="${!question.status}"><a href="${pageContext.request.contextPath}/management/question/toggle_question_status?id=${question.id}&mode=activate" class="btn btn-secondary" style="margin-left: 10px">Activate</a></c:if>
            </div>

        </form>
    </div>
</div>
</body>
</html>
