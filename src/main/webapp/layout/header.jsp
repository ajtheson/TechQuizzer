<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 23/05/2025
  Time: 5:25 CH
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header class="app-header">
    <%--logo--%>
    <a class="app-header__logo" href="${pageContext.request.contextPath}/home">TechQuizzer</a>
    <%--left side--%>
    <ul class="nav nav-underline mx-3">
        <li class="nav-item" style="padding-left: 20px">
            <a class="nav-link text-white d-flex align-items-center gap-2" href="subjects" style="padding: 14px 0 5px 0;">
                <i class="bi bi-book"></i>
                <h5 style="margin: 0">Subject</h5>
            </a>
        </li>
        <c:if test="${sessionScope.user != null}">
            <li class="nav-item" style="padding-left: 20px">
                <a class="nav-link text-white d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/practices"
                   style="padding: 14px 0 5px 0;">
                    <i class="bi bi-pencil-square"></i>
                    <h5 style="margin: 0">Practice</h5></a>
            </li>
        </c:if>
    </ul>

    <%--right side--%>

    <ul class="app-nav">
        <c:choose>
            <c:when test="${sessionScope.user != null}">
                <li class="dropdown"><a class="app-nav__item" href="#" data-bs-toggle="dropdown"
                                        aria-label="Open Profile Menu">
                    <i class="bi bi-person fs-4"></i></a>
                    <ul class="dropdown-menu settings-menu dropdown-menu-right">
                        <li>
                            <span class="dropdown-item" data-bs-toggle="modal" data-bs-target="#userProfile"
                                  style="cursor: pointer">
                                <i class="bi bi-person me-2 fs-5"></i> User profile
                            </span>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/my_registration">
                                <i class="bi bi-archive me-2 fs-5"></i> My registration
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">
                                <i class="bi bi-gear me-2 fs-5"></i> Change password
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2 fs-5"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </c:when>
            <c:otherwise>
                <a class="nav-link text-white d-flex align-items-center" href="${pageContext.request.contextPath}/account/login" style="padding: 5px 0 5px 0;">
                    <h5 style="margin: 0">Login</h5>
                </a>
            </c:otherwise>
        </c:choose>
    </ul>

</header>
</body>
</html>
