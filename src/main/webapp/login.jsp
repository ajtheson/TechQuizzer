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
        <form class="login-form" action="Login" method="POST">
            <h3 class="login-head"><i class="bi bi-person me-2"></i>SIGN IN</h3>
            <div class="mb-3">
                <label class="form-label">EMAIL</label>
                <input class="form-control" type="email" name="email" placeholder="Email" autofocus>
            </div>
            <div class="mb-3">
                <label class="form-label">PASSWORD</label>
                <input class="form-control" type="password" name="password" placeholder="Password">
            </div>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>
            <c:if test="${not empty requestScope.verifyNotification}">
                <div class="alert alert-info">${requestScope.verifyNotification}</div>
            </c:if>
            <div class="mb-3">
                <div class="utility">
                    <div class="form-check">
                        <label class="form-check-label">
                            <input class="form-check-input" type="checkbox"><span class="label-text">Stay Signed in</span>
                        </label>
                    </div>
                    <p class="semibold-text mb-2"><a href="#" data-toggle="flip">Forgot Password ?</a></p>
                </div>
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block"><i class="bi bi-box-arrow-in-right me-2 fs-5"></i>SIGN IN</button>
            </div>
            <div class="mb-3 btn-container d-grid">
                <p class="semibold-text mb-2">Don't have an account? <a href="#" data-toggle="flip">Register Now</a></p>
            </div>

        </form>
        <form class="forget-form" action="index.html">
            <h3 class="login-head"><i class="bi bi-person-lock me-2"></i>Forgot Password ?</h3>
            <div class="mb-3">
                <label class="form-label">EMAIL</label>
                <input class="form-control" type="text" placeholder="Email">
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block"><i class="bi bi-unlock me-2 fs-5"></i>RESET</button>
            </div>
            <div class="mb-3 mt-3">
                <p class="semibold-text mb-0"><a href="#" data-toggle="flip"><i class="bi bi-chevron-left me-1"></i> Back to Login</a></p>
            </div>
        </form>
    </div>
</section>
<%@include file="common/jsload.jsp" %>
<!-- Page specific javascripts-->
<link rel="stylesheet" href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css">
<!-- Data table plugin-->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
</body>
</html>
