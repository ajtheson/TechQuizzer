<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 24-May-25
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Setting List</title>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<header class="app-header"><a class="app-header__logo" href="home">TechQuizzer</a>
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <!-- User Menu-->
        <li class="dropdown"><a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Open Profile Menu"><i
                class="bi bi-person fs-4"></i></a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
                <li><a class="dropdown-item" href="change-password"><i class="bi bi-person me-2 fs-5"></i> Change Password</a>
                </li>
                <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2 fs-5"></i>
                    Logout</a></li>
            </ul>
        </li>
    </ul>
</header>

<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar"
                                        src="assets/images/avatar/${sessionScope.user.avatar}" alt="User Image">
        <div>
            <p class="app-sidebar__user-name">${sessionScope.user.name}</p>
            <p class="app-sidebar__user-designation">Admin</p>
        </div>
    </div>
    <ul class="app-menu">
        <li><a class="app-menu__item" href="admin"><i class="app-menu__icon bi bi-people-fill"></i><span
                class="app-menu__label">User List</span></a></li>
        <li><a class="app-menu__item active" href="get-setting-list"><i class="app-menu__icon bi bi-gear-wide-connected"></i><span
                class="app-menu__label">Setting List</span></a></li>
    </ul>
</aside>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-gear-wide-connected"></i> Setting List</h1>
            <p>Table to manage and configure system settings efficiently</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <%--Filter--%>
                            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                                <div>
                                    <a class="btn btn-primary" type="button" href="create-setting">+ Add New Setting</a>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <select id="typeFilter" class="form-select form-select-sm" style="width: 150px;">
                                        <option value="">Type</option>
                                    </select>
                                    <select id="statusFilter" class="form-select form-select-sm" style="width: 150px;">
                                        <option value="">Status</option>
                                        <option value="Activated">Activated</option>
                                        <option value="Deactivated">Deactivated</option>
                                    </select>
                                </div>
                            </div>
                            <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Value</th>
                                <th>Order</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${settings}" var="setting">
                                <tr>
                                    <td>${setting.id}</td>
                                    <td>${setting.type}</td>
                                    <td>${setting.value}</td>
                                    <td>${setting.order}</td>
                                    <td>${setting.activated ? 'Activated' : 'Deactivated'}</td>
                                    <td>
                                        <a class="btn btn-info text-white" type="button" href="get-setting-detail?id=${setting.id}">View</a>
                                        <a class="btn btn-warning text-white" type="button" href="edit-setting?id=${setting.id}">Edit</a>
                                        <form action="toggle-setting-status" method="post" style="display: inline;">
                                            <input type="hidden" name="id" value="${setting.id}" />
                                            <input type="hidden" name="status" value="${!setting.activated}" />
                                            <button type="submit" class="btn btn-sm ${setting.activated ? 'btn-success' : 'btn-secondary'}" style="padding: 6px 5px;">
                                                    ${setting.activated ? 'Activated' : 'Deactivated'}
                                            </button>
                                        </form>
                                    </td>
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
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<!-- Data table plugin-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<!-- Filter Script -->
<script type="text/javascript">
    $(document).ready(function () {
        const table = $('#sampleTable').DataTable();

        // Tự động thêm options vào bộ lọc "Type"
        table.column(1).data().unique().sort().each(function (d) {
            $('#typeFilter').append('<option value="' + d + '">' + d + '</option>');
        });

        // Xử lý lọc theo Type
        $('#typeFilter').on('change', function () {
            const val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column(1).search(val ? '^' + val + '$' : '', true, false).draw();
        });

        // Xử lý lọc theo Status
        $('#statusFilter').on('change', function () {
            const val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column(4).search(val ? '^' + val + '$' : '', true, false).draw();
        });
    });
</script>

<%
    String toastNotification = (String) session.getAttribute("toastNotification");
    if (toastNotification != null) {
        boolean isSuccess = toastNotification.contains("successfully");
        request.removeAttribute("toastNotification");
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
