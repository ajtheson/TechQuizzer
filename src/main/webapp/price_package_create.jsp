<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 05/06/2025
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Price Package Create</title>
</head>
<jsp:include page="./user_profile.jsp"/>
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
                <li>
                            <span class="dropdown-item" data-bs-toggle="modal" data-bs-target="#userProfile"
                                  style="cursor: pointer">
                                <i class="bi bi-person me-2 fs-5"></i> User profile
                            </span>
                </li>
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
            <h1><i class="bi bi-ui-checks"></i> New Price Package</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Create new price package</h3>
                <div class="tile-body">
                    <form action="create_price_package" method="post">
                        <input type="hidden" name="subject_id" value="${requestScope.subject_id}">
                        <div class="mb-3">
                            <label class="col-form-label">Package name</label>
                            <input class="form-control" type="text" required name="name" value="${requestScope.name}">
                        </div>
                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="form-label">Access duration</label>
                                <input class="form-control" type="number" min="1" name="duration" value="${requestScope.duration}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" >Status</label>
                                <select class="form-control" name="status" required>
                                    <option value="" disabled selected>--Choose price package status--</option>
                                    <option value="activate" ${status == 'activate' ? 'selected="selected"' : ''}>Activate
                                    </option>
                                    <option value="deactivate" ${status == 'deactivate'  ? 'selected="selected"' : '' }>
                                        Deactivate
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="col-form-label">List price</label>
                                <input class="form-control" type="number" min="0" step="0.01" required name="listPrice" value="${requestScope.listPrice}">
                            </div>
                            <div class="col-md-6">
                                <label class="col-form-label">Sale duration</label>
                                <input class="form-control" type="number" min="0" step="0.01" required name="salePrice" value="${requestScope.salePrice}">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="3" name="description"
                                      required>${requestScope.description}</textarea>
                        </div>
                        <p style="text-align: left; color: red">${error}</p>
                        <button class="btn btn-primary"><i class="bi bi-plus-circle me-2"></i>Create</button>
                        <a class="btn btn-secondary" href="get_price_package?subject_id=${requestScope.subject_id}"><i class="bi bi-x-circle-fill me-2"></i>Cancel</a>
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
