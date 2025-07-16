<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 06/06/2025
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
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
        <h4 class="text-center user-name">Register Subject</h4>
        <form class="unlock-form" action="activate_register_subject" method="post">
            <div class="mb-3">
                <input
                        class="form-control"
                        type="password"
                        placeholder="Input OTP here"
                        required
                        name="otp"
                />
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-primary btn-block" type="submit">
                    <i class="bi bi-unlock me-2 fs-5"></i>Active
                </button>
            </div>
            <div class="mb-3 btn-container d-grid">
                <button class="btn btn-secondary btn-block" onclick="location.href='resend_otp'">
                    <i class="bi bi-unlock me-2 fs-5"></i>Resend
                </button>
            </div>
        </form>
        <div class="alert alert-success text-center" role="alert">
            Use OTP has been sent to your email to confirm your registration
        </div>
        <c:if test="${fn:length(fn:trim(requestScope.error)) > 0}">
            <div class="alert alert-danger text-center" role="alert">
                    ${requestScope.error}
            </div>
        </c:if>
        <p><a href="../account/login.jsp">Cancel ? Login Here.</a></p>
    </div>
</section>
<%@include file="../layout/footer.jsp" %>
<%@include file="../common/jsload.jsp" %>
</body>
</html>