<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 05/06/2025
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
    <title>Price Package Edit</title>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="subject"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="../user/user_profile.jsp"/>
<main class="app-content">
    <div class="app-title d-flex align-items-center justify-content-between">
        <h1 class="mb-0">
            <i class="bi bi-journal-bookmark"></i> Subject details id ${requestScope.p.getSubjectId()}
        </h1>
        <div class="btn-group ms-3">
            <a href="${pageContext.request.contextPath}/management/subject/edit?subject_id=${requestScope.subject_id}"  class="btn btn-outline-primary">Overview</a>
            <a href="${pageContext.request.contextPath}/management/dimension/list?id=${requestScope.subject.id}" class="btn btn-outline-primary">Dimension</a>
            <a href="${pageContext.request.contextPath}/price_package/list?subject_id=${requestScope.subject_id}" class="btn btn-outline-primary active fw-bold">Price
                Package</a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Edit Price Package #${p.id}</h3>
                <div class="tile-body">
                    <form action="edit" method="post">
                        <input type="hidden" name="subject_id" value="${p.subjectId}">
                        <input type="hidden" name="id" value="${p.id}">
                        <div class="mb-3">
                            <label class="col-form-label">Package name</label>
                            <input class="form-control" type="text" required name="name" value="${p.name}">
                        </div>
                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="form-label">Access duration</label>
                                <input class="form-control" type="number" min="1" name="duration" value="${p.duration}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" >Status</label>
                                <select class="form-control" name="status" required>
                                    <option value="activate" ${p.status == 'activate' ? 'selected="selected"' : ''}>Activate
                                    </option>
                                    <option value="deactivate" ${p.status == 'deactivate'  ? 'selected="selected"' : '' }>
                                        Deactivate
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="col-form-label">List price</label>
                                <input class="form-control" type="number" min="0" step="0.01" required name="listPrice" value="${p.listPrice}">
                            </div>
                            <div class="col-md-6">
                                <label class="col-form-label">Sale price</label>
                                <input class="form-control" type="number" min="0" step="0.01" required name="salePrice" value="${p.salePrice}">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="3" name="description"
                                      required>${p.description}</textarea>
                        </div>
                        <p style="text-align: left; color: red">${error}</p>
                        <button class="btn btn-primary"><i class="bi bi-plus-circle me-2"></i>Save</button>
                        <a class="btn btn-secondary" href="list?subject_id=${p.subjectId}"><i class="bi bi-x-circle-fill me-2"></i>Cancel</a>
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