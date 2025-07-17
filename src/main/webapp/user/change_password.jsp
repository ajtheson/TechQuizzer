<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 23-May-25
  Time: 3:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Change Password</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="login-box" style="min-height: 480px; min-width: 800px;">
        <form class="login-form" action="${pageContext.request.contextPath}/user/change-password" method="post">
            <h3 class="login-head"><i class="bi bi-person-lock me-2"></i>   CHANGE PASSWORD</h3>
            <div class="mb-3">
                <label class="form-label">Current Pasword</label>
                <input class="form-control" type="password" autofocus name="currentPassword" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{8,16}$"
                       title="Password must be 8-16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character">
            </div>
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input class="form-control" type="password" name="newPassword" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{8,16}$"
                       title="Password must be 8-16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character">
            </div>
            <div class="mb-3">
                <label class="form-label">Confirm New Password</label>
                <input class="form-control" type="password" name="confirmPassword" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{8,16}$"
                       title="Password must be 8-16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character">
            </div>
            <p style="text-align: center; color: red">${error}</p>
            <p style="text-align: center; color: green">${success}</p>
            <div class="row justify-content-end">
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <button class="btn btn-primary">
                            <i class="bi bi-box-arrow-in-right me-2 fs-5"></i> Change password
                        </button>
                        <a class="btn btn-light border border-secondary text-dark" href="${pageContext.request.contextPath}/account/user">
                            Cancel
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<%@include file="../layout/footer.jsp"%>
</body>
<%--Script to check if the password and confirm password match.--%>
<script>
    document.querySelector('.login-form').addEventListener('submit', function (e) {
        const newPassword = document.querySelector('input[name="newPassword"]').value;
        const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert("Confirm password must match the password.");
        }
    });
</script>
<%@include file="../common/jsload.jsp" %>
</html>
