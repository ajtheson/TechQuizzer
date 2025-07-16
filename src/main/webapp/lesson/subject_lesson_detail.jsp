<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 05/07/2025
  Time: 3:15 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Lesson Detail</title>
</head>
<body class="app sidebar-mini">

<jsp:include page="../layout/manage/header.jsp"/>
<jsp:include page="../layout/manage/sidebar.jsp"/>

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-journal-text"></i> Lesson Detail</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="lesson-list">Lessons</a></li>
            <li class="breadcrumb-item active">Detail</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <!-- Thông tin chi tiết Lesson -->
                    <p><strong>Name:</strong> ${lesson.name}</p>
                    <p><strong>Order:</strong> ${lesson.order}</p>
                    <p><strong>Topic:</strong> ${lesson.topic}</p>
                    <p><strong>Lesson Type:</strong> ${lesson.lessonType.name}</p>
                    <p><strong>Subject:</strong> ${lesson.subjectDTO.name}</p>

                    <c:if test="${currentUser != null && currentUser.roleId == 1}">
                        <p><strong>Expert:</strong> ${lesson.subjectDTO.ownerName}</p>
                    </c:if>

                    <p><strong>Status:</strong>
                        <c:choose>
                            <c:when test="${lesson.status}">
                                <span class="badge bg-success">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <p><strong>Content:</strong> ${lesson.content}</p>

                    <!-- Video Preview không viền, không bảng -->
                    <div class="mt-4">
                        <p><strong>Video:</strong></p>
                        <c:choose>
                            <c:when test="${fn:endsWith(lesson.videoLink, '.mp4')}">
                                <video width="100%" height="360" controls>
                                    <source src="${pageContext.request.contextPath}/${lesson.videoLink}" type="video/mp4">
                                    Your browser does not support the video tag.
                                </video>
                            </c:when>

                            <c:when test="${fn:contains(lesson.videoLink, 'youtube.com/watch?v=')}">
                                <c:set var="embedLink" value="${fn:replace(lesson.videoLink, 'watch?v=', 'embed/')}" />
                                <iframe width="100%" height="360"
                                        src="${embedLink}" frameborder="0"
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                        allowfullscreen>
                                </iframe>
                            </c:when>

                            <c:otherwise>
                                <p>No preview available</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Button -->
                    <div class="mt-3">
                        <a href="subject-lesson" class="btn btn-secondary">Back to List</a>
                        <a style="color: white" href="lesson-edit?id=${lesson.id}" class="btn btn-warning">Edit Lesson</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="../common/jsload.jsp" %>
</body>
</html>

