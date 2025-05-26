<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 24/05/2025
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>TechQuizzer - Forgot Password</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="login-box" style="min-width: 380px; min-height: 300px">
        <form class="login-form" action="forgot_password" method="post">
            <h3 class="login-head">
                <i class="fa fa-lock fa-lg fa-fw"></i> FORGOT PASSWORD
            </h3>
            <label class="control-label">Email</label>
            <div class="form-group mb-3">
                <input
                        class="form-control"
                        type="text"
                        placeholder="Email"
                        autofocus
                        pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                        title="Please enter a valid email address (e.g., example@email.com)"
                        name="email"
                        required
                />
            </div>
            <p style="text-align: center; color: red">${requestScope.error}</p>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block">
                    <i class="fa fa-unlock fa-lg fa-fw"></i> Reset
                </button>
            </div>
            <div style="margin-top: 10px; font-size: 14px">
                <a
                        href="login"
                        style="
                color: #007bff;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
              "
                >
                    <i class="fa fa-arrow-left" aria-hidden="true"></i> Back to login
                </a>
            </div>
        </form>
    </div>
</section>
<%@include file="common/jsload.jsp" %>
</body>
</html>