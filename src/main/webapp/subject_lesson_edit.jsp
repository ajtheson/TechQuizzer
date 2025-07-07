<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 06/07/2025
  Time: 1:52 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="./common/headload.jsp"/>
    <title>Edit Lesson</title>
</head>
<body class="app sidebar-mini">
<jsp:include page="./layout/manage/header.jsp"/>
<jsp:include page="./layout/manage/sidebar.jsp"/>

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-pencil-square"></i> Edit Lesson</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="lesson-list">Lesson List</a></li>
            <li class="breadcrumb-item active">Edit Lesson</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <form action="lesson-edit" method="post">
                        <input type="hidden" name="id" value="${lesson.id}">

                        <div class="mb-3">
                            <label>Name</label>
                            <input type="text" class="form-control" name="name" value="${lesson.name}" required>
                        </div>

                        <div class="mb-3">
                            <label>Topic</label>
                            <input type="text" class="form-control" name="topic" value="${lesson.topic}" required>
                        </div>

                        <div class="mb-3">
                            <label>Video Link</label>
                            <input type="text" class="form-control" name="videoLink" value="${lesson.videoLink}">
                        </div>

                        <div class="mb-3">
                            <label>Order</label>
                            <input type="number" class="form-control" name="order" value="${lesson.order}" required>
                        </div>

                        <div class="mb-3">
                            <label>Content</label>
                            <textarea class="form-control" name="content" rows="5">${lesson.content}</textarea>
                        </div>

                        <div class="mb-3">
                            <label>Status</label>
                            <select class="form-select" name="status">
                                <option value="1" ${lesson.status == true ? 'selected' : ''}>Active</option>
                                <option value="0" ${lesson.status == false ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <c:if test="${currentUser != null && currentUser.roleId == 1}">
                                <label>Expert:</label>
                                <select class="form-control" id="owner" name="ownerId" required>
                                    <option value="">--Choose owner--</option>
                                    <c:forEach items="${requestScope.experts}" var="expert">
                                        <option value="${expert.id}" <c:if test="${expert.name eq lesson.subjectDTO.ownerName}">selected</c:if> >${expert.name}</option>
                                    </c:forEach>
                                </select>
                            </c:if>
                            <c:if test="${currentUser != null && currentUser.roleId == 2}">
                                <label>Expert:</label>
                                <select class="form-control" id="owner" name="ownerId" disabled>
                                    <option value="">--Choose owner--</option>
                                    <c:forEach items="${requestScope.experts}" var="expert">
                                        <option value="${expert.id}" <c:if test="${expert.name eq lesson.subjectDTO.ownerName}">selected</c:if> >${expert.name}</option>
                                    </c:forEach>
                                    <input type="hidden" name="ownerId" value="${lesson.subjectDTO.ownerId}" />
                                </select>
                            </c:if>
                        </div>
                        <div class="mb-3">
                            <label>Subject</label>
                            <select class="form-select" name="subjectId">
                                <c:forEach var="s" items="${subjectList}">
                                    <option value="${s.id}" ${lesson.subject.id == s.id ? 'selected' : ''}>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Lesson Type</label>
                            <select class="form-select" name="lessonTypeId">
                                <c:forEach var="lessonType" items="${lessonTypeList}">
                                    <option value="${lessonType.id}" ${lesson.lessonType.id == lessonType.id ? 'selected' : ''}>${lessonType.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mt-3">
                            <c:if test="${currentUser != null && currentUser.roleId == 1}">
                                <a href="subject-lesson" class="btn btn-secondary">Cancel</a>
                            </c:if>
                            <c:if test="${currentUser != null && currentUser.roleId == 2}">
                                <a href="subject-lesson-expert" class="btn btn-secondary">Cancel</a>
                            </c:if>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="toast" class="toast align-items-center border-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <!-- Message will be injected here -->
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<%@ include file="common/jsload.jsp" %>
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

        const toast = new bootstrap.Toast(toastElement, {
            autohide: true,
            delay: 2000
        });
        toast.show();
    });
</script>
<%
    }
%>

</body>
</html>

