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
    <%@include file="common/headload.jsp" %>
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
    <div class="login-box">
        <form class="login-form" action="change-password" method="post">
            <h3 class="login-head"><i class="bi bi-person-lock me-2"></i>   CHANGE PASSWORD</h3>
            <div class="row justify-content-end">
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <button class="btn btn-primary">
                            <i class="bi bi bi-box-arrow-left me-2 fs-5"></i> Back to Login
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
</body>
</html>

