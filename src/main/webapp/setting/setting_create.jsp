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
    <jsp:include page="../common/headload.jsp"/>
    <title>Setting Create</title>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="setting"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="../user/user_profile.jsp"/>
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
                    <form action="${pageContext.request.contextPath}/admin/setting/create" method="post">
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
                        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/setting/list"><i class="bi bi-x-circle-fill me-2"></i>Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Essential javascripts for application to work-->
<%@include file="../common/jsload.jsp" %>
</body>
</html>
