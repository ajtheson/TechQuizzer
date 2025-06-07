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
                <li><a class="dropdown-item" href="change-password"><i class="bi bi-person me-2 fs-5"></i> Change
                    Password</a>
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
        <li><a class="app-menu__item" href="get-setting-list"><i
                class="app-menu__icon bi bi-gear-wide-connected"></i><span
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
                        <form action="admin" method="get" class="d-flex align-items-center gap-3 mb-3">
                            <select name="role" class="form-select" style="width: 150px;" onchange="this.form.submit()">
                                <option value="">Role</option>
                                <option value="1" ${selectedRole == '1' ? 'selected' : ''}>Admin</option>
                                <option value="2" ${selectedRole == '2' ? 'selected' : ''}>Expert</option>
                                <option value="3" ${selectedRole == '3' ? 'selected' : ''}>Customer</option>

                            </select>

                            <select name="status" class="form-select" style="width: 150px;" onchange="this.form.submit()">
                                <option value="">Status</option>
                                <option value="1" ${selectedStatus == '1' ? 'selected' : ''}>Active</option>
                                <option value="0" ${selectedStatus == '0' ? 'selected' : ''}>Inactive</option>
                            </select>

                            <select name="gender" class="form-select" style="width: 150px;" onchange="this.form.submit()">
                                <option value="">Gender</option>
                                <option value="1" ${selectedGender == '1' ? 'selected' : ''}>Male</option>
                                <option value="0" ${selectedGender == '0' ? 'selected' : ''}>Female</option>
                            </select>

                            <input type="hidden" name="sortField" value="${sortField}">
                            <input type="hidden" name="sortOrder" value="${sortOrder}">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="pageSize" value="${pageSize}">
                        </form>
                        <form method="get" action="admin" id="pageSizeForm">
                            <input type="hidden" name="page" value="${currentPage}"/>
                            <div class="d-flex align-items-center" style="height: 25px; margin-bottom: 20px;">
                                <span style="margin-right: 5px;">Show</span>
                                <select name="pageSize" class="form-select"
                                        style="font-size: 13px; width: 65px; height: 28px; padding: 0 5px; margin: 0 5px;"
                                        onchange="document.getElementById('pageSizeForm').submit();">
                                    <option value="10" ${pageSize == 10 ? "selected" : ""}>10</option>
                                    <option value="20" ${pageSize == 20 ? "selected" : ""}>20</option>
                                    <option value="50" ${pageSize == 50 ? "selected" : ""}>50</option>
                                    <option value="100" ${pageSize == 100 ? "selected" : ""}>100</option>
                                </select>
                                <span>entries</span>
                            </div>
                        </form>

                        <c:set var="users" value="${requestScope.users}"/>

                        <c:set var="currentPage"
                               value="${empty requestScope.currentPage ? 1 : requestScope.currentPage}"/>
                        <c:set var="totalPages" value="${empty requestScope.totalPages ? 1 : requestScope.totalPages}"/>
                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=id&sortOrder=${sortField eq 'id' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        ID

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=email&sortOrder=${sortField eq 'email' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Email

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=name&sortOrder=${sortField eq 'name' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Name

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=role&sortOrder=${sortField eq 'role' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Role

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=gender&sortOrder=${sortField eq 'gender' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Gender

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=mobile&sortOrder=${sortField eq 'mobile' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Mobile

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=address&sortOrder=${sortField eq 'address' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Address

                                        <i class="fa fa-sort"></i>

                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=balance&sortOrder=${sortField eq 'balance' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Balance
                                        <i class="fa fa-sort"></i>
                                    </a>
                                </th>
                                <th>
                                    <a href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=status&sortOrder=${sortField eq 'status' and sortOrder eq 'asc' ? 'desc' : 'asc'}&page=${currentPage}&pageSize=${pageSize}"
                                       style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;">
                                        Status
                                        <i class="fa fa-sort"></i>
                                    </a>
                                </th>
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
                                               class="btn btn-warning" style="color: white">
                                                Edit
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="d-flex justify-content-end mt-3">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">

                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=${sortField}&sortOrder=${sortOrder}&page=${currentPage - 1}&pageSize=${pageSize}">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&=${sortField}&sortOrder=${sortOrder}&page=${i}&pageSize=${pageSize}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="admin?role=${selectedRole}&status=${selectedStatus}&gender=${selectedGender}&sortField=${sortField}&sortOrder=${sortOrder}&page=${currentPage + 1}&pageSize=${pageSize}">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>

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
</body>
</html>
