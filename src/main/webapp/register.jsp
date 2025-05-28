<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 21/05/2025
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>TechQuizzer - Register</title>
</head>
<body>
<c:set var="info" value="${requestScope.information}"/>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <c:choose>
        <c:when test="${fn:length(fn:trim(requestScope.error)) > 0}">
            <c:set var="boxHeight" value="645"/>
        </c:when>
        <c:otherwise>
            <c:set var="boxHeight" value="600"/>
        </c:otherwise>
    </c:choose>

    <div class="login-box" style="min-width: 430px; min-height: ${boxHeight}px">
        <form class="login-form" action="register" method="post">
            <h3 class="login-head">
                <i class="fa fa-lg fa-fw fa-user"></i>SIGN UP
            </h3>
            <label class="control-label mb-3">Personal Information</label>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="text"
                        placeholder="Full name"
                        autofocus
                        required
                        name="name"
                        value="${info.getName()}"
                />
            </div>
            <div class="form-group mb-3">
                <select class="form-control" required name="gender">
                    <option value="" disabled selected>Gender</option>
                    <option value="male" ${info.getGenderString() == 'male' ? 'selected' : ''}>Male</option>
                    <option value="female" ${info.getGenderString() == 'female' ? 'selected' : ''}>Female</option>
                    <option value="other" ${info.getGenderString() == 'other' ? 'selected' : ''}>Other</option>
                </select>
            </div>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="text"
                        placeholder="Address"
                        autofocus
                        required
                        name="address"
                        value="${info.getAddress()}"
                />
            </div>
            <label class="control-label mb-3">Account Information</label>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="email"
                        placeholder="Email"
                        autofocus
                        required
                        name="email"
                        pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                        title="Please enter a valid email address (e.g., example@email.com)"
                        value="${info.getEmail()}"
                />
            </div>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="text"
                        placeholder="Mobile"
                        autofocus
                        required
                        name="mobile"
                        pattern="0\d{9}"
                        title="Mobile number must start with 0 and be exactly 10 digits"
                        value="${info.getMobile()}"
                />
            </div>
            <div class="mb-3" style="display: flex; gap: 12px">
                <div class="form-group" style="flex: 1">
                    <input
                            class="form-control"
                            type="password"
                            placeholder="Password"
                            required
                            name="password"
                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$"
                            title="Password must be 8–16 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 number, 1 special character. No spaces allowed"
                            value="${info.getPassword()}"
                    />
                </div>
                <div class="form-group" style="flex: 1">
                    <input
                            class="form-control"
                            type="password"
                            placeholder="Confirm password"
                            required
                            name="confirmPassword"
                            value="${info.getConfirmPassword()}"
                    />
                </div>
            </div>
            <c:if test="${fn:length(fn:trim(requestScope.error)) > 0}">
                <div class="alert alert-danger text-center mt-3" role="alert" style="font-size: 14px;">
                        ${requestScope.error}
                </div>
            </c:if>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block">
                    <i class="fa fa-user-plus fa-lg fa-fw"></i> Register
                </button>
            </div>
            <div style="text-align: center; margin-top: 10px; font-size: 14px">
                Already have an account?
                <a href="login" style="color: #007bff; text-decoration: none"
                >Login</a
                >
            </div>
        </form>
    </div>
</section>
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