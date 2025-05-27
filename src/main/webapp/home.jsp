<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 23/05/2025
  Time: 10:44 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<div style="height: 600px; width: 100%">
    <div id="carouselExample" class="carousel slide">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_1.png" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_2.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_3.png" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>



</body>

</html>
