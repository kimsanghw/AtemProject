<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류</title>
    <script>
        alert("잘못된 접근입니다. 다시 시도해주세요");
        window.location.href = "<%=request.getContextPath()%>/index.jsp";
    </script>
</head>
<body>
</body>
</html>