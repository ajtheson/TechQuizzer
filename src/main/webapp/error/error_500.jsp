<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 23/07/2025
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error Page</title>
    <%@include file="../common/headload.jsp" %>

    <style>
        .page-error {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100%;
            text-align: center;
        }

        /* Full height layout */
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }

        .wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
    </style>
</head>

<body>
<div class="wrapper">
    <div class="page-error">
        <h1 class="text-danger">
            <i class="bi bi-exclamation-circle"></i> Unexpected Error Occurred
        </h1>
        <p>Sorry! Something went wrong on our side.</p>
        <p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/home"
            >Go Home Page</a
            >
        </p>
    </div>
</div>
<%@include file="../layout/footer.jsp"%>
<%@include file="../common/jsload.jsp" %>
</body>
</html>
