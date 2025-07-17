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
    <jsp:include page="../common/headload.jsp"/>
    <title>Setting List</title>
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
            <h1><i class="bi bi-gear-wide-connected"></i> Setting List</h1>
            <p>Table to manage and configure system settings efficiently</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="table-responsive">
                        <%--Filter--%>
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                            <div>
                                <a class="btn btn-primary" type="button" href="${pageContext.request.contextPath}/admin/setting/create">+ Add New Setting</a>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <select id="typeFilter" class="form-select" style="width: 150px;">
                                    <option value="">Type</option>
                                </select>
                                <select id="statusFilter" class="form-select" style="width: 150px;">
                                    <option value="">Status</option>
                                    <option value="Activated">Activated</option>
                                    <option value="Deactivated">Deactivated</option>
                                </select>
                            </div>
                        </div>
                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Value</th>
                                <th>Order</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${settings}" var="setting">
                                <tr>
                                    <td>${setting.id}</td>
                                    <td>${setting.type}</td>
                                    <td>${setting.value}</td>
                                    <td>${setting.order}</td>
                                    <td>${setting.activated ? 'Activated' : 'Deactivated'}</td>
                                    <td>
                                        <a class="btn btn-info text-white" type="button" href="${pageContext.request.contextPath}/admin/setting/detail?id=${setting.id}">View</a>
                                        <a class="btn btn-warning text-white" type="button" href="${pageContext.request.contextPath}/admin/setting/edit?id=${setting.id}">Edit</a>
                                        <form action="${pageContext.request.contextPath}/admin/setting/toggle-setting-status" method="post" style="display: inline;">
                                            <input type="hidden" name="id" value="${setting.id}" />
                                            <input type="hidden" name="status" value="${!setting.activated}" />
                                            <button type="submit" class="btn ${setting.activated ? 'btn-success' : 'btn-secondary'}" style="padding: 6px 5px;">
                                                    ${setting.activated ? 'Activated' : 'Deactivated'}
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
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
<!-- Page specific javascripts-->
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<!-- Data table plugin-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
    $('#sampleTable').DataTable({
        columnDefs: [
            { orderable: false, targets: [5] } // No sort on column 5(Action)
        ]
    });
</script>
<!-- Filter Script -->
<script type="text/javascript">
    $(document).ready(function () {
        //Initialize DataTable with element id 'sampleTable'
        const table = $('#sampleTable').DataTable();

        /*
        Add option in the filter of "Type"
        Select data in column 1 (Type), select unique data and sort them
        Append option in the filter of "Type" with id 'typeFilter'
         */
        table.column(1).data().unique().sort().each(function (d) {
            $('#typeFilter').append('<option value="' + d + '">' + d + '</option>');
        });

        //Listen for type filter change and filter DataTable
        $('#typeFilter').on('change', function () {
            //Get the value of the filter and search for it in the DataTable
            //escapeRegex is used to prevent regex special characters such as $, ^, *
            const val = $.fn.dataTable.util.escapeRegex($(this).val());
            /*
            Search for the value in the column 1 (Type)
            If the val is not empty, change val become regex '^' + val + '$' and search for it in column 1
            else, val is '' which means search for all data in column 1
            search( searchText, useRegex = false, useSmart = true)
            useSmart : search for exact match - tìm tách từ
            draw() : redraw DataTable
            */
            table.column(1).search(val ? '^' + val + '$' : '', true, false).draw();
        });

        //Handle filter by Status
        $('#statusFilter').on('change', function () {
            const val = $.fn.dataTable.util.escapeRegex($(this).val());
            table.column(4).search(val ? '^' + val + '$' : '', true, false).draw();
        });
    });
</script>
<%--Script to get toastNotification from CreateSettingServlet to show and remove it in session--%>
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
