<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 22/07/2025
  Time: 5:05 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Lesson Detail</title>
    <jsp:include page="../common/headload.jsp"/>
</head>
<body style="background-color: #f8f9fa">
<jsp:include page="../common/jsload.jsp"/>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../user/user_profile.jsp"/>

<main class="app-content" style="margin-left: 0">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-journal-text"></i> Lesson Detail</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer/lesson-list">My Lessons</a></li>
            <li class="breadcrumb-item active">${lesson.name}</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="tile">
                <div class="tile-body">
                    <!-- Thông tin cơ bản -->
                    <p><strong>Name:</strong> ${lesson.name}</p>
                    <p><strong>Topic:</strong> ${lesson.topic}</p>
                    <p><strong>Lesson Type:</strong> ${lesson.lessonType.name}</p>

                    <!-- Nội dung bài học (Video hoặc Quiz link) -->
                    <c:choose>
                        <c:when test="${fn:toLowerCase(lesson.lessonType.name) == 'lesson'}">
                            <div class="mt-4">
                                <p><strong>Video:</strong></p>
                                <c:choose>
                                    <c:when test="${fn:endsWith(lesson.videoLink, '.mp4')}">
                                        <video width="100%" height="400" controls>
                                            <source src="${pageContext.request.contextPath}/${lesson.videoLink}" type="video/mp4">
                                            Your browser does not support the video tag.
                                        </video>
                                    </c:when>
                                    <c:when test="${fn:contains(lesson.videoLink, 'youtube.com/watch?v=')}">
                                        <c:set var="embedLink" value="${fn:replace(lesson.videoLink, 'watch?v=', 'embed/')}" />
                                        <iframe width="100%" height="400" src="${embedLink}" frameborder="0"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen></iframe>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No video available.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>

                        <c:when test="${fn:toLowerCase(lesson.lessonType.name) == 'quiz'}">
                            <div class="mt-4">
                                <form method="post" action="${pageContext.request.contextPath}/lesson/detail">
                                    <input type="hidden" name="quizId" value="${lesson.quizId}">
                                    <div>
                                        <button type="submit" class="btn btn-primary w-100">Start Quiz</button>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                    </c:choose>

                    <!-- Bài học khác cùng môn -->
                    <c:if test="${not empty otherLessons}">
                        <hr/>
                        <h5 class="mt-4">Other Lessons in this Subject:</h5>
                        <ul class="list-group">
                            <c:forEach var="other" items="${otherLessons}">
                                <c:if test="${other.id != lesson.id}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <span>${other.name}</span>
                                        <a class="btn btn-sm btn-outline-primary"
                                           href="${pageContext.request.contextPath}/customer/lesson-detail?id=${other.id}&subjectId=${subjectId}">
                                            View
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </c:if>

                    <!-- Nút quay lại -->
                    <div class="mt-4 text-end">
                        <a href="${pageContext.request.contextPath}/subject/detail?subject_id=${subjectId}" class="btn btn-secondary">Back to Subject</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
