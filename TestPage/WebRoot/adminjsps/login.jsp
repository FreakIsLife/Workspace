<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>管理员登录</title>

<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	background-image: url('adminjsps/images/2.jpg');
	background-size: 100% 100%;
	background-attachment: fixed;
	background-position: center;
	background-repeat: no-repeat;
}

#div2 {
	height: 300px;
	width: 350px;
	margin-top: 80px;
	border: 1px solid #ffff;
	background-color: #F5F5F5;
	margin-top: 80px;
}

.title {
	height: 60px;
	background: bule;
}
</style>
</head>

<body>
	<div class="container">
		<div class="row col-md-offset-4 col-md-4" id="div2">
			<div class="title">
				<h3 class="text-center">
					<strong>类淘宝欢迎你</strong>
				</h3>
			</div>
			<form class="form"
				action="${pageContext.request.contextPath }/adminServlet?method=login"
				method="post" id="myForm">
				<div class="form-group">
					<div class="input-group ">
						<span class="input-group-addon"><span
							class="glyphicon glyphicon-user"></span></span> <input type="text"
							class="form-control" placeholder="请输入用户名" name="adminId">

					</div>
				</div>
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon"><span
							class="glyphicon glyphicon-lock"></span></span> <input type="password"
							class="form-control" id="inputPassword3" placeholder="请输入密码"
							name="adminPassword">
					</div>
				</div>
				<div class="col-md-6 col-md-offset-3">
					<button type="button" class="btn btn-info btn-block"
						onclick="myForm.submit()">登录</button>
				</div>
			</form>
		</div>
	</div>
	<script>
		if (${msg != null ? true:false}) {
			/* toastr.error(${msg}); */
			alert('${msg}');
		};
	</script>
</body>
</html>
