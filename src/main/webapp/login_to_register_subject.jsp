<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 06/06/2025
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>TechQuizzer - Register Subject</title>
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="lockscreen-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>
    <div class="lock-box">
        <h4 class="text-center user-name">${requestScope.userName}</h4>
        <p class="text-center text-muted">Register Subject</p>
        <form class="unlock-form" action="login_to_register_subject" method="post">
            <div class="mb-3">
                <label class="control-label">PASSWORD</label>
                <input
                        class="form-control"
                        type="password"
                        placeholder="Password"
                        required
                        name="password"
                />
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block" type="submit">
                    <i class="bi bi-unlock me-2 fs-5"></i>LOGIN
                </button>
            </div>
        </form>
        <div class="alert alert-success text-center" role="alert">
            Account has been existed in system. Please sign in to register subject
        </div>
        <c:if test="${fn:length(fn:trim(requestScope.sendError)) > 0}">
            <div class="alert alert-danger text-center" role="alert">
                    ${requestScope.sendError}
            </div>
        </c:if>
        <p><a href="login.jsp">Not ${requestScope.userName} ? Login Here.</a></p>
    </div>
</section>
<%@include file="layout/footer.jsp" %>
<%@include file="common/jsload.jsp" %>
</body>
</html>