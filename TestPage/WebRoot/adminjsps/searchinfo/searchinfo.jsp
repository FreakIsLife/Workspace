<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>主页</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
	<div class="container">
		<form class="form">
			<table class="table table-bordered">
				<caption class="text-center">用户信息</caption>
				<tr>
					<th>用户名</th>
					<th>密码</th>
					<th>昵称</th>
					<th>姓名</th>
					<th>性别</th>
					<th>出生日期</th>
					<th>联系方式</th>
					<th>电子邮箱</th>
					<th>是否开店</th>
				</tr>
				<tr>
					<td>${userinfo.userId }</td>
					<td>${userinfo.userPassword}</td>
					<td>${userinfo.userNickname}</td>
					<td>${userinfo.userName}</td>
					<c:if test="${userinfo.userSex eq 0}">
						<td>保密</td>
					</c:if>
					<c:if test="${userinfo.userSex eq 1}">
						<td>男</td>
					</c:if>
					<c:if test="${userinfo.userSex eq -1}">
						<td>女</td>
					</c:if>

					<td>${userinfo.userBirth}</td>
					<td>${userinfo.userPhone}</td>
					<td>${userinfo.userMail}</td>
					<c:if test="${userinfo.userIsShop eq 0 }">
						<td>>开店</td>
					</c:if>
					<c:if test="${userinfo.userIsShop eq 1 }">
						<td>已开店</td>
					</c:if>
				</tr>
			</table>
		</form>
	</div>
	<c:if test="${shopinfo!=null }">
		<div>
			<form class="form1">
				<table class="table table-bordered">
					<caption class="text-center">商店信息</caption>
					<tr>
						<th>商店ID</th>
						<th>商店名称</th>
						<th>商店QQ</th>
						<th>开店日期</th>
					</tr>
					<tr>
						<td>${shopinfo.shopId }</td>
						<td>${shopinfo.shopName}</td>
						<td>${shopinfo.shopQQ}</td>
						<td>${shopinfo.shopStart}</td>
					</tr>
				</table>
			</form>
		</div>
	</c:if>
	<div style="text-align: center"><a href="adminjsps/home.jsp">返回主页</a></div>
</body>
</html>
