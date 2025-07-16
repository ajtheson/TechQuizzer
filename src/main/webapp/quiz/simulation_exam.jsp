<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 06/06/2025
  Time: 4:22 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simulation Exam</title>
</head>
<body>

<jsp:include page="../common/headload.jsp"/>
<jsp:include page="../common/jsload.jsp"/>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../user/user_profile.jsp"/>


<div class="container" style="margin-top: 100px">

    <%-- Trên table: select + search --%>
    <div class="d-flex justify-content-between">
        <div class="d-flex mb-3 gap-3">
            <select id="subjectList" class="form-select w-auto">
                <option value="all">All Subjects</option>
                <c:forEach var="subject" items="${requestScope.registrationSubjects}">
                    <option ${requestScope.filter == subject.getId() ? 'selected' : ''}
                            value="${subject.getId()}">${subject.getName()}</option>
                </c:forEach>
            </select>
            <div class="input-group w-auto">
                <input id="searchInput" type="text" class="form-control" placeholder="Search by name...">
                <button id="searchBtn" class="btn btn-primary" type="button">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>

        <div class="dropdown">
            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                <i class="bi bi-justify"></i>
            </a>

            <ul class="dropdown-menu">
                <li style="margin-left: 10px">
                    <input id="id" class="form-check-input" type="checkbox" value="" checked>
                    <label for="id" class="form-check-label">ID</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="subject" class="form-check-input" type="checkbox" value="" checked>
                    <label for="subject" class="form-check-label">Subject</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="name" class="form-check-input" type="checkbox" value="" checked>
                    <label for="name" class="form-check-label">Simulation Exam</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="level" class="form-check-input" type="checkbox" value="" checked>
                    <label for="level" class="form-check-label">Level</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="question" class="form-check-input" type="checkbox" value="" checked>
                    <label for="question" class="form-check-label"># Question</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="duration" class="form-check-input" type="checkbox" value="" checked>
                    <label for="duration" class="form-check-label">Duration</label>
                </li>
                <li style="margin-left: 10px">
                    <input id="passRate" class="form-check-input" type="checkbox" value="" checked>
                    <label for="passRate" class="form-check-label">Pass Rate</label>
                </li>
            </ul>
        </div>
    </div>


    <%-- Table --%>
    <div class="table-wrapper" style="min-height: 500px">
        <table class="table table-striped">
            <thead>
            <tr>
                <th id="col_id" scope="col">ID</th>
                <th id="col_subject" scope="col">Subject</th>
                <th id="col_name" scope="col">Simulation Exam</th>
                <th id="col_level" scope="col">Level</th>
                <th id="col_question" scope="col"># Question</th>
                <th id="col_duration" scope="col">Duration</th>
                <th id="col_passRate" scope="col">Pass Rate (%)</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <c:if test="${not empty requestScope.quizzes}">
                <c:forEach var="quiz" items="${requestScope.quizzes}">
                    <tr>
                        <th id="row_id" scope="row">${quiz.getId()}</th>
                        <td id="row_subject">${quiz.getSubject().getName()}</td>
                        <td id="row_name">${quiz.getName()}</td>
                        <td id="row_level">${quiz.getQuestionLevel().getName()}</td>
                        <td id="row_question">${quiz.getQuizSetting().getNumberOfQuestions()}</td>
                        <td id="row_duration">${quiz.getDuration()}</td>
                        <td id="row_passRate">${quiz.getPassRate()}</td>
                        <td>
                            <a href="simulation-exam/detail?id=${quiz.getId()}"
                               class="btn btn-outline-secondary">Take</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.quizzes}">
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
                           href="?page=${requestScope.page - 1}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Previous</a>
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
                                       href="?page=${i}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <li class="page-item ${requestScope.page == requestScope.totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${requestScope.page + 1}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

</div>


<jsp:include page="../layout/footer.jsp"/>

</body>

<script>
    const filter = ${requestScope.filter};
    const size = ${requestScope.size};
    const search = "${requestScope.search}";

    document.getElementById("sizeBtn").addEventListener("click", (e) => {
        let url = "?page=1&size=" + document.getElementById("sizeInput").value;
        if (filter !== 0) {
            url += "&filter=" + filter;
        }
        if (search.length !== 0) {
            url += "&search=" + search
        }
        window.location.href = url
    });

    document.getElementById("subjectList").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (e.target.value !== "all") {
            url += "&filter=" + e.target.value
        }
        if (search.length !== 0) {
            url += "&search=" + search
        }
        window.location.href = url
    });

    document.getElementById("searchBtn").addEventListener("click", (e) => {
        let searchInput = document.getElementById("searchInput").value.trim()
        let url = "?page=1&size=" + size
        if (filter !== 0) {
            url += "&filter=" + filter;
        }
        if (searchInput.length !== 0) {
            url += "&search=" + searchInput
        }
        window.location.href = url
    });

    document.querySelectorAll('.dropdown-menu label').forEach(label => {
        label.addEventListener('click', function (e) {
            e.stopPropagation();
        });
    });

    document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
        checkbox.addEventListener('change', (e) => {
            const id = e.target.id
            const checked = e.target.checked
            const th = document.getElementById('col_' + id);
            th.style.display = checked ? '' : 'none';
            document.querySelectorAll("#row_" + id).forEach(td => td.style.display = checked ? '' : 'none');

            let checkedCheckboxes = Array.from(document.querySelectorAll('input[type="checkbox"]')).filter(cb => cb.checked);
            if (checkedCheckboxes.length === 1) {
                checkedCheckboxes[0].setAttribute("disabled", "true");
            } else {
                let disabledCheckbox = document.querySelector('input[type="checkbox"][disabled]');
                if (disabledCheckbox) {
                    disabledCheckbox.removeAttribute("disabled");
                }
            }
        });
    });


</script>

</html>
