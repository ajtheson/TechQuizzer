<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 22/05/2025
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>TechQuizzer - Reset Password</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <c:choose>
        <c:when test="${fn:length(fn:trim(requestScope.error)) > 0}">
            <c:set var="boxHeight" value="390"/>
        </c:when>
        <c:otherwise>
            <c:set var="boxHeight" value="345"/>
        </c:otherwise>
    </c:choose>
    <div class="login-box" style="min-width: 380px; min-height: ${boxHeight}px">
        <form class="login-form" action="reset_password" method="post">
            <input type="hidden" name="email" value="${requestScope.email}">
            <input type="hidden" name="resetToken" value="${sessionScope.resetToken}">
            <h3 class="login-head">
                <i class="fa fa-lock fa-lg fa-fw"></i> RESET PASSWORD
            </h3>
            <label class="control-label mb-3">Password</label>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="password"
                        placeholder="Password"
                        autofocus
                        required
                        name="password"
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$"
                        title="Password must be 8–16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, 1 special character. No spaces allowed"
                />
            </div>
            <label class="control-label mb-3">Confirm password</label>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="password"
                        placeholder="Confirm password"
                        autofocus
                        required
                        name="confirmPassword"
                />
            </div>
            <c:if test="${fn:length(fn:trim(requestScope.error)) > 0}">
                <div class="alert alert-danger text-center mt-3" role="alert" style="font-size: 14px;">
                        ${requestScope.error}
                </div>
            </c:if>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block">
                    <i class="fa fa-unlock fa-lg fa-fw"></i> Reset
                </button>
            </div>
        </form>
    </div>
</section>
<%@include file="layout/footer.jsp"%>
<%@include file="common/jsload.jsp" %>
<script>
    document.querySelector('.login-form').addEventListener('submit', function (e) {
        const password = document.querySelector('input[name="password"]').value;
        const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert("Confirm password must match the password.");
        }
    });
</script>
</body>
</html>