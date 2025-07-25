<%-- Created by IntelliJ IDEA. --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
    <title>Price Package List</title>
</head>
<body class="app sidebar-mini">

<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="subject"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="../user/user_profile.jsp"/>

<!-- Main content -->
<main class="app-content">
    <div class="app-title d-flex align-items-center justify-content-between">
        <h1 class="mb-0">
            <i class="bi bi-journal-bookmark"></i> Subject details id ${requestScope.subject_id}
        </h1>
        <div class="btn-group ms-3">
            <a href="${pageContext.request.contextPath}/management/subject/edit?subject_id=${requestScope.subject_id}"  class="btn btn-outline-primary">Overview</a>
            <a href="${pageContext.request.contextPath}/management/dimension/list?id=${requestScope.subject_id}" class="btn btn-outline-primary">Dimension</a>
            <a href="${pageContext.request.contextPath}/price_package/list?subject_id=${requestScope.subject_id}" class="btn btn-outline-primary active fw-bold">Price
                Package</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">

                        <!-- Filter -->
                        <c:if test="${sessionScope.user.getRoleId() == 1}">
                            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                                <form action="create" method="get">
                                    <input type="hidden" name="subject_id" value="${requestScope.subject_id}">
                                    <button type="submit" class="btn btn-primary">+ Add New Package</button>
                                </form>
                            </div>
                        </c:if>
                        <!-- Page size + column toggle -->
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                            <div>
                                <label for="pageLengthInput" class="form-label mb-0">Show</label>
                                <input type="number" min="1" id="pageLengthInput"
                                       class="form-control d-inline-block w-auto ms-2" value="10"/>
                                <label for="pageLengthInput" class="form-label mb-0">entries</label>
                            </div>
                            <div>
                                <label class="form-label mb-0">Column:</label>
                                <div id="columnToggles" class="d-inline-block ms-2">
                                    <label><input type="checkbox" class="toggle-vis" data-column="1" checked>
                                        Package</label>
                                    <label><input type="checkbox" class="toggle-vis" data-column="2" checked>
                                        Duration</label>
                                    <label><input type="checkbox" class="toggle-vis" data-column="3" checked> List Price</label>
                                    <label><input type="checkbox" class="toggle-vis" data-column="4" checked> Sale Price</label>
                                    <label><input type="checkbox" class="toggle-vis" data-column="5" checked>
                                        Description</label>
                                    <label><input type="checkbox" class="toggle-vis" data-column="6" checked>
                                        Status</label>
                                </div>
                            </div>
                        </div>

                        <!-- Table -->
                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                            <tr>
                                <th style="width: 3%;">#</th>
                                <th style="width: 17%;">Package</th>
                                <th style="width: 8%;">Duration</th>
                                <th style="width: 9%;">List Price</th>
                                <th style="width: 9%;">Sale Price</th>
                                <th style="width: 25%;">Description</th>
                                <th style="width: 10%;">Status</th>
                                <c:if test="${sessionScope.user.getRoleId() == 1}">
                                    <th style="width: 19%;">Actions</th>
                                </c:if>

                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${p}" var="p" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${p.name}</td>
                                    <td>${p.duration}</td>
                                    <td>${p.listPrice}</td>
                                    <td>${p.salePrice}</td>
                                    <td>${p.description}</td>
                                    <td>${p.status ? 'Activated' : 'Deactivated'}</td>
                                    <c:if test="${sessionScope.user.getRoleId() == 1}">
                                        <td>
                                            <a class="btn btn-info text-white" href="detail?id=${p.id}">View</a>
                                            <a class="btn btn-warning text-white" href="edit?id=${p.id}">Edit</a>
                                            <form action="toggle_status" method="post"
                                                  style="display: inline;">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="status" value="${!p.status}"/>
                                                <button type="submit"
                                                        class="btn ${p.status ? 'btn-secondary' : 'btn-success'}"
                                                        style="padding: 6px 5px;">
                                                        ${p.status ? 'Deactivated' : 'Activated'}
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Toast Notification -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="toast" class="toast align-items-center border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>

<!-- Scripts -->
<%@include file="../common/jsload.jsp" %>
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<script src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>

<!-- DataTable init + column toggle -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const table = $('#sampleTable').DataTable({
            lengthChange: false,
            pageLength: 10,
            autoWidth: false,
        });

        document.getElementById("pageLengthInput").addEventListener("input", function () {
            const value = parseInt(this.value);
            if (!isNaN(value) && value > 0) {
                table.page.len(value).draw();
            }
        });

        document.querySelectorAll('.toggle-vis').forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                const column = table.column($(this).attr('data-column'));
                column.visible(this.checked);
                table.columns.adjust().draw(false);
            });
        });
    });
</script>

<!-- Toast script -->
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
        const toast = new bootstrap.Toast(toastElement, {autohide: true, delay: 2000});
        toast.show();
    });
</script>
<% } %>

</body>
</html>
