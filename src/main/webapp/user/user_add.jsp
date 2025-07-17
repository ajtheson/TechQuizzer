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
    <jsp:include page="../common/headload.jsp"/>
    <title>Add User</title>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="user"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="user_profile.jsp"/>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="bi bi-person-plus-fill"></i> Add User</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="manage">User List</a></li>
            <li class="breadcrumb-item active">Add User</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <form action="manage" method="post">
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
                                <option value="4">Sale</option>

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
                            <a href="manage" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">Create User</button>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="../common/jsload.jsp" %>
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

