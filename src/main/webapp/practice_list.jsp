<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 09/06/2025
  Time: 2:10 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Practice List</title>
</head>
<body>

<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<div class="container" style="margin-top: 100px">

    <%-- Trên cards: select + btnNew + btnSimulation --%>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex gap-3">
            <select id="subjectList" class="form-select w-auto">
                <option value="all">All Subjects</option>
                <c:forEach var="subject" items="${requestScope.registrationSubjects}">
                    <option ${requestScope.filter == subject.getId() ? 'selected' : ''}
                            value="${subject.getId()}">${subject.getName()}</option>
                </c:forEach>
            </select>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/practices/create" class="btn btn-primary">New Practice</a>
            <a href="${pageContext.request.contextPath}/simulation-exam" class="btn btn-outline-secondary">Simulation Exam</a>
        </div>
    </div>

    <%-- Cards: gồm các card --%>
    <div style="min-height: 500px">
        <c:if test="${not empty requestScope.practices}">
            <c:forEach var="practice" items="${requestScope.practices}">
                <div class="border mb-4">
                    <div class="row text-center border-bottom g-0">
                        <div class="col-4 py-3" style="border-right: 1px solid #dee2e6;">
                            <span>${practice.getSubject().getName()}</span><br>
                            <span>${practice.getName()}</span>
                        </div>
                        <div class="col-2 py-3" style="border-right: 1px solid #dee2e6;">
                            <span>${practice.getExamAttempt().getStartDate()}</span><br>
                            <span>Date taken</span>
                        </div>
                        <div class="col-2 py-3" style="border-right: 1px solid #dee2e6;">
                            <span>${practice.getExamAttempt().getNumberCorrectQuestions()} Correct</span><br>
                            <span>${practice.getNumberOfQuestions()} Questions</span>
                        </div>
                        <div class="col-2 py-3" style="border-right: 1px solid #dee2e6;">
                            <span><fmt:formatNumber value="${practice.getExamAttempt().getNumberCorrectQuestions() * 100 / practice.getNumberOfQuestions()}" type="number" maxFractionDigits="0"/>%</span><br/>
                            <span>Correct</span>
                        </div>
                        <div class="col-2 py-3">
                            <a href="${pageContext.request.contextPath}/practice/detail?id=${practice.getId()}">View Details</a>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between px-3 py-2">
                        <div>
                            <span>Level: ${practice.getLevelString()}</span>
                        </div>
                        <div>
                            <span>Duration - ${practice.getFormattedDuration()}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty requestScope.practices}">
            <div class="d-flex flex-column justify-content-center align-items-center text-muted" style="min-height: 300px;">
                <i class="bi bi-folder-x" style="font-size: 2rem;"></i>
                <span class="mt-2">No data </span>
            </div>
        </c:if>

        <%-- Dưới cards: items per page + pagination --%>
        <div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-5">

            <div class="d-flex align-items-center me-3">
                <label for="size" class="me-2 mb-0">Items per page:</label>
                <input type="number" min="1" name="size" class="form-control me-2" style="width: 80px;"
                       value="${requestScope.size}" id="sizeInput">
                <button type="submit" class="btn btn-primary btn-sm" id="sizeBtn">Apply</button>
            </div>

            <nav>
                <ul class="pagination mb-0">
                    <li class="page-item ${requestScope.page == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${requestScope.page - 1}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Previous</a>
                    </li>

                    <c:forEach var="i" begin="1" end="${requestScope.totalPages}">
                        <c:choose>
                            <c:when test="${i == requestScope.page}">
                                <li class="page-item active">
                                    <span class="page-link">${i}</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="?page=${i}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <li class="page-item ${requestScope.page == requestScope.totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${requestScope.page + 1}&size=${requestScope.size}${requestScope.filter != 0 ? '&filter='.concat(requestScope.filter) : ''}${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

</div>

<jsp:include page="./layout/footer.jsp"/>

</body>

<script>

    const filter = ${requestScope.filter};
    const size = ${requestScope.size};

    document.getElementById("sizeBtn").addEventListener("click", (e) => {
        let url = "?page=1&size=" + document.getElementById("sizeInput").value;
        if (filter !== 0) {
            url += "&filter=" + filter;
        }
        window.location.href = url
    });

    document.getElementById("subjectList").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (e.target.value !== "all") {
            url += "&filter=" + e.target.value
        }
        window.location.href = url
    });


</script>
</html>
