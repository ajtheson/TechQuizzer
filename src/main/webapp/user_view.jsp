<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 29/05/2025
  Time: 5:38 CH
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
<header class="app-header"><a class="app-header__logo" href="index.html">TechQuizzer</a>
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <!-- User Menu-->
        <li class="dropdown"><a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Open Profile Menu"><i
                class="bi bi-person fs-4"></i></a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
                <li><a class="dropdown-item" href="page-user.html"><i class="bi bi-gear me-2 fs-5"></i> Settings</a>
                </li>
                <li><a class="dropdown-item" href="page-user.html"><i class="bi bi-person me-2 fs-5"></i> Profile</a>
                </li>
                <li><a class="dropdown-item" href="page-login.html"><i class="bi bi-box-arrow-right me-2 fs-5"></i>
                    Logout</a></li>
            </ul>
        </li>
    </ul>
</header>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar"
                                        src="https://randomuser.me/api/portraits/lego/1.jpg" alt="User Image">
        <div>
            <p class="app-sidebar__user-name">Admin</p>
        </div>
    </div>
    <ul class="app-menu">
        <li><a class="app-menu__item active" href="dashboard.html"><i class="app-menu__icon bi bi-people-fill"></i><span
                class="app-menu__label">User List</span></a></li>
        <li><a class="app-menu__item" href="user_list.jsp"><i class="app-menu__icon bi bi-gear-wide-connected"></i><span
                class="app-menu__label">Setting List</span></a></li>
    </ul>
</aside>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-person"></i> View User Details</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="admin">User List</a></li>
            <li class="breadcrumb-item active">View User</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <div class="text-center mb-4">
                        <img src="assets/images/avatar/${user.avatar != null ? user.avatar : 'default.webp'}"
                             alt="User Avatar"
                             style="width: 150px; height: 180px; object-fit: cover; border: 2px solid #4d5154; border-radius: 8px;">
                    </div>
                    <table class="table table-bordered">
                        <tr>
                            <th>ID</th>
                            <td>${user.id}</td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <td>${user.name}</td>
                        </tr>
                        <tr>
                            <th>Role</th>
                            <td>
                                <c:choose>
                                    <c:when test="${user.roleId == 1}">Admin</c:when>
                                    <c:when test="${user.roleId == 2}">Expert</c:when>
                                    <c:when test="${user.roleId == 3}">Customer</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Gender</th>
                            <td>${user.gender ? 'Male' : 'Female'}</td>
                        </tr>
                        <tr>
                            <th>Mobile</th>
                            <td>${user.mobile}</td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td>${user.address}</td>
                        </tr>
                        <tr>
                            <th>Balance</th>
                            <td>${user.balance}</td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td>
                                <c:choose>
                                    <c:when test="${user.status}"><span class="badge bg-success">Active</span></c:when>
                                    <c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                    <div class="mt-3">
                        <a href="admin" class="btn btn-secondary">Back to List</a>
                        <a href="admin?action=edit&id=${user.id}" class="btn btn-warning">Edit User</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="common/jsload.jsp" %>
</body>
</html>