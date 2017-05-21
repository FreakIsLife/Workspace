<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>拒绝访问</title>
<style type="text/css">
body {
	margin: 0px auto;
	text-align: center;
}

.error-block {
	position: absolute;
	width: 100%;
	top: 50%;
	left: 50%;
	margin-top: -86px;
	margin-left: -178px;
	text-align: left;
	width: auto;
	margin-top: -86px;
}

p {
	font-size: small;
}
</style>
</head>

<body>
	<div class="error-block">
		<h3>${msg }</h3>
		<p>请选择下一步进行的操作：</p>
		<p>
			<a href="javascript:history.go(-1)">返回上一页</a>
		</p>
		<p>
			<a href="${pageContext.request.contextPath }">返回主页</a>
		</p>
	</div>
</body>
</html>
