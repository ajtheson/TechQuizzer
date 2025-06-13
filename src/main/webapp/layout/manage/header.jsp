<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 13-Jun-25
  Time: 8:59 AM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Navbar-->
<header class="app-header"><a class="app-header__logo" href="home">TechQuizzer</a>
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="home" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <!-- User Menu-->
        <li class="dropdown"><a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Open Profile Menu"><i
                class="bi bi-person fs-4"></i></a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
                <li>
                     <span class="dropdown-item" data-bs-toggle="modal" data-bs-target="#userProfile"
                           style="cursor: pointer"><i class="bi bi-person me-2 fs-5"></i> User profile
                     </span>
                </li>
                <li><a class="dropdown-item" href="change-password"><i class="bi bi-person me-2 fs-5"></i> Change
                    Password</a>
                </li>
                <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2 fs-5"></i>
                    Logout</a></li>
            </ul>
        </li>
    </ul>
</header>
</body>
</html>
