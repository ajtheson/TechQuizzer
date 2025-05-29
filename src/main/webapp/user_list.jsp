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
    <title>User List</title>
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
        <li><a class="app-menu__item active" href="admin"><i class="app-menu__icon bi bi-people-fill"></i><span
                class="app-menu__label">User List</span></a></li>
        <li><a class="app-menu__item" href="get-setting-list"><i class="app-menu__icon bi bi-gear-wide-connected"></i><span
                class="app-menu__label">Setting List</span></a></li>
    </ul>
</aside>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i></i> User List</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <div class="mb-3 text-start">
                            <a href="admin?action=add" class="btn btn-primary">
                                <i class="bi bi-plus-lg me-1"></i> Add New User
                            </a>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3">

                                <select id="roleFilter" class="form-select">
                                    <option value="">Role</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select id="statusFilter" class="form-select">
                                    <option value="">Status</option>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select id="genderFilter" class="form-select">
                                    <option value="">Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                        </div>
                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>Gender</th>
                                <th>Mobile</th>
                                <th>Address</th>
                                <th>Balance</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.email}</td>
                                    <td>${user.name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.roleId == 1}">
                                                Admin
                                            </c:when>
                                            <c:when test="${user.roleId == 2}">
                                                Expert
                                            </c:when>
                                            <c:when test="${user.roleId == 3}">
                                                Customer
                                            </c:when>
                                            <c:otherwise>
                                                Unknown
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${user.gender ? 'Male' : 'Female'}</td>
                                    <td>${user.mobile}</td>
                                    <td>${user.address}</td>
                                    <td>${user.balance}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.status}">
                                                <a href="admin?action=changeStatus&id=${user.id}"
                                                   class="btn btn-success"
                                                   onclick="return confirm('Are you sure you want to deactivate this account?');">
                                                    Active
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="admin?action=changeStatus&id=${user.id}"
                                                   class="btn btn-danger"
                                                   onclick="return confirm('Are you sure you want to activate this account?');">
                                                    Inactive
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="admin?action=view&id=${user.id}"
                                               class="btn btn-info" style="color: white">
                                                View
                                            </a>

                                            <a href="admin?action=edit&id=${user.id}"
                                               class="btn btn-warning"style="color: white">
                                                Edit
                                            </a>
                                        </div>
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
<!-- Essential javascripts for application to work-->
<%@include file="common/jsload.jsp" %>
<!-- Page specific javascripts-->
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<!-- Data table plugin-->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">
    $(document).ready(function () {
        const table = $('#sampleTable').DataTable();

        // Tự động thêm options vào bộ lọc "Role"
        table.column(3).data().unique().sort().each(function (d) {
            $('#roleFilter').append('<option value="' + d + '">' + d + '</option>');
        });

        // Xử lý lọc theo Role
        $('#roleFilter').on('change', function () {
            const val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column(3).search(val ? '^' + val + '$' : '', true, false).draw();
        });

        // Xử lý lọc theo Status
        $('#statusFilter').on('change', function () {
            const val = $(this).val();
            table.column(8).search(val, true, false).draw();
        });

        // Xử lý lọc theo Gender
        $('#genderFilter').on('change', function () {
            const val = $(this).val();
            table.column(4).search(val, true, false).draw();
        });
    });
</script>

</body>
</html>
