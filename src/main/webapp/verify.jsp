<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 22/05/2025
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>TechQuizzer - Verification</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="login-box" style="min-width: 380px; min-height: 250px">
        <form class="login-form" action="activate" method="post">
            <h3 class="login-head">
                <c:if test="${not empty requestScope.mode and requestScope.mode == 'register'}"><i class="fa fa-lg fa-fw fa-user"></i>SIGN UP</c:if>
                <c:if test="${not empty requestScope.mode and requestScope.mode == 'forgot_password'}"><i class="fa fa-lock fa-lg fa-fw"></i>FORGOT PASSWORD</c:if>
            </h3>
            <p style="text-align: center; color: green">
                ${requestScope.message}
            </p>
            <p style="text-align: center; color: red">
                ${requestScope.sendError}
            </p>

            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block">
                    <i class="fa fa-refresh fa-lg fa-fw"></i> Resend
                </button>
            </div>
        </form>
    </div>
</section>
<%@include file="common/jsload.jsp" %>
</body>
</html>