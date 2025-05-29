<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 29/05/2025
  Time: 6:29 CH
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Add User</title>
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
            <h1><i class="bi bi-person-plus-fill"></i> Add User</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="admin">User List</a></li>
            <li class="breadcrumb-item active">Add User</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <form action="admin" method="post">
                        <input type="hidden" name="action" value="add">

                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label>Name</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label>Role</label>
                            <select class="form-select" name="roleId">
                                <option value="1">Admin</option>
                                <option value="2">Expert</option>
                                <option value="3">Customer</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Gender</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="true" checked>
                                <label class="form-check-label">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="false">
                                <label class="form-check-label">Female</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label>Mobile</label>
                            <input type="text" class="form-control" name="mobile">
                        </div>

                        <div class="mb-3">
                            <label>Address</label>
                            <textarea class="form-control" name="address"></textarea>
                        </div>

                        <div class="mb-3">
                            <label>Balance</label>
                            <input type="number" class="form-control" name="balance" value="0" step="0.01">
                        </div>

                        <div class="mb-3">
                            <label>Status</label>
                            <select class="form-select" name="status">
                                <option value="true" selected>Active</option>
                                <option value="false">Inactive</option>
                            </select>
                        </div>

                        <div class="mt-3">
                            <a href="admin" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">Create User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="common/jsload.jsp" %>
</body>
</html>

