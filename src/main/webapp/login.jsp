<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 26/05/2025
  Time: 2:22 CH
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Login</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="login-box" style="height: 480px;">
        <form class="login-form" action="login" method="POST">
            <h3 class="login-head"><i class="bi bi-person me-2"></i>SIGN IN</h3>
            <div class="mb-3">
                <label class="form-label">EMAIL</label>
                <input class="form-control" type="email" name="email" placeholder="Email" autofocus>
            </div>
            <div class="mb-3">
                <label class="form-label">PASSWORD</label>
                <input class="form-control" type="password" name="password" placeholder="Password">
            </div>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger">${requestScope.error}</div>
            </c:if>
            <c:if test="${not empty requestScope.verifyNotification}">
                <div class="alert alert-info">${requestScope.verifyNotification}</div>
            </c:if>
            <div class="mb-3">
                <div class="utility d-flex justify-content-center">
                    <p class="semibold-text mb-2"><a href="forgot_password">Forgot Password ?</a></p>
                </div>
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block"><i class="bi bi-box-arrow-in-right me-2 fs-5"></i>SIGN IN</button>
            </div>
            <div class="mb-3 btn-container d-grid">
                <p class="semibold-text mb-2">Don't have an account? <a href="register" data-toggle="flip">Register Now</a></p>
            </div>
        </form>
    </div>
</section>
<%@include file="layout/footer.jsp"%>
<%@include file="common/jsload.jsp" %>
<!-- Page specific javascripts-->
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<!-- Data table plugin-->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
</body>
</html>
