<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 24-May-25
  Time: 9:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Setting detail</title>
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
                <li><a class="dropdown-item" href="page-user.html"><i class="bi bi-gear me-2 fs-5"></i> Profile</a>
                </li>
                <li><a class="dropdown-item" href="change-password"><i class="bi bi-person me-2 fs-5"></i> Change Password</a>
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
                                        src="https://randomuser.me/api/portraits/men/1.jpg" alt="User Image">
        <div>
            <p class="app-sidebar__user-name">John Doe</p>
            <p class="app-sidebar__user-designation">Frontend Developer</p>
        </div>
    </div>
    <ul class="app-menu">
        <li><a class="app-menu__item" href="dashboard.html"><i class="app-menu__icon bi bi-people-fill"></i><span
                class="app-menu__label">User List</span></a></li>
        <li><a class="app-menu__item active" href="get-setting-list"><i class="app-menu__icon bi bi-gear-wide-connected"></i><span
                class="app-menu__label">Setting List</span></a></li>
    </ul>
</aside>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-ui-checks"></i> Setting Detail</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Setting detail #${setting.id}</h3>
                <div class="tile-body">
                    <form>
                        <div class="mb-3">
                            <fieldset disabled="">
                                <label class="form-label" for="disabledInput">Type</label>
                                <input class="form-control" id="disabledInput" type="text" disabled="" value="${setting.type}">
                            </fieldset>
                        </div>
                        <div class="mb-3">
                            <fieldset disabled="">
                                <label class="form-label" for="disabledInput">Value</label>
                                <input class="form-control" id="disabledInput" type="text" disabled="" value="${setting.value}">
                            </fieldset>
                        </div>
                        <div class="mb-3">
                            <fieldset disabled="">
                                <label class="form-label" for="disabledInput">Order</label>
                                <input class="form-control" id="disabledInput" type="text" disabled="" value="${setting.order}">
                            </fieldset>
                        </div>
                        <div class="mb-3">
                            <fieldset disabled="">
                                <label class="form-label" for="disabledTextarea">Description</label>
                                <textarea class="form-control" id="disabledTextarea" rows="3" disabled >${setting.description}</textarea>
                            </fieldset>
                        </div>
                        <div class="mb-3">
                            <fieldset disabled="">
                                <label class="form-label" for="disabledInput">Status</label>
                                <input class="form-control" id="disabledInput" type="text" disabled="" value="${setting.activated ? 'Activated' : 'Deactivated'}">
                            </fieldset>
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <a class="btn btn-primary" href="edit-setting?id=${setting.id}"><i class="bi bi-plus-circle me-2"></i>Edit</a>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-primary" href="create-setting"><i class="bi bi-plus-circle me-2"></i>Create new setting</a>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-secondary" href="get-setting-list"><i class="bi bi-x-circle-fill me-2"></i>Cancel</a>
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
