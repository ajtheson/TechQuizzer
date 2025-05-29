<%@ page import="dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 24-May-25
  Time: 10:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Setting Create</title>
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
            <h1><i class="bi bi-ui-checks"></i> New Setting</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Create new setting</h3>
                <div class="tile-body">
                    <form action="create-setting" method="post">
                        <div class="mb-3">
                            <label class="form-label" for="type">Type</label>
                            <select class="form-control" id="type" name="type" required>
                                <option value="">--Choose setting type--</option>
                                <option value="User Roles" ${type == 'User Roles' ? 'selected="selected"' : ''}>User
                                    Roles
                                </option>
                                <option value="Subject Categories" ${type == 'Subject Categories' ? 'selected="selected"' : ''}>
                                    Subject Categories
                                </option>
                                <option value="Test Types" ${type == 'Test Types' ? 'selected="selected"' : ''}>Test
                                    Types
                                </option>
                                <option value="Question Levels" ${type == 'Question Levels' ? 'selected="selected"' : ''}>
                                    Question Levels
                                </option>
                                <option value="Lesson Types" ${type == 'Lesson Types' ? 'selected="selected"' : ''}>
                                    Lesson Types
                                </option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="col-form-label" for="value">Value</label>
                            <input class="form-control" id="value" type="text" value="${empty value ? '' : value}"
                                   name="value" required>
                        </div>
                        <div class="mb-3">
                            <label class="col-form-label" for="order">Order</label>
                            <input class="form-control" id="order" type="number" value="${empty order ? '' : order}"
                                   name="order" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="exampleTextarea">Description</label>
                            <textarea class="form-control" id="exampleTextarea" rows="3" name="description"
                                      required>${empty description ? '' : description}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="exampleSelect1">Status</label>
                            <select class="form-control" id="exampleSelect1" name="status" required>
                                <option value="">--Choose setting status--</option>
                                <option value="activate" ${status == 'activate' ? 'selected="selected"' : ''}>Activate
                                </option>
                                <option value="deactivate" ${status == 'deactivate'  ? 'selected="selected"' : '' }>
                                    Deactivate
                                </option>
                            </select>
                        </div>
                        <p style="text-align: left; color: red">${error}</p>
                        <button class="btn btn-primary"><i class="bi bi-plus-circle me-2"></i>Create</button>
                        <a class="btn btn-secondary" href="get-setting-list"><i class="bi bi-x-circle-fill me-2"></i>Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Essential javascripts for application to work-->
<%@include file="common/jsload.jsp" %>
</body>
</html>
