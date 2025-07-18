<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 05/06/2025
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
    <title>Price Package Detail</title>
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
            <a href="${pageContext.request.contextPath}/dimension/subject-dimension?id=${requestScope.subject_id}" class="btn btn-outline-primary">Dimension</a>
            <a href="${pageContext.request.contextPath}/price_package/list?subject_id=${requestScope.subject_id}" class="btn btn-outline-primary active fw-bold">Price
                Package</a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Price Package #${p.id}</h3>
                <div class="tile-body">
                    <form>
                        <div class="mb-3">
                            <label class="col-form-label">Package name</label>
                            <input class="form-control" type="text" name="name" value="${p.name}" readonly>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="form-label">Access duration</label>
                                <input class="form-control" type="number" min="1" name="duration" value="${p.duration}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Status</label>
                                <select class="form-control" name="status" disabled>
                                    <option value="activate" ${p.status == 'activate' ? 'selected="selected"' : ''}>Activate</option>
                                    <option value="deactivate" ${p.status == 'deactivate' ? 'selected="selected"' : ''}>Deactivate</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label class="col-form-label">List price</label>
                                <input class="form-control" type="number" min="0" step="0.01" name="listPrice" value="${p.listPrice}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="col-form-label">Sale price</label>
                                <input class="form-control" type="number" min="0" step="0.01" name="salePrice" value="${p.salePrice}" readonly>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="3" name="description" readonly>${p.description}</textarea>
                        </div>
                    </form>

                </div>
                <div class="tile-footer">
                    <a class="btn btn-primary" href="edit?id=${p.id}"><i class="bi bi-plus-circle me-2"></i>Edit</a>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-primary" href="create?subject_id=${p.subjectId}"><i class="bi bi-plus-circle me-2"></i>Create new price package</a>
                    &nbsp;&nbsp;&nbsp;
                    <a class="btn btn-secondary" href="list?subject_id=${p.subjectId}"><i class="bi bi-x-circle-fill me-2"></i>Back</a>
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
<%@include file="../common/jsload.jsp" %>
<%--Script to get toastNotification from EditSettingServlet to show and remove it in session--%>
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