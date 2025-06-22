<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 19-Jun-25
  Time: 5:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="./common/headload.jsp" %>
    <title>Question List</title>
</head>
<jsp:include page="./user_profile.jsp"/>
<body class="app sidebar-mini">
<jsp:include page="./layout/manage/header.jsp"/>

<jsp:include page="./layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="question"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi-question-circle"></i> Manage Questions</h1>
            <p>View, filter, and manage questions by subject, lesson, level, and more</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <%--Filter--%>
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                            <div class="d-flex flex-column gap-2 align-items-start">
                                <a class="btn btn-primary mb-3 w-auto" type="button" href="create-question">+ Add New
                                    Question</a>

                                <%--Items per page--%>
                                <div class="d-flex align-items-center me-3">
                                    <label for="size" class="me-2 mb-0">Items per page:</label>
                                    <input type="number" min="1" name="size" class="form-control-sm me-2"
                                           style="width: 80px;"
                                           value="${requestScope.size != 10 ? requestScope.size : 10}" id="sizeInput">
                                    <button type="submit" class="btn btn-primary btn-sm" id="sizeBtn">Apply</button>
                                </div>
                            </div>
                            <div class="d-flex flex-column gap-2">
                                <!-- Filter selects -->
                                <div class="d-flex gap-2 px-3">
                                    <select id="subjectFilter" class="form-select">
                                        <option value="0" selected>Subject</option>
                                        <c:forEach items="${requestScope.subjects}" var="subject">
                                            <option value="${subject.id}"  ${requestScope.subjectId == subject.id ? 'selected' : ''}>${subject.name}</option>
                                        </c:forEach>
                                    </select>
                                    <select id="dimensionFilter" class="form-select">
                                        <option value="0" selected>Dimension</option>
                                        <c:forEach items="${requestScope.dimensions}" var="dimension">
                                            <option value="${dimension.id}" ${dimension.id == requestScope.dimensionId ? 'selected' : ''}>
                                                    ${dimension.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select id="lessonFilter" class="form-select">
                                        <option value="0" selected>Lesson</option>
                                        <c:forEach items="${requestScope.lessons}" var="lesson">
                                            <option value="${lesson.id}" ${lesson.id == requestScope.lessonId ? 'selected' : ''}>
                                                    ${lesson.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select id="levelFilter" class="form-select">
                                        <option value="0" selected>Level</option>
                                        <c:forEach items="${requestScope.questionLevels}" var="level">
                                            <option value="${level.id}" ${level.id == requestScope.levelId ? 'selected' : ''}>
                                                ${level.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select id="statusFilter" class="form-select">
                                        <option value="" selected>Status</option>
                                        <option value="Show" ${requestScope.status == 'Show' ? 'selected' : ''}>
                                            Show
                                        </option>
                                        <option value="Hide" ${requestScope.status == 'Hide' ? 'selected' : ''}>
                                            Hide
                                        </option>
                                    </select>
                                </div>

                                <!-- Search bar -->
                                <div class="p-3 d-flex justify-content-end">
                                    <div class="input-group rounded shadow-sm" style="width: 500px;">
                                        <input type="search" id="searchInput" class="form-control"
                                               placeholder="Search by content..." value="${requestScope.search}">
                                        <button class="btn btn-primary" type="button" id="searchBtn">Search</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Content</th>
                                <th>Subject</th>
                                <th>Dimension</th>
                                <th>Lesson</th>
                                <th>Level</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.questions}" var="question">
                                <tr>
                                    <td>${question.id}</td>
                                    <td>${question.content}</td>
                                    <td>${question.subjectName}</td>
                                    <td>${question.questionDimensionName}</td>
                                    <td>${question.subjectLessonName}</td>
                                    <td>${question.questionLevelName}</td>
                                    <td>${question.isDeleted ? 'Hide' : 'Show'}</td>
                                    <td>
                                        <a class="btn btn-warning text-white" type="button"
                                           href="edit_question?id=${question.id}">Edit</a>
                                        <form action="toggle-question-status" method="post" style="display: inline;">
                                            <input type="hidden" name="id" value="${question.id}" />
                                            <input type="hidden" name="statusChange" value="${!question.isDeleted}" />

                                            <input type="hidden" name="page" value="${requestScope.page}" />
                                            <input type="hidden" name="size" value="${requestScope.size}" />
                                            <input type="hidden" name="search" value="${requestScope.search}" />
                                            <input type="hidden" name="subjectId" value="${requestScope.subjectId}" />
                                            <input type="hidden" name="dimensionId" value="${requestScope.dimensionId}" />
                                            <input type="hidden" name="lessonId" value="${requestScope.lessonId}" />
                                            <input type="hidden" name="levelId" value="${requestScope.levelId}" />
                                            <input type="hidden" name="status" value="${requestScope.status}" />

                                            <button type="submit" class="btn ${question.isDeleted ? 'btn-secondary' : 'btn-success'}">
                                                    ${question.isDeleted ? 'Hide' : 'Show'}
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="mb-3 d-flex align-items-center justify-content-between">
                        <div>
                            <p>
                                <c:if test="${totalQuestions == 0}">
                                    Showing 0 of 0 item</label>
                                </c:if>
                                <c:if test="${totalQuestions > 0}">
                                    Showing ${size*(page-1)+1} to ${size * page > totalQuestions ? totalQuestions: size * page} of ${totalQuestions} entries</label>
                                </c:if>
                            </p>
                        </div>

                        <%--Page list--%>
                        <nav>
                            <ul class="pagination mb-0">
                                <c:set var="startPage" value="${page - 2}" />
                                <c:set var="endPage" value="${page + 2}" />
                                <c:if test="${startPage < 1}">
                                    <c:set var="startPage" value="1"/>
                                </c:if>
                                <c:if test="${endPage > totalPages}">
                                    <c:set var="endPage" value="${totalPages}"/>
                                </c:if>

                                <c:if test="${page > 1}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${requestScope.page - 1}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.subjectId != 0 ? '&subjectId='.concat(requestScope.subjectId) : ''}${requestScope.dimensionId != 0 ? '&dimensionId='.concat(requestScope.dimensionId) : ''}${requestScope.lessonId != 0 ? '&lessonId='.concat(requestScope.lessonId) : ''}${requestScope.levelId != 0 ? '&levelId='.concat(requestScope.levelId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${i == page ? 'active' : ''}">
                                        <a class="page-link"
                                           href="?page=${i}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.subjectId != 0 ? '&subjectId='.concat(requestScope.subjectId) : ''}${requestScope.dimensionId != 0 ? '&dimensionId='.concat(requestScope.dimensionId) : ''}${requestScope.lessonId != 0 ? '&lessonId='.concat(requestScope.lessonId) : ''}${requestScope.levelId != 0 ? '&levelId='.concat(requestScope.levelId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${page < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${requestScope.page + 1}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.subjectId != 0 ? '&subjectId='.concat(requestScope.subjectId) : ''}${requestScope.dimensionId != 0 ? '&dimensionId='.concat(requestScope.dimensionId) : ''}${requestScope.lessonId != 0 ? '&lessonId='.concat(requestScope.lessonId) : ''}${requestScope.levelId != 0 ? '&levelId='.concat(requestScope.levelId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Toast Notification -->
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

<!-- Essential javascripts for application to work-->
<%@include file="common/jsload.jsp" %>
<!-- Page specific javascripts-->

<script>
    const size = ${requestScope.size};
    const search = "${requestScope.search}";
    const subjectId = ${requestScope.subjectId};
    const dimensionId = ${requestScope.dimensionId};
    const lessonId = ${requestScope.lessonId};
    const levelId = ${requestScope.levelId};
    const status = "${requestScope.status}";

    const subjectFilter = document.getElementById("subjectFilter");
    const dimensionFilter = document.getElementById("dimensionFilter");
    const lessonFilter = document.getElementById("lessonFilter");

    //Handle change item per page
    document.getElementById("sizeBtn").addEventListener("click", (e) => {
        let sizeInput = document.getElementById("sizeInput")
        const sizeValue = parseInt(sizeInput.value.trim());
        const clearErrors = () => {
            const invalidFields = document.querySelectorAll('.is-invalid');
            invalidFields.forEach(field => field.classList.remove('is-invalid'));

            const errorMessages = document.querySelectorAll('.text-danger.mt-1');
            errorMessages.forEach(msg => msg.remove());
        };
        clearErrors();
        if(isNaN(sizeValue) || sizeValue < 1 || sizeValue > 50){
            sizeInput.classList.add("is-invalid");
            if (!document.getElementById("size-error")) {
                const errorDiv = document.createElement("div");
                errorDiv.id = "size-error";
                errorDiv.classList.add("text-danger", "mt-1");
                errorDiv.textContent = "Size must be between 1 and 50";
                sizeInput.parentNode.parentNode.appendChild(errorDiv);
                sizeInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                sizeInput.focus();
            }
        }
        else {
            let url = "?page=1&size=" + sizeValue;
            if (search.length > 0) {
                url += "&search=" + search
            }
            if (subjectId !== 0) {
                url += "&subjectId=" + subjectId
            }
            if (dimensionId !== 0) {
                url += "&dimensionId=" + dimensionId
            }
            if (lessonId !== 0) {
                url += "&lessonId=" + lessonId
            }
            if (levelId !== 0) {
                url += "&levelId=" + levelId
            }
            if (status.length > 0) {
                url += "&status=" + status
            }
            window.location.href = url
        }
    });

    //Handle search by content
    document.getElementById("searchBtn").addEventListener("click", (e) => {
        let searchInput = document.getElementById("searchInput").value.trim()
        let url = "?page=1&size=" + size
        if (searchInput.length > 0) {
            url += "&search=" + searchInput
        }
        if (subjectId !== 0) {
            url += "&subjectId=" + subjectId
        }
        if (dimensionId !== 0) {
            url += "&dimensionId=" + dimensionId
        }
        if (lessonId !== 0) {
            url += "&lessonId=" + lessonId
        }
        if (levelId !== 0) {
            url += "&levelId=" + levelId
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Handle filter questions by subject
    subjectFilter.addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (e.target.value != null) {
            url += "&subjectId=" + e.target.value
        }
        if (dimensionId !== 0) {
            url += "&dimensionId=" + dimensionId
        }
        if (lessonId !== 0) {
            url += "&lessonId=" + lessonId
        }
        if (levelId !== 0) {
            url += "&levelId=" + levelId
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Handle filter questions by dimension
    dimensionFilter.addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (subjectId !== 0) {
            url += "&subjectId=" + subjectId
        }
        if (e.target.value != null) {
            url += "&dimensionId=" + e.target.value
        }
        if (lessonId !== 0) {
            url += "&lessonId=" + lessonId
        }
        if (levelId !== 0) {
            url += "&levelId=" + levelId
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Prevent select dimension option when subject hasn't chosen yet
    dimensionFilter.addEventListener("click", (e) => {
        if(subjectFilter.value.trim() === "0"){
            alert("Please select subject before select dimension");
            return;
        }
    })

    //Handle filter questions by lesson
    lessonFilter.addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (subjectId !== 0) {
            url += "&subjectId=" + subjectId
        }
        if (dimensionId !== 0) {
            url += "&dimensionId=" + dimensionId
        }
        if (e.target.value != null) {
            url += "&lessonId=" + e.target.value
        }
        if (levelId !== 0) {
            url += "&levelId=" + levelId
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Prevent select lesson option when subject hasn't chosen yet
    lessonFilter.addEventListener("click", (e) => {
        if(subjectFilter.value.trim() === "0"){
            alert("Please select subject before select lesson");
            return;
        }
    })

    //Handle filter questions by level
    document.getElementById("levelFilter").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (subjectId !== 0) {
            url += "&subjectId=" + subjectId
        }
        if (dimensionId !== 0) {
            url += "&dimensionId=" + dimensionId
        }
        if (lessonId !== 0) {
            url += "&lessonId=" + lessonId
        }
        if (e.target.value != null) {
            url += "&levelId=" + e.target.value
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Handle filter questions by status
    document.getElementById("statusFilter").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (subjectId !== 0) {
            url += "&subjectId=" + subjectId
        }
        if (dimensionId !== 0) {
            url += "&dimensionId=" + dimensionId
        }
        if (lessonId !== 0) {
            url += "&lessonId=" + lessonId
        }
        if (levelId !== 0) {
            url += "&levelId=" + levelId
        }
        if (e.target.value != null) {
            url += "&status=" + e.target.value
        }
        window.location.href = url
    });

    document.getElementById("searchInput").addEventListener("keypress", function (e) {
        if (e.key === "Enter") {
            document.getElementById("searchBtn").click();
        }
    });

    document.getElementById("searchInput").addEventListener("keypress", function (e) {
        if (e.key === "Enter") {
            document.getElementById("searchBtn").click();
        }
    });

    document.getElementById("sizeInput").addEventListener("keypress", function (e) {
        if (e.key === "Enter") {
            document.getElementById("sizeBtn").click();
        }
    });
</script>
</body>
</html>
