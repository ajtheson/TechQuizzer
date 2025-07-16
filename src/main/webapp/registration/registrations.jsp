<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 30/06/2025
  Time: 08:13
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
    <title>Registration List</title>
</head>
<jsp:include page="../user/user_profile.jsp"/>
<body>
<jsp:include page="../layout/manage/sale_header.jsp"/>

<main style="margin-top: 65px; margin-left: 10px; margin-right: 10px">
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <div style="display: flex; justify-content: space-between">
                    <div style="display: flex; flex-direction: column">
                        <div>
                            <form action="create_registration" method="get">
                                <button type="submit" class="btn btn-primary">+ Add New Registration</button>
                            </form>
                        </div>
                        <div>
                            <label for="pageLengthInput" class="form-label mb-0">Show</label>
                            <input type="number" min="1" id="pageLengthInput"
                                   class="form-control d-inline-block w-auto ms-2" value="10"/>
                            <label for="pageLengthInput" class="form-label mb-0">entries</label>
                        </div>
                    </div>
                    <form style="display: flex; flex-direction: column" action="registrations" method="get">
                        <div style="display: flex; margin-bottom: 15px">
                            <div>
                                <input type="text" class="form-control d-inline-block w-auto ms-2" name="email"
                                       placeholder="Email" value="${requestScope.email}"/>
                            </div>
                            <div>
                                <input type="text" class="form-control d-inline-block w-auto ms-2" name="subject"
                                       placeholder="Subject" value="${requestScope.subject}"/>
                            </div>
                            <div>
                                <input type="text" class="form-control d-inline-block w-auto ms-2" name="from"
                                       placeholder="From" id="regisFrom" value="${requestScope.from}"/>
                            </div>
                            <div>
                                <input type="text" class="form-control d-inline-block w-auto ms-2" name="to"
                                       placeholder="To" id="regisTo" value="${requestScope.to}"/>
                            </div>
                            <div>
                                <select name="status" class="form-control d-inline-block w-auto ms-2">
                                    <option value="">Status</option>
                                    <option value="Pending Confirmation"
                                            <c:if test="${requestScope.status == 'Pending Confirmation'}">selected</c:if> >
                                        Pending Confirmation
                                    </option>
                                    <option value="Pending Payment"
                                            <c:if test="${requestScope.status == 'Pending Payment'}">selected</c:if>>
                                        Pending Payment
                                    </option>
                                    <option value="Paid" <c:if test="${requestScope.status == 'Paid'}">selected</c:if>>
                                        Paid
                                    </option>
                                    <option value="Expired"
                                            <c:if test="${requestScope.status == 'Expired'}">selected</c:if>>Expired
                                    </option>
                                    <option value="Canceled"
                                            <c:if test="${requestScope.status == 'Canceled'}">selected</c:if>>Canceled
                                    </option>
                                    <option value="Rejected"
                                            <c:if test="${requestScope.status == 'Rejected'}">selected</c:if>>Rejected
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div style="align-self: flex-end">
                            <button type="button" class="btn btn-secondary" style="width: 60px"
                                    onclick="location.href='registrations'">Reset
                            </button>
                            <button type="submit" class="btn btn-primary" style="width: 60px">Filter</button>
                        </div>
                    </form>
                </div>
                <!-- Table -->
                <table class="table table-hover table-bordered" id="sampleTable">
                    <thead>
                    <tr>
                        <th style="width: 3%;">#</th>
                        <th style="width: 18%;">Email</th>
                        <th style="width: 11%;">Registration Time</th>
                        <th style="width: 18%;">Subject</th>
                        <th style="width: 6%;">Package</th>
                        <th style="width: 4%;">Total Cost</th>
                        <th style="width: 7%;">Status</th>
                        <th style="width: 15%;">Valid Time</th>
                        <th style="width: 14%;">Last Updated</th>
                        <th style="width: 4%;">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.registrations}" var="r" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${r.user.email}</td>
                            <td>${r.time}</td>
                            <td>${r.subject.name}</td>
                            <td>${r.pricePackage.name}</td>
                            <td>${r.totalCost}</td>
                            <td>${r.status}</td>
                            <td>
                                <c:if test="${not empty r.validTo}">
                                    ${r.validFrom} to ${r.validTo}
                                </c:if>
                                <c:if test="${not empty r.validFrom and empty r.validTo}">Available from ${r.validFrom}</c:if>
                                <c:if test="${empty r.validFrom}">None</c:if>
                            </td>
                            <c:if test="${not empty r.lastUpdatedBy.email}">
                                <td>${r.lastUpdatedBy.email}</td>
                            </c:if>
                            <c:if test="${empty r.lastUpdatedBy.email}">
                                <td>None</td>
                            </c:if>

                            <td>
                                <a class="btn btn-info text-white" href="view_registration?id=${r.id}"
                                   style="width: 60px">View</a>
                                <a class="btn btn-warning text-white" href="edit_registration?id=${r.id}"
                                   style="width: 60px; margin-top: 3px">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

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


<%@include file="../common/jsload.jsp" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>

<script>
    flatpickr("#regisFrom", {
        dateFormat: "d-m-Y"
    });
    flatpickr("#regisTo", {
        dateFormat: "d-m-Y"
    });
</script>
<!-- DataTable init + column toggle -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const table = $('#sampleTable').DataTable({
            lengthChange: false,
            pageLength: 10,
            autoWidth: false,
            searching: false,
            columnDefs: [
                {orderable: false, targets: -1}
            ]
        });

        document.getElementById("pageLengthInput").addEventListener("input", function () {
            const value = parseInt(this.value);
            if (!isNaN(value) && value > 0) {
                table.page.len(value).draw();
            }
        });
    });
</script>

<!-- Toast script -->
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
        const toast = new bootstrap.Toast(toastElement, {autohide: true, delay: 2000});
        toast.show();
    });
</script>
<% } %>
</body>
</html>
