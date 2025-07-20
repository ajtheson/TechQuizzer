<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 07/07/2025
  Time: 3:11 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Add Lesson</title>
</head>
<body class="app sidebar-mini">
<jsp:include page="../layout/manage/header.jsp"/>
<jsp:include page="../layout/manage/sidebar.jsp"/>

<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-plus-square"></i> Add Lesson</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <c:if test="${currentUser != null && currentUser.roleId == 1}">
                <li class="breadcrumb-item"><a href="list">Lesson List</a></li>
            </c:if>
            <c:if test="${currentUser != null && currentUser.roleId == 2}">
                <li class="breadcrumb-item"><a href="list-for-expert">Lesson List</a></li>
            </c:if>
            <li class="breadcrumb-item active">Add Lesson</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <form action="create" method="post" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label>Name</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label>Topic</label>
                            <input type="text" class="form-control" name="topic" required>
                        </div>

                        <div class="mb-3">
                            <label>Video Source</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="videoType" id="youtubeOption" value="youtube" checked>
                                <label class="form-check-label" for="youtubeOption">YouTube Link</label>
                            </div>
                            <input type="text" class="form-control mt-2" name="videoLink" placeholder="https://youtube.com/..." id="youtubeLink">

                            <div class="form-check mt-3">
                                <input class="form-check-input" type="radio" name="videoType" id="uploadOption" value="upload">
                                <label class="form-check-label" for="uploadOption">Upload MP4</label>
                            </div>
                            <input type="file" class="form-control mt-2" name="videoFile" id="videoFileInput" accept="video/mp4" disabled>
                        </div>

                        <div class="mb-3">
                            <label>Order</label>
                            <input type="number" class="form-control" name="order" required>
                        </div>

                        <div class="mb-3">
                            <label>Content</label>
                            <textarea class="form-control" name="content" rows="5"></textarea>
                        </div>

                        <div class="mb-3">
                            <label>Status</label>
                            <select class="form-select" name="status">
                                <option value="1" selected>Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Subject</label>
                            <select class="form-select" name="subjectId">
                                <c:forEach var="s" items="${subjectList}">
                                    <option value="${s.id}">${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Lesson Type</label>
                            <select class="form-select" name="lessonTypeId">
                                <c:forEach var="lessonType" items="${lessonTypeList}">
                                    <option value="${lessonType.id}">${lessonType.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mt-3">
                            <c:if test="${currentUser != null && currentUser.roleId == 1}">
                                <a href="list" class="btn btn-secondary">Cancel</a>
                            </c:if>
                            <c:if test="${currentUser != null && currentUser.roleId == 2}">
                                <a href="list-for-expert" class="btn btn-secondary">Cancel</a>
                            </c:if>
                            <button type="submit" class="btn btn-primary">Add Lesson</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="../common/jsload.jsp" %>
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
<script>
    // Enable/disable fields based on radio selection
    document.addEventListener("DOMContentLoaded", () => {
        const ytOption = document.getElementById("youtubeOption");
        const uploadOption = document.getElementById("uploadOption");
        const ytInput = document.getElementById("youtubeLink");
        const fileInput = document.getElementById("videoFileInput");

        function toggleInputs() {
            ytInput.disabled = !ytOption.checked;
            fileInput.disabled = !uploadOption.checked;
        }

        ytOption.addEventListener("change", toggleInputs);
        uploadOption.addEventListener("change", toggleInputs);
    });
</script>
</body>
</html>

