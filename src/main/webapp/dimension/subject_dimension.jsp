<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 07/07/2025
  Time: 6:02 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Dimension List</title>
</head>
<body class="app sidebar-mini">
<jsp:include page="../layout/manage/header.jsp"/>
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="dimension"/>
</jsp:include>
<jsp:include page="../user/user_profile.jsp"/>

<main class="app-content">
    <div class="app-title d-flex align-items-center justify-content-between">
        <h1 class="mb-0">
            <i class="bi bi-journal-bookmark"></i> Subject details id ${requestScope.subject.id}
        </h1>
        <div class="btn-group ms-3">
            <a href="${pageContext.request.contextPath}/management/subject/edit?subject_id=${requestScope.subject.id}" class="btn btn-outline-primary">Overview</a>
            <a href="${pageContext.request.contextPath}/management/dimension/list?id=${requestScope.subject.id}" class="btn btn-outline-primary active fw-bold">Dimension</a>
            <a href="${pageContext.request.contextPath}/price_package/list?subject_id=${requestScope.subject.id}" class="btn btn-outline-primary">Price
                Package</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="mb-3 text-start">
                        <a href="create?id=${requestScope.subject.id}" class="btn btn-primary">
                            <i class="bi bi-plus-lg me-1"></i> Add new dimension
                        </a>
                    </div>

                    <form method="get" action="list" class="d-flex align-items-center gap-3 mb-3">
                        Search:
                        <input type="text" name="search" value="${search}" />
                        <input type="hidden" name="id" value="${subjectId}" />
                        <input type="hidden" name="sortField" value="${sortField}" />
                        <input type="hidden" name="sortOrder" value="${sortOrder}" />
                        <input type="submit" value="Search"/>
                    </form>

                    <table class="table table-hover table-bordered">
                        <thead>
                        <tr>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=d.id&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">ID<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=d.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Name<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=d.type&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Type<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=d.description&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Description<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=s.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Subject<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?id=${subjectId}&search=${search}&sortField=d.status&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Status<i class="fa fa-sort"></i></a></th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty dimensionList}">
                            <tr><td colspan="6" class="text-center">No Data</td></tr>
                        </c:if>
                        <c:forEach var="dim" items="${dimensionList}">
                            <tr>
                                <td>${dim.id}</td>
                                <td>${dim.name}</td>
                                <td>${dim.type}</td>
                                <td>${dim.description}</td>
                                <td>${dim.subjectDTO.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${dim.status==true}">
                                            <a href="toggle-dimension-status?&d_id=${dim.id}&status=0&id=${requestScope.subject.id}"
                                               class="btn btn-success"
                                               onclick="return confirm('Are you sure you want to deactivate this quiz?');">
                                                Active
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a  href="toggle-dimension-status?&d_id=${dim.id}&status=1&id=${requestScope.subject.id}"
                                                class="btn btn-danger"
                                                onclick="return confirm('Are you sure you want to activate this quiz?');">
                                                Inactive
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center gap-2">
                                        <a style="color: white" href="detail?id=${dim.id}" class="btn btn-info btn-sm">View</a>
                                        <a style="color: white" href="edit?id=${dim.id}" class="btn btn-warning btn-sm">Edit</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-end mt-3">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:set var="urlBase" value="list?id=${requestScope.subject.id}&search=${search}&sortField=${sortField}&sortOrder=${sortOrder}&pageSize=${pageSize}" />
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${urlBase}&page=${currentPage - 1}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${urlBase}&page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${urlBase}&page=${currentPage + 1}">Next</a>
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
            <div class="toast-body"></div>
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
</body>
</html>
