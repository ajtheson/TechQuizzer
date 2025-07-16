<%-- JSP directives --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Add Registration</title>

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
</head>
<jsp:include page="../user/user_profile.jsp"/>
<body>
<jsp:include page="../layout/manage/sale_header.jsp"/>

<div class="container" style="margin-top: 100px; max-width: 800px">
    <div class="form-container">
        <form method="post" action="create_registration">
            <input type="hidden" name="id" value="${r.id}">
            <h5 class="fw-bold mb-3">Create Registration</h5>

            <div class="row mb-3" style="display: flex">
                <div class="form-group" style="flex: 1">
                    <label class="form-label">User Email</label>
                    <select class="form-select search-select" name="user" required>
                        <option selected disabled value="">Select User</option>
                        <c:forEach var="u" items="${requestScope.users}">
                            <option value="${u.id}">${u.email}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Subject</label>
                    <select class="form-select search-select" name="subject" required id="subject">
                        <option selected disabled value="">Select Subject</option>
                        <c:forEach var="s" items="${requestScope.subjects}">
                            <option value="${s.id}">${s.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="row mb-3" style="display: flex">
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Package</label>
                    <select class="form-select" name="package" required id="package">
                        <option selected disabled value="">Select Package</option>
                    </select>
                </div>
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Status</label>
                    <select class="form-select" name="status" required>
                        <option selected disabled value="">Select Status</option>
                        <option value="Pending Confirmation">Pending Confirmation</option>
                        <option value="Pending Payment">Pending Payment</option>
                        <option value="Paid">Paid</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3" style="display: flex">
                <div class="form-group" style="flex: 1">
                    <label class="form-label">Note</label>
                    <input class="form-control" type="text" name="note">
                </div>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button type="button" class="btn btn-secondary" onclick="location.href='registrations'">Back</button>
                <button type="submit" class="btn btn-success">Create</button>
            </div>
        </form>
    </div>
</div>

<%@include file="../common/jsload.jsp" %>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $(document).ready(function () {
        // Khởi tạo Select2
        $(".search-select").select2({
            placeholder: "-- Select --",
            allowClear: true
        });

        const allPackages = [];
        <c:forEach var="p" items="${requestScope.packages}">
        allPackages.push({
            id: ${p.getId()},
            name: "${p.getName()}",
            subjectId: ${p.getSubjectId()}
        });
        </c:forEach>

        const packageSelect = document.getElementById('package');

        // Khi chọn subject -> lọc package
        $('#subject').on('change', function () {
            const subjectId = parseInt($(this).val());

            packageSelect.innerHTML = "<option value='' selected disabled>Select Package</option>";

            const filteredPacs = allPackages.filter(p => p.subjectId === subjectId);
            filteredPacs.forEach(p => {
                const opt = document.createElement("option");
                opt.value = p.id;
                opt.text = p.name;
                packageSelect.appendChild(opt);
            });
        });

        // Chặn chọn package nếu chưa chọn subject
        packageSelect.addEventListener("click", function (e) {
            if (!$('#subject').val()) {
                e.preventDefault();
                alert("Please choose subject before choosing package");
                packageSelect.blur();
            }
        });
    });
</script>
</body>
</html>
