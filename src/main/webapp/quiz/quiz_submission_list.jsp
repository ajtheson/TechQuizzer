<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Quiz Submission</title>
</head>
<body>
<%@include file="../common/jsload.jsp" %>
<jsp:include page="../layout/manage/header.jsp"/>
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="quiz"/>
</jsp:include>
<jsp:include page="../common/headload.jsp"/>
<jsp:include page="../user/user_profile.jsp"/>


<main class="app-content">
    <div class="app-title">
        <div>
            <h1>View Submission</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="list">Quizzes List</a></li>
            <li class="breadcrumb-item active">Submissions List</li>
        </ul>
    </div>

    <%-- Trên table: select + search --%>
    <div class="d-flex justify-content-between">
        <div class="d-flex mb-3 gap-3">
            <div class="input-group w-auto align-items-center">
                <span class="me-2">Filter Date:</span>
                <input id="dateFilter" value="${requestScope.filter != null ? requestScope.filter : ''}" type="date" class="form-control">
            </div>

            <div class="input-group w-auto">
                <input id="searchInput" type="text" class="form-control" placeholder="Search by taker name...">
                <button id="searchBtn" class="btn btn-primary" type="button">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
    </div>


    <%-- Table --%>
    <div class="table-wrapper" style="min-height: 500px">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Quiz Taker Name</th>
                <th>Start Date</th>
                <th>Duration</th>
                <th>Score</th>
                <th></th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <c:if test="${not empty requestScope.submissions}">
                <c:forEach var="submission" items="${requestScope.submissions}">
                    <tr>
                        <td>${submission.getId()}</td>
                        <td>${submission.getUser().getName()}</td>
                        <td>${submission.getStartDate()}</td>
                        <td>${submission.getFormattedDuration()}</td>
                        <td>${submission.numberCorrectQuestions}/${submission.numberOfQuestions}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/quiz/review?examAttemptId=${submission.getId()}"
                               class="btn btn-outline-secondary">Review</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.submissions}">
                <tr>
                    <td colspan="8" class="text-center text-muted">No data</td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <%-- Dưới table: items per page + pagination --%>
        <div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-5">

            <div class="d-flex align-items-center me-3">
                <label for="size" class="me-2 mb-0">Items per page:</label>
                <input type="number" min="1" name="size" class="form-control me-2" style="width: 80px;"
                       value="${requestScope.size}" id="sizeInput">
                <button type="submit" class="btn btn-primary btn-sm" id="sizeBtn">Apply</button>
            </div>

            <nav>
                <ul class="pagination mb-0">
                    <li class="page-item ${requestScope.page == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?id=${requestScope.quizId}&page=${requestScope.page - 1}&size=${requestScope.size}${requestScope.filter != null ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Previous</a>
                    </li>

                    <c:forEach var="i" begin="1" end="${requestScope.totalPages}">
                        <c:choose>
                            <c:when test="${i == requestScope.page}">
                                <li class="page-item active">
                                    <span class="page-link">${i}</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="?id=${requestScope.quizId}&page=${i}&size=${requestScope.size}${requestScope.filter != null ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <li class="page-item ${requestScope.page == requestScope.totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?id=${requestScope.quizId}&page=${requestScope.page + 1}&size=${requestScope.size}${requestScope.filter != null ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

</main>
</body>

<script>
    const filter = '${requestScope.filter}';
    const size = ${requestScope.size};
    const search = "${requestScope.search}";

    document.getElementById("sizeBtn").addEventListener("click", (e) => {
        let url = "?id=${requestScope.quizId}&page=1&size=" + document.getElementById("sizeInput").value;
        if (filter) {
            url += "&filter=" + filter;
        }
        if (search.length !== 0) {
            url += "&search=" + search
        }
        window.location.href = url
    });

    document.getElementById("dateFilter").addEventListener("change", (e) => {
        let url = "?id=${requestScope.quizId}&page=1&size=" + size
        if (e.target.value) {
            url += "&filter=" + e.target.value
        }
        if (search.length !== 0) {
            url += "&search=" + search
        }
        window.location.href = url
    });

    document.getElementById("searchBtn").addEventListener("click", (e) => {
        let searchInput = document.getElementById("searchInput").value.trim()
        let url = "?id=${requestScope.quizId}&page=1&size=" + size
        if (filter) {
            url += "&filter=" + filter;
        }
        if (searchInput.length !== 0) {
            url += "&search=" + searchInput
        }
        window.location.href = url
    });


</script>

</html>
