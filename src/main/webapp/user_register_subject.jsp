<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 05/06/2025
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <jsp:include page="./layout/header.jsp"/>
    <jsp:include page="./user_profile.jsp"/>
    <title>Register Subject</title>
    <style>
        body{
            display: flex;
            flex-direction: column;
        }
        .package-btn {
            padding: 6px 12px;
            margin-right: 10px;
            background-color: lightgray;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .package-btn.active {
            border: 2px solid green;
            background-color: white;
            font-weight: bold;
        }
        .subject-thumbnail {
            width: 100%;
            aspect-ratio: 1 / 1;
            object-fit: cover;
        }
        .package-price {
            font-size: 18px;
            font-weight: bold;
            color: #08645c; /* xanh lá đậm */
        }


        .list-price {
            text-decoration: line-through;
            color: gray;
            font-size: 14px;
            margin-left: 10px;
        }
    </style>
</head>
<body onload="initPackages()">
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>

    <div class="login-box" style="min-height: 465px; min-width: 650px;">
        <div class="row">
            <!-- Form -->
            <div class="col-md-7">
                <form class="login-form row" action="user_register_subject" method="post">
                    <h3 class="login-head"><i class="bi bi-journal-plus me-2"></i>REGISTER SUBJECT</h3>
                    <!-- Thumbnail -->
                    <div class="col-md-5 text-center">
                        <img class="subject-thumbnail" src="assets/images/thumbnail/subject/${subject.thumbnail}" alt="${subject.name}">
                    </div>

                    <div class="col-md-7">
                        <!-- Subject Title -->
                        <h4>${subject.name}</h4>

                        <!-- Price -->
                        <div class="mb-3 package-price">
                            <span id="salePrice"></span>
                            <span id="listPrice" class="list-price"></span>
                        </div>

                        <!-- Package Selection -->
                        <div class="mb-3">
                            <c:forEach var="p" items="${packages}">
                                <button type="button" class="package-btn mb-2" id="btn-${p.id}"
                                        onclick="selectPackage(${p.id})">${p.name}</button>
                            </c:forEach>
                        </div>

                        <input type="hidden" name="subjectId" value="${subject.id}">
                        <input type="hidden" name="packageId" id="selectedPackageId" value="">
                        <!-- Register Button -->
                        <div class="row justify-content-end">
                            <div class="col-auto">
                                <div class="d-flex gap-2">
                                    <button class="btn btn-primary">
                                        <i class="bi bi-check2-circle me-2 fs-5"></i> Register
                                    </button>
                                    <a href="home" class="btn btn-light border border-secondary text-dark">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    let packages = [];

    function initPackages() {
        packages = [
            <c:forEach var="p" items="${packages}" varStatus="loop">
            {
                id: ${p.id},
                name: '${p.name}',
                salePrice: ${p.salePrice},
                listPrice: ${p.listPrice}
            }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        selectPackage(packages[0].id);
    }

    function selectPackage(id) {
        const salePriceSpan = document.getElementById("salePrice");
        const listPriceSpan = document.getElementById("listPrice");
        const selectedInput = document.getElementById("selectedPackageId");

        packages.forEach(p => {
            const btn = document.getElementById("btn-" + p.id);
            if (p.id === id) {
                salePriceSpan.innerText = "$" + p.salePrice.toLocaleString();
                listPriceSpan.innerText = "$" + p.listPrice.toLocaleString();
                btn.classList.add("active");
                selectedInput.value = p.id;
            } else {
                btn.classList.remove("active");
            }
        });
    }
</script>
<%@include file="layout/footer.jsp" %>
<%@include file="common/jsload.jsp" %>
</body>
</html>
