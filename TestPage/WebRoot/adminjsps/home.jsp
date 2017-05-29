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

<title>主页</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>

</head>

<body>
	<nav class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#example-navbar-collapse">
					<span class="sr-only">切换导航</span> <span
						class="glyphicon .glyphicon-minus"></span> <span
						class="glyphicon .glyphicon-minus"></span> <span
						class="glyphicon .glyphicon-minus"></span>
				</button>
				<div class="navbar-header">
					<p class="navbar-brand">类淘宝</p>
				</div>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a
					href="${pageContext.request.contextPath }/adminServlet?method=logout"><span
						class="glyphicon glyphicon-out"></span>退出</a></li>
				<li><a><span class="glyphicon glyphicon-log-user"></span>
						欢迎，${loginAdmin.adminId }</a></li>
			</ul>
			<div class="collapse navbar-collapse" id="example-navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#" class="flushA">淘宝首页</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> 信息管理<b class="caret"></b>
					</a>
						<ul class="dropdown-menu">
							<li><a id="userinfo"
								href="${pageContext.request.contextPath }/adminServlet?method=load"
								class="flushA">查看用户信息</a></li>
							<li><a
								href="${pageContext.request.contextPath }/adminServlet?method=loadShop"
								class="flushA">查看商家信息</a></li>
							<li><a href="#myModal" data-toggle="modal">添加用户</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<form class="bs-example bs-example-form" role="form" action="${pageContext.request.contextPath }/adminServlet?method=searchId" method="post">
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="按用户名搜索"  name="Id"> <span
						class="input-group-btn">
						<button class="btn btn-default" type="submit">搜索</button>
					</span>
				</div>
			</div>
		</div>
	</form>
	<hr>

	<div id="container"></div>
	<!-- 使用模态框添加用户信息 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加用户</h4>
				</div>
				<div class="modal-body">
					<form
						action="${pageContext.request.contextPath }/adminServlet?method=addUser"
						method="post">
						<table class="table table-bordered">
							<caption>
								<strong>用户信息</strong>
							</caption>
							<tbody>
								<tr>
									<th>用户名</th>
									<td><input type="text" name="userId" id="userId"></td>
								</tr>
								<tr>
									<th>密码</th>
									<td><input type="password" name="userPassword"
										id="userPassword"></td>
								</tr>
								<tr>
									<th>昵称</th>
									<td><input type="text" name="userNickname"
										id="userNickname"></td>
								</tr>
								<tr>
									<th>姓名</th>
									<td><input type="text" name="userName" id="userName"></td>
								</tr>
								<tr>
									<th>性别</th>
									<td><input type="text" name="userSex" id="userSex"></td>
								</tr>
								<tr>
									<th>出生日期</th>
									<td><input type="text" name="userBirth" id="userBirth"></td>
								</tr>
								<tr>
									<th>联系方式</th>
									<td><input type="text" name="userPhone" id="userPhone"></td>
								</tr>
								<tr>
									<th>电子邮箱</th>
									<td><input type="text" name="userMail" id="userMail"></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary AddUserBtn" value="提交">提交</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 使用模态框添加商店信息 -->
	<div class="modal fade" id="shopModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">商店信息</h4>
				</div>
				<div class="modal-body">
					<form
						action="${pageContext.request.contextPath }/adminServlet?method=AddShop"
						method="post" id="addShopForm">
						<table class="table table-bordered">
							<tr>
								<th>商店ID</th>
								<td><input type="text" name="shopId" id="shopId" readonly></td>
							</tr>
							<tr>
								<th>商店名</th>
								<td><input type="text" name="shopName" id="shopName"></td>
							</tr>
							<tr>
								<th>qq联系方式</th>
								<td><input type="text" name="shopQQ" id="shopQQ"></td>
							</tr>
							<tr>
								<td colspan='2' style="text-align: center"><button
										type="submit" class="btn btn-primary" value="提交">提交</button></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 加载用户信息 -->
	<script>
		$(function() {
			$(document).on('click', '.flushA', function(event) {
				event.preventDefault();
				var url = $(this).attr('href');
				var data = {
					type : 1
				};
				$.ajax({
					type : "post",
					url : url,
					data : data,
					timeout : 10000,
					success : function(dates) {
						$("#container").html(dates);// 要刷新的div
					},
					error : function() {
						alert("连接超时失败，请稍后再试！");
					}
				});
			});
		});

		/* 添加用户后重新加载信息模态框 */
		$(document).on('click', '.AddUserBtn', function() {
			var $submitForm = $($(this).parent().prev().find('form'));
			var submitUrl = $submitForm.attr('action');
			var submitMsg = $submitForm.serialize();
			$.ajax({
				url : submitUrl,
				data : submitMsg,
				type : 'post',
				dataType : 'text',
				success : function(msg) {
					if (msg.length > 0) {
						alert(msg);
					} else {
						/* location.reload(); */
						$submitForm.parents('.modal').modal('hide');
						$('#userinfo').click();
					}
				},
				error : function() {
					alert("加载失败");
				}
			})
		});
		/* 修改用户信息后重新加载用户信息 */
		$(document).on('click', '.EditSubmitbtn', function() {
			var $submitForm = $($(this).parent().prev().find('form'));
			var submitUrl = $submitForm.attr('action');
			var submitMsg = $submitForm.serialize();
			$.ajax({
				url : submitUrl,
				data : submitMsg,
				type : 'post',
				dataType : 'text',
				success : function(msg) {
					if (msg.length > 0) {
						alert(msg);
					} else {

						$submitForm.parents('.modal').modal('toggle');
						setTimeout(function() {
							$('#userinfo').click();
						}, 500);

					}
				},
				error : function() {
					alert("加载失败");
				}
			});
		});
	</script>
</body>
</html>
