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
    <jsp:include page="./common/headload.jsp"/>
    <title>Setting detail</title>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="./layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="./layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="setting"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="./user_profile.jsp"/>
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
