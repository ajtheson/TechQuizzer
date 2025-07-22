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
    <<jsp:include page="../common/headload.jsp"/>
    <title>User List</title>
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
            <h1><i class="bi bi-person"></i> View User Details</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="manage">User List</a></li>
            <li class="breadcrumb-item active">View User</li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="tile">
                <div class="tile-body">
                    <div class="text-center mb-4">
                        <img src="${pageContext.request.contextPath}/assets/images/avatar/${user.avatar != null ? user.avatar : 'default.webp'}"
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
                                    <c:when test="${user.roleId == 4}">Sale</c:when>
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
                        <a href="manage" class="btn btn-secondary">Back to List</a>
                        <a href="manage?action=edit&id=${user.id}" class="btn btn-warning">Edit User</a>
                    </div>
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