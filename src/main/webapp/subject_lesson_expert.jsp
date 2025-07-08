<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 03/07/2025
  Time: 3:36 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="./common/headload.jsp"/>
    <title>Lesson List</title>
</head>
<body class="app sidebar-mini">
<jsp:include page="./layout/manage/header.jsp"/>
<jsp:include page="./layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="lesson"/>
</jsp:include>
<jsp:include page="./user_profile.jsp"/>
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-book"></i> Lessons List</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="mb-3 text-start">
                        <a href="lesson-create" class="btn btn-primary">
                            <i class="bi bi-plus-lg me-1"></i> Add new lesson
                        </a>
                    </div>

                    <form method="get" action="subject-lesson-expert" class="d-flex align-items-center gap-3 mb-3">
                        <select name="subject" class="form-select" style="width: 250px;" onchange="this.form.submit()">
                            <option value="">All Subjects</option>
                            <c:forEach var="subject" items="${subjects}">
                                <option value="${subject.name}" <c:if test="${subject.name == selectedSubject}">selected</c:if>>
                                        ${subject.name}
                                </option>
                            </c:forEach>
                        </select>
                        <select name="lessonType" class="form-select" style="width: 250px;" onchange="this.form.submit()">
                            <option value="">All Lesson Types</option>
                            <c:forEach var="type" items="${lessonTypes}">
                                <option value="${type.name}" <c:if test="${type.name == selectedLessonType}">selected</c:if>>
                                        ${type.name}
                                </option>
                            </c:forEach>
                        </select>
                        Search: <input type="text" name="search" value="${search}" />
                        <input type="hidden" name="sortField" value="${sortField}" />
                        <input type="hidden" name="sortOrder" value="${sortOrder}" />
                        <input type="submit" value="Search" />
                    </form>

                    <table class="table table-hover table-bordered">
                        <thead>
                        <tr>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.id&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">ID<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Name<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.[order]&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Order<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;" href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.topic&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Topic<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;"  href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.video_link&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Video<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;"  href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=s.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Subject<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;"  href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=lt.name&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Lesson Type<i class="fa fa-sort"></i></a></th>
                            <th><a style="display: flex; align-items: center; gap: 5px; text-decoration: none; color: inherit;"  href="?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=l.status&sortOrder=${sortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}&pageSize=${pageSize}">Status<i class="fa fa-sort"></i></a></th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty lessonList}">
                            <h4>No Data</h4>
                        </c:if>
                        <c:forEach var="lesson" items="${lessonList}">
                            <tr>
                                <td>${lesson.id}</td>
                                <td>${lesson.name}</td>
                                <td>${lesson.order}</td>
                                <td>${lesson.topic}</td>
                                <td><a href="${lesson.videoLink}" target="_blank">Video</a></td>
                                <td>${lesson.subject.name}</td>
                                <td>${lesson.lessonType.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${lesson.status==true}">
                                            <a href="toggle-lesson-status-expert?action=changeStatusLesson&id=${lesson.id}&status=0"
                                               class="btn btn-success"
                                               onclick="return confirm('Are you sure you want to deactivate this quiz?');">
                                                Active
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="toggle-lesson-status-expert?action=changeStatusLesson&id=${lesson.id}&status=1"
                                               class="btn btn-danger"
                                               onclick="return confirm('Are you sure you want to activate this quiz?');">
                                                Inactive
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center gap-2">
                                        <a style="color: white" href="lesson-detail?id=${lesson.id}" class="btn btn-info btn-sm">View</a>
                                        <a style="color: white" href="lesson-edit?id=${lesson.id}" class="btn btn-warning btn-sm">Edit</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-end mt-3">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:set var="urlBase" value="subject-lesson-expert?subject=${subject}&lessonType=${lessonType}&search=${search}&sortField=${sortField}&sortOrder=${sortOrder}&pageSize=${pageSize}" />
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${urlBase}&page=${currentPage - 1}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${urlBase}&page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${urlBase}&page=${currentPage + 1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>
<%@ include file="common/jsload.jsp" %>
</body>
</html>


