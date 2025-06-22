<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 13-Jun-25
  Time: 8:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="./common/headload.jsp" %>
    <title>Subject List</title>
</head>
<jsp:include page="./user_profile.jsp"/>
<body class="app sidebar-mini">
<jsp:include page="./layout/manage/header.jsp"/>

<jsp:include page="./layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="subject"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi-journal-bookmark"></i> Manage Subject</h1>
            <p>View, assign, and manage subjects available in the system</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <%--Filter--%>
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                            <div class="mt-auto">
                                <c:if test="${sessionScope.user.roleName == 'Admin'}">
                                    <a class="btn btn-primary mb-3" type="button" href="create-subject">+ Add New Subject</a>
                                </c:if>

                                <%--Items per page--%>
                                <div class="d-flex align-items-center me-3">
                                    <label for="size" class="me-2 mb-0">Items per page:</label>
                                    <input type="number" min="1" name="size" class="form-control-sm me-2" style="width: 80px;"
                                           value="${requestScope.size != 5 ? requestScope.size : 5}" id="sizeInput">
                                    <button type="submit" class="btn btn-primary btn-sm" id="sizeBtn">Apply</button>
                                </div>
                            </div>
                            <div class="d-flex flex-column gap-2">
                                <!-- Filter selects -->
                                <div class="d-flex gap-2 px-3">
                                    <select id="categoryList" class="form-select" style="width: 200px;">
                                        <option value="0" ${requestScope.categoryId == 0 ? 'selected' : ''}>Subject
                                            category
                                        </option>
                                        <c:forEach items="${requestScope.categories}" var="category">
                                            <option value="${category.id}"  ${requestScope.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    <select id="statusFilter" class="form-select" style="width: 200px;">
                                        <option value="" ${requestScope.status == '' ? 'selected' : ''}>Status</option>
                                        <option value="Published" ${requestScope.status == 'Published' ? 'selected' : ''}>
                                            Published
                                        </option>
                                        <option value="Unpublished" ${requestScope.status == 'Unpublished' ? 'selected' : ''}>
                                            Unpublished
                                        </option>
                                    </select>
                                </div>

                                <!-- Search bar -->
                                <div class="p-3">
                                    <div class="input-group rounded shadow-sm">
                                        <input type="search" id="searchInput" class="form-control"
                                               placeholder="Search by name..." value="${requestScope.search}">
                                        <button class="btn btn-primary" type="button" id="searchBtn">Search</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Subject ID</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Number of lessons</th>
                                <th>Owner</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${requestScope.totalSubjects == 0}">
                                    <tr>
                                        <td colspan="7" class="text-center">
                                            No matching record found
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${requestScope.subjects}" var="subject">
                                        <tr>
                                            <td>${subject.id}</td>
                                            <td>${subject.name}</td>
                                            <td>${subject.categoryName}</td>
                                            <td>${subject.numberOfLesson}</td>
                                            <td>${subject.ownerName}</td>
                                            <td>${subject.published ? 'Published' : 'Unpublished'}</td>
                                            <td>
                                                <a class="btn btn-warning text-white" type="button"
                                                   href="edit-subject?subject_id=${subject.id}">Edit</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <div class="mb-3 d-flex align-items-center justify-content-between">
                        <div>
                            <p>
                                <c:if test="${requestScope.totalSubjects == 0}">
                                    Showing 0 of 0 item</label>
                                </c:if>
                                <c:if test="${requestScope.totalSubjects > 0}">
                                    Showing ${size*(page-1)+1} to ${size * page > totalSubjects ? totalSubjects: size * page} of ${totalSubjects} entries</label>
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
                                           href="?page=${requestScope.page - 1}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${i == page ? 'active' : ''}">
                                        <a class="page-link"
                                           href="?page=${i}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${page < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${requestScope.page + 1}&size=${requestScope.size}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}${not empty requestScope.status ? '&status='.concat(requestScope.status) : ''}">Next</a>
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
    const categoryId = ${requestScope.categoryId};
    const status = "${requestScope.status}";

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
        else{
            let url = "?page=1&size=" + sizeValue;
            if (search.length > 0) {
                url += "&search=" + search
            }
            if (categoryId !== 0) {
                url += "&categoryId=" + categoryId
            }
            if (status.length > 0) {
                url += "&status=" + status
            }
            window.location.href = url
        }
    });

    //Handle search by name
    document.getElementById("searchBtn").addEventListener("click", (e) => {
        let searchInput = document.getElementById("searchInput").value.trim()
        let url = "?page=1&size=" + size
        if (searchInput.length > 0) {
            url += "&search=" + searchInput
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Handle filter subject by category
    document.getElementById("categoryList").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (e.target.value != null) {
            url += "&categoryId=" + e.target.value
        }
        if (status.length > 0) {
            url += "&status=" + status
        }
        window.location.href = url
    });

    //Handle filter subject by status
    document.getElementById("statusFilter").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
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

    document.getElementById("sizeInput").addEventListener("keypress", function (e) {
        if (e.key === "Enter") {
            document.getElementById("sizeBtn").click();
        }
    });
</script>
</body>
</html>