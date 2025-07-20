<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 08/07/2025
  Time: 10:55 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <jsp:include page="../common/headload.jsp"/>
  <title>Dimension Detail</title>
</head>
<body class="app sidebar-mini">

<jsp:include page="../layout/manage/header.jsp"/>
<jsp:include page="../layout/manage/sidebar.jsp"/>

<main class="app-content">
  <div class="app-title">
    <div>
      <h1><i class="bi bi-diagram-3"></i> Dimension Detail</h1>
    </div>
    <ul class="app-breadcrumb breadcrumb">
      <li class="breadcrumb-item"><a href="list?id=${dimension.subjectDTO.id}">Dimensions</a></li>
      <li class="breadcrumb-item active">Detail</li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-8 offset-md-2">
      <div class="tile">
        <div class="tile-body">
          <!-- Thông tin chi tiết Dimension -->
          <p><strong>Name:</strong> ${dimension.name}</p>
          <p><strong>Type:</strong> ${dimension.type}</p>
          <p><strong>Description:</strong> ${dimension.description}</p>
          <p><strong>Subject:</strong> ${dimension.subjectDTO.name}</p>

          <c:if test="${currentUser != null && currentUser.roleId == 1}">
            <p><strong>Expert:</strong> ${dimension.subjectDTO.ownerName}</p>
          </c:if>

          <!-- Button -->
          <div class="mt-3">
            <a href="list?id=${dimension.subjectDTO.id}" class="btn btn-secondary">Back to List</a>
            <a style="color: white" href="edit?id=${dimension.id}" class="btn btn-warning">Edit Dimension</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<%@include file="../common/jsload.jsp" %>
</body>
</html>

