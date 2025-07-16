<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 08/06/2025
  Time: 9:26 CH
  To change this template use File | Settings | File Templates.
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Quizzes List</title>
</head>
<style>
    .hidden-columnOfTable { display: none; }
</style>

<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="quiz"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="../user/user_profile.jsp"/>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i></i> Quizzes List</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <div class="mb-3 text-start">
                            <a href="create_quiz" class="btn btn-primary">
                                <i class="bi bi-plus-lg me-1"></i> Add new quizz
                            </a>
                        </div>
                        <form method="get" action="quizzeslist" class="d-flex align-items-center gap-3 mb-3">
                            <select name="subject" class="form-select" style="width: 250px;" onchange="this.form.submit()">
                                <option value="">All Subjects</option>
                                <c:forEach var="subject" items="${subjects}">
                                    <option value="${subject.name}"
                                            <c:if test="${subject.name == selectedSubject}">selected</c:if>>
                                            ${subject.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <select name="testType" class="form-select" style="width: 250px;" onchange="this.form.submit()">
                                <option value="">All Test Type</option>
                                <c:forEach var="testType" items="${testTypes}">
                                    <option value="${testType.name}"
                                            <c:if test="${testType.name == selectedTestType}">selected</c:if>>
                                            ${testType.name}
                                    </option>
                                </c:forEach>
                            </select>

                            <%--                            Test Type: <input type="text" name="testType" value="${testType}">--%>
                            Search: <input type="text" name="search" value="${search}">
                            <input type="hidden" name="sortField" value="${sortField}">
                            <input type="hidden" name="sortOrder" value="${sortOrder}">
                            <input type="hidden" name="pageSize" value="${pageSize}">
                            <input type="submit" value="Search">
                        </form>

                        <form id="pageSizeForm" action="quizzeslist" method="get" class="d-flex align-items-center" style="height: 25px; margin-bottom: 20px;">
                            <span style="margin-right: 5px;">Show</span>
                            <input type="number" name="pageSize" min="1" max="1000" value="${pageSize}"
                                   class="form-control"
                                   style="font-size: 13px; width: 65px; height: 28px; padding: 0 5px; margin: 0 5px;"
                                   placeholder="Page Size"
                                   onkeydown="if(event.key === 'Enter'){ this.form.submit(); }" />
                            <input type="hidden" name="subject" value="${subject}">
                            <input type="hidden" name="testType" value="${testType}">
                            <input type="hidden" name="search" value="${search}">
                            <input type="hidden" name="sortField" value="${sortField}">
                            <input type="hidden" name="sortOrder" value="${sortOrder}">
                            <span>entries</span>
                        </form>
                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert alert-success" role="alert">
                                    ${sessionScope.success}
                            </div>
                            <c:remove var="success" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-danger" role="alert">
                                    ${sessionScope.error}
                            </div>
                            <c:remove var="error" scope="session"/>
                        </c:if>

                        <c:set var="quizList" value="${requestScope.quizList}"/>
                        <c:set var="currentPage"
                               value="${empty requestScope.currentPage ? 1 : requestScope.currentPage}"/>
                        <c:set var="totalPages" value="${empty requestScope.totalPages ? 1 : requestScope.totalPages}"/>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Toggle Columns:</label>
                            <div class="d-flex flex-wrap gap-2">
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="1" id="col1" checked>
                                    <label class="form-check-label" for="col1">ID</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="2" id="col2" checked>
                                    <label class="form-check-label" for="col2">Name</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="3" id="col3" checked>
                                    <label class="form-check-label" for="col3">Level</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="4" id="col4" checked>
                                    <label class="form-check-label" for="col4">Duration</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="5" id="col5" checked>
                                    <label class="form-check-label" for="col5">#Question</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="6" id="col6" checked>
                                    <label class="form-check-label" for="col6">Pass Rate</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="7" id="col7" checked>
                                    <label class="form-check-label" for="col7">Subject</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="8" id="col8" checked>
                                    <label class="form-check-label" for="col8">Test Type</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="9" id="col9" checked>
                                    <label class="form-check-label" for="col9">Status</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input toggle-column" type="checkbox" data-column="10" id="col10" checked>
                                    <label class="form-check-label" for="col10">Action</label>
                                </div>
                            </div>
                        </div>

                        <table class="table table-hover table-bordered">

                            <thead>
                            <tr>
                                <th class="col-1"><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=q.id&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">ID<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-2">
                                    <a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=q.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Name<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-3">
                                    <a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=q.question_level_id&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Level<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-4"><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=q.duration&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Duration<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-5"><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=qs.number_question&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">#Questions<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-6" style="width:105px;height: 56px"><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;"
                                                                                      href="?subject=${subject}&testType=${testType}&search=${search}&sortField=q.pass_rate&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Pass Rate<i class="fa fa-sort"></i>
                                </a></th>
                                <th class="col-7">
                                    <a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=s.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Subject<i class="fa fa-sort"></i></a>
                                </th>
                                <th class="col-8"><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&testType=${testType}&search=${search}&sortField=t.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Test Type<i class="fa fa-sort"></i>
                                </a></th>
                                <th class="col-9">Status</th>
                                <th class="col-10">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty quizList}">
                                <h4>No Data</h4>
                            </c:if>
                            <c:forEach var="quiz" items="${quizList}">
                                <tr>
                                    <td class="col-1">${quiz.id}</td>
                                    <td class="col-2">${quiz.name}</td>
                                    <td class="col-3">${quiz.questionLevel.name}</td>
                                    <td class="col-4">${(quiz.duration / 60).intValue()} min</td>
                                    <td class="col-5">${quiz.quizSetting.numberOfQuestions}</td>
                                    <td class="col-6">${quiz.passRate}%</td>
                                    <td class="col-7">${quiz.subject.name}</td>
                                    <td class="col-8">${quiz.testType.name}</td>
                                    <td class="col-9">
                                        <c:choose>
                                            <c:when test="${quiz.status==1}">
                                                <a href="toggle-quiz-status?action=changeStatus&id=${quiz.id}&status=0"
                                                   class="btn btn-success"
                                                   onclick="return confirm('Are you sure you want to deactivate this quiz?');">
                                                    Active
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="toggle-quiz-status?action=changeStatus&id=${quiz.id}&status=1"
                                                   class="btn btn-danger"
                                                   onclick="return confirm('Are you sure you want to activate this quiz?');">
                                                    Inactive
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="col-10">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="get-quiz-detail?action=view&id=${quiz.id}" class="btn btn-info" style="color: white">Overview/Setting</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="d-flex justify-content-end mt-3">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:set var="startPage" value="${currentPage - 2}" />
                                    <c:set var="endPage" value="${currentPage + 2}" />
                                    <c:if test="${startPage < 1}">
                                        <c:set var="startPage" value="1"/>
                                    </c:if>
                                    <c:if test="${endPage > totalPages}">
                                        <c:set var="endPage" value="${totalPages}"/>
                                    </c:if>
                                    <c:set var="urlBase"
                                           value="quizzeslist?subject=${subject}&testType=${testType}&search=${search}&sortField=${sortField}&sortOrder=${sortOrder}&pageSize=${pageSize}"/>

                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${urlBase}&page=${currentPage - 1}">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="${urlBase}&page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${urlBase}&page=${currentPage + 1}">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    const columnStateKey = 'column-visibility';
    // Use for store in localStorage

    function updateColumnVisibility() {
        const state = JSON.parse(localStorage.getItem(columnStateKey)) || {};

        document.querySelectorAll('.toggle-column').forEach(function (checkbox) {
            const colClass = 'col-' + checkbox.dataset.column;
            const isVisible = state[checkbox.dataset.column] ?? true;

            checkbox.checked = isVisible;

            document.querySelectorAll('.' + colClass).forEach(function (cell) {
                if (isVisible) {
                    cell.classList.remove('hidden-columnOfTable');
                } else {
                    cell.classList.add('hidden-columnOfTable');
                }
            });
        });
    }


    document.querySelectorAll('.toggle-column').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            const col = checkbox.dataset.column;
            const currentState = JSON.parse(localStorage.getItem(columnStateKey)) || {};
            currentState[col] = checkbox.checked;
            localStorage.setItem(columnStateKey, JSON.stringify(currentState));
            updateColumnVisibility();
        });
    });




    window.addEventListener('load', updateColumnVisibility);
</script>


<!-- Essential javascripts for application to work-->
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
<!-- Page specific javascripts-->
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
</body>
</html>