<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 23/05/2025
  Time: 5:25 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <header class="app-header">
        <ul class="app-nav">
            <li class="dropdown"><a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Open Profile Menu"><i class="bi bi-person fs-4"></i></a>
                <ul class="dropdown-menu settings-menu dropdown-menu-right">
                    <li>
                        <span class="dropdown-item" data-bs-toggle="modal" data-bs-target="#userProfile" style="cursor: pointer">
                            <i class="bi bi-person me-2 fs-5"></i> User profile
                        </span>
                    </li>
                    <li>
                        <a class="dropdown-item" style="cursor: pointer" href="change-password">
                            <i class="bi bi-gear me-2 fs-5"></i> Change password
                        </a>
                    </li>
                    <li>
                        <span class="dropdown-item" style="cursor: pointer">
                            <i class="bi bi-box-arrow-right me-2 fs-5"></i> Logout
                        </span>
                    </li>
                </ul>
            </li>
        </ul>
    </header>
</body>
</html>
