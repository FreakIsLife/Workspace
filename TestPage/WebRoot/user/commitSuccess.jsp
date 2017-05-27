<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>页面错误 404</title>
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

<div class="error-block">
	<h3>操作成功！</h3>
	<p>请选择下一步进行的操作：</p>
	<p>
		<a class="flushPage" href='<c:url value="/user/myOrder.jsp"></c:url>'>查看订单</a>
	</p>
	<p>
		<a href="${pageContext.request.contextPath }">返回主页</a>
	</p>
</div>
