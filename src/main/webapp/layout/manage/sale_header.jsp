<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 30/06/2025
  Time: 08:28
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header class="app-header">
    <%--logo--%>
    <a class="app-header__logo" href="${pageContext.request.contextPath}/sale/registration/list">TechQuizzer</a>
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
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user/change-password">
                                <i class="bi bi-gear me-2 fs-5"></i> Change password
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/account/logout">
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
