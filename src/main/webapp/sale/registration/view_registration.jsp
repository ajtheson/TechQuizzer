<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 30/06/2025
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../../common/headload.jsp"/>
    <title>View Registration</title>
</head>
<jsp:include page="../../user/user_profile.jsp"/>
<body>
<jsp:include page="../../layout/manage/sale_header.jsp"/>
<body>
<div class="container" style="margin-top: 100px; max-width: 900px">
    <div class="form-container">
        <h5 class="fw-bold mb-3">Registration Information</h5>
        <div class="row mb-3" style="display: flex">
            <div class="form-group" style="flex: 1">
                <label class="form-label">Subject</label>
                <input class="form-control" readonly value="${r.subject.name}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Package</label>
                <input class="form-control" readonly value="${r.pricePackage.name}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Registration Time</label>
                <input class="form-control" readonly value="${r.time}">
            </div>
        </div>

        <c:set var="listPrice" value="${r.pricePackage.listPrice}"/>
        <c:set var="salePrice" value="${r.pricePackage.salePrice}"/>
        <c:choose>
            <c:when test="${listPrice != 0}">
                <c:set var="sale" value="${((listPrice - salePrice) / listPrice) * 100}"/>
            </c:when>
            <c:otherwise>
                <c:set var="sale" value="0"/>
            </c:otherwise>
        </c:choose>
        <div class="row mb-3" style="display: flex">
            <div class="form-group" style="flex: 1">
                <label class="form-label">List Price</label>
                <input class="form-control" readonly value="${r.pricePackage.listPrice}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Sale Price</label>
                <input class="form-control" readonly value="${r.pricePackage.salePrice}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Sale</label>
                <input class="form-control" readonly value="${fn:substringBefore(sale, '.')}%">
            </div>
        </div>


        <div class="row mb-3" style="display: flex">
            <div class="form-group" style="flex: 1">
                <label class="form-label">Status</label>
                <input class="form-control" readonly value="${r.status}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Valid From</label>
                <input class="form-control" readonly value="${r.validFrom}">
            </div>
            <div class="form-group" style="flex: 1" >
                <label class="form-label">Valid To</label>
                <input class="form-control" readonly value="${r.validTo}">
            </div>
        </div>

        <h5 class="fw-bold mb-3 mt-4">Personal Information</h5>
        <div class="row mb-3" style="display: flex">
            <div class="form-group" style="flex: 1">
                <label class="form-label">Full Name</label>
                <input class="form-control" readonly value="${r.user.name}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Email</label>
                <input class="form-control" readonly value="${r.user.email}">
            </div>
            <div class="form-group" style="flex: 1">
                <label class="form-label">Mobile</label>
                <input class="form-control" readonly value="${r.user.mobile}">
            </div>
        </div>
        <h5 class="fw-bold mb-3">Note</h5>
        <div class="mb-3">
            <textarea
                    rows="3"
                    class="form-control"
                    readonly
            >${r.note}</textarea>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="button" class="btn btn-secondary" onclick="location.href='list'">Back</button>
            <button type="button" class="btn btn-success" onclick="location.href='edit?id=${r.id}'">Update</button>
        </div>
    </div>
</div>
</body>
</html>