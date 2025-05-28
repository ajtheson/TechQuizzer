<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<div>
    <h1>Index</h1>
    <% response.sendRedirect(request.getContextPath() + "/login");%>
</div>
</body>
</html>