<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 28-May-25
  Time: 9:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="../common/headload.jsp"/>
    <title>Change Password Success</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="login-box" style="height: 300px;">
        <form class="login-form" action="change-password" method="post">
            <h3 class="login-head text-center" style="margin-top: 80px;">Your password has been changed successfully</h3>
            <div class="text-center mt-4">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/account/login">
                    <i class="bi bi-box-arrow-left me-2 fs-5"></i> Back to Login
                </a>
            </div>
        </form>
    </div>
</section>
<%@include file="../layout/footer.jsp"%>
</body>
</html>

