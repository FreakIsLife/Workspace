<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="${showPage==null?'/user/index.jsp':showPage }"></jsp:include>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
