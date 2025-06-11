<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 08/06/2025
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Subject List</title>
    <jsp:include page="./common/headload.jsp"/>
</head>
<body style="background-color: #E5E5E5">
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<main class="container" style="margin-top: 100px; margin-bottom: 250px">
    <div class="row user">
        <%--        sidebar--%>
        <div class="col-md-4">
            <div class="card" style="position: sticky; top: 100px; z-index: 1020">
                <div class="card-body p-0">

                    <!-- 1. Search -->

                    <div class="p-3 border-bottom">
                        <form action="my_registration" method="get">
                            <div class="input-group">
                                <input type="search" class="form-control" placeholder="Search by subject name"
                                       name="search" value="${requestScope.search}">
                                <button class="btn btn-outline-secondary" type="submit">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <form action="my_registration" method="get">
                        <%--                    Registration Status--%>
                        <div class="accordion border-bottom" id="accordionFields">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed p-3 bg-white fw-bold text-uppercase hover-bg"
                                            type="button" data-bs-toggle="collapse" data-bs-target="#collapseFields">
                                        Registration Status
                                    </button>
                                </h2>
                                <div id="collapseFields" class="accordion-collapse collapse show">
                                    <div class="accordion-body px-3 pt-2 pb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="pending" name="status" value="Pending" onchange="this.form.submit()"
                                                   <c:if test="${requestScope.selectedStatuses != null and fn:contains(requestScope.selectedStatuses, 'Pending')}">checked</c:if>>
                                            <label class="form-check-label" for="pending">Pending</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="paid" name="status" value="Paid" onchange="this.form.submit()"
                                                   <c:if test="${requestScope.selectedStatuses != null and fn:contains(requestScope.selectedStatuses, 'Paid')}">checked</c:if>>
                                            <label class="form-check-label" for="paid">Paid</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="expired" name="status" value="Expired" onchange="this.form.submit()"
                                                   <c:if test="${requestScope.selectedStatuses != null and fn:contains(requestScope.selectedStatuses, 'Expired')}">checked</c:if>>
                                            <label class="form-check-label" for="expired">Expired</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="canceled" name="status" value="Canceled" onchange="this.form.submit()"
                                                   <c:if test="${requestScope.selectedStatuses != null and fn:contains(requestScope.selectedStatuses, 'Canceled')}">checked</c:if>>
                                            <label class="form-check-label" for="canceled">Canceled</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 3. Subject Category (Accordion Dropdown) -->
                        <div class="accordion border-bottom" id="accordionCategory">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed p-3 bg-white fw-bold text-uppercase hover-bg"
                                            type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategory">
                                        Subject Category
                                    </button>
                                </h2>
                                <div id="collapseCategory" class="accordion-collapse collapse show">
                                    <div class="accordion-body px-3 pt-2 pb-3">
                                        <c:forEach var="c" items="${requestScope.categories}">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="category"
                                                       id="${c.id}" value="${c.id}" onchange="this.form.submit()"
                                                       <c:if test="${requestScope.selectedCategories != null and requestScope.selectedCategories.contains(c.id)}">checked</c:if>>
                                                <label class="form-check-label" for="${c.id}">${c.name}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <div class="p-3 border-bottom d-flex justify-content-center">
                        <button class="btn btn-primary btn-block" style="width: 80%" onclick="location.href='my_registration'">Reset</button>
                    </div>

                    <!-- 5. Need More Advice -->
                    <div class="p-3">
                        <h6 class="mb-3">
                            Need More Advice? Contact TechQuizzer
                        </h6>
                        <div class="d-flex justify-content-center">
                            <a class="btn btn-outline-primary btn-sm" href="#" data-bs-toggle="tab">Ask
                                Now</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <div class="col-md-8">
            <c:if test="${requestScope.emptyList}">
                <h3 class="text-center text-danger mt-4 mb-4">
                    Not have registration for any subjects yet.
                </h3>
            </c:if>
            <div class="tab-content">
                <div class="tab-pane active" id="user-timeline">
                    <%--                    Div for one subject--%>
                    <c:forEach items="${requestScope.registrations}" var="r">
                        <div class="timeline-post" style="border-radius: 5px">
                            <div class="row">
                                <div class="subject-media col-md-4">
                                    <a href="#">
                                        <img class="subject-thumbnail"
                                             src="assets/images/thumbnail/subject/${r.subject.thumbnail}"
                                             alt="Subject_Thumbnail">
                                    </a>
                                </div>
                                <div class="post-content col-md-6">
                                    <h4 class="text-uppercase">${r.subject.name}</h4>
                                    <div class="d-flex gap-2 align-items-center mb-2">
                                        <span class="register-time">${r.time}</span>
                                        <span class="package-label ${r.pricePackage.name}">${r.pricePackage.name}</span>
                                    </div>

                                    <c:if test="${r.status == 'Paid' || r.status == 'Expired'}">
                                        <div class="date-range">
                                            <div class="from-date">
                                                📅 From: <strong>${r.validFrom}</strong>
                                            </div>
                                            <div class="to-date">
                                                📅
                                                To:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>${r.validTo}</strong>
                                            </div>
                                        </div>
                                    </c:if>

                                </div>

                                <div class="price_register_button col-md-2">
                                    <div style="display: flex; flex-direction: column; gap: 2px">
                                        <p class="status-label ${r.status}">${r.status}</p>
                                        <div class="total-cost">$${r.totalCost}</div>
                                    </div>
                                    <c:if test="${r.status == 'Pending'}">
                                        <div style="display:flex; gap: 3px">
                                            <button class="btn"
                                                    style="background-color:#374151; color:white; border:none;"
                                                    type="button"
                                                    onclick="if(confirm('Are you sure you want to cancel this registration?')) { window.location.href='user_cancel_registration?id=${r.id}'; }"
                                            >Cancel
                                            </button>
                                            <button class="btn"
                                                    style="background-color:#00897B; color:white; border:none;"
                                                    type="button"
                                                    onclick="location.href='user_modify_registration?id=${r.id}'"
                                            >Modify
                                            </button>
                                        </div>
                                    </c:if>

                                </div>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="./layout/footer.jsp"/>
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
<style>
    /* Xoá bo góc nút accordion */
    .accordion-button {
        border-radius: 0 !important;
    }

    /* Xoá bo góc phần chứa nội dung khi mở ra */
    .accordion-item {
        border-radius: 0 !important;
    }

    .subject-media {
        border: 1px black solid;
        border-radius: 10px;
    }

    .subject-thumbnail {
        width: 250px;
        height: 200px;
        margin-left: 10px;
    }

    .price_register_button {
        display: flex;
        flex-direction: column;
        align-items: flex-end; /* căn tất cả nội dung sang phải */
        justify-content: space-between;
        height: 200px; /* hoặc 100%, nếu cha có chiều cao xác định */
    }

    .col-md-2 button {
        margin-top: auto; /* đẩy nút xuống dưới cùng */
    }


    .status-label {
        display: inline-block;
        min-width: 80px;
        text-align: center;
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 0.875rem;
        font-weight: 600;
        text-transform: capitalize;
    }

    /* Màu nền nhạt theo từng trạng thái */
    .status-label.Pending {
        background-color: #fef3c7; /* vàng nhạt */
        color: #b45309;
    }

    .status-label.Paid {
        background-color: #d1fae5; /* xanh lá nhạt */
        color: #065f46;
    }

    .status-label.Expired {
        background-color: #fee2e2; /* đỏ nhạt */
        color: #991b1b;
    }

    .status-label.Canceled {
        background-color: #e5e7eb; /* xám nhạt */
        color: #374151;
    }


    .register-time {
        background-color: #e0f2fe; /* xanh dương nhạt */
        color: #0369a1; /* xanh dương đậm */
        padding: 3px 8px;
        border-radius: 6px;
        font-weight: 500;
        font-size: 0.875rem;
    }

    .package-label {
        background-color: #fef9c3; /* vàng nhạt hoặc đổi theo từng package */
        color: #92400e; /* vàng đậm */
        padding: 3px 8px;
        font-weight: 500;
        font-size: 0.875rem;
        border-radius: 2px; /* bo rất nhẹ */
    }


    .date-range {
        font-size: 0.85rem;
        color: #6b7280; /* text-gray-600 */
        line-height: 1.5;
        margin-bottom: 8px;
    }

    .date-range div {
        display: flex;
        align-items: center;
        gap: 4px;
    }


    .total-cost {
        font-size: 1rem;
        font-weight: 700;
        color: #065f46;
        text-align: center;
    }


</style>
</html>
