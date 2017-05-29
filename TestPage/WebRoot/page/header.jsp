<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand recoverA"
				href='<c:url value="/index.jsp"></c:url>'>类淘宝</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="active recoverA" data-toggle="tab">
					<a href='<c:url value="/index.jsp"></c:url>' data-toggle="tab">
						<span class="glyphicon glyphicon-home"></span>
						主页
					</a>
				</li>
			</ul>
			<form role="search" class="navbar-form navbar-left">
				<div class="form-group">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search"
							id="productName" />
						<span class="input-group-btn">
							<button class="btn searchBtn" type="submit">
								<span class="glyphicon glyphicon-search"></span>
								搜索
							</button>
						</span>
					</div>
				</div>
			</form>
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${not empty loginUser }">
					<c:if test="${loginUser.userIsShop eq 0 }">
						<li data-toggle="tab" class="recoverA">
							<a href='<c:url value="/user/setShop.jsp"></c:url>'>我要开店</a>
						</li>
					</c:if>
					<c:if test="${loginUser.userIsShop eq 1 }">
						<li data-toggle="tab" class="recoverA">
							<a href='<c:url value="/shop/shopMainPage.jsp"></c:url>'>进入店铺</a>
						</li>
					</c:if>
					<li id="cart">
						<a href='<c:url value="/user/myCart.jsp"></c:url>' role="button"
							aria-haspopup="true" aria-expanded="false"
							data-content='
								<table class="table" style="width:300px;margin-bottom:0;">
								<tbody>
									<tr>
										<td>
											<a href="#"><img src="/images/01_small.jpg"></img></a>
										</td>
										<td>
											<a href="#"><p class="cut" style="max-width:120px;">这是名称阿打算的撒发生法法师嘎嘎的噶</p></a>
											<p>这是好吃的东西</p>
										</td>
										<td>
											<p><span class="glyphicon glyphicon-jpy">36</span></p>
											<p><a href="#"><span class="glyphicon glyphicon-trash"></span></a></p>
										</td>
									</tr>
									<tr>
										<td colspan="3">
											<p class="text-right"><button class="btn btn-default">查看我的购物车</button></p>
										</td>
									</tr>
								</tbody>
							</table>
							'>
							<span class="glyphicon glyphicon-shopping-cart"></span>
							购物车
							<span class="badge" style="background-color:#4da4ef;">4</span>
						</a>
					</li>
				</c:if>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"
						role="button" aria-haspopup="true" aria-expanded="false">
						<c:if test="${empty loginUser }">
							游客你好！登录点这里！
						</c:if>
						<c:if test="${not empty loginUser }">
							<span class="glyphicon glyphicon-user"></span>
							${loginUser.userNickname }，欢迎你！
						</c:if>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<c:if test="${empty loginUser }">
							<li class="dropdown-header">您还未登录，请选择</li>
							<li data-toggle="tab">
								<a href="#loginModal" data-toggle="modal">登录</a>
							</li>
							<li data-toggle="tab">
								<a href="#registModal" data-toggle="modal">注册</a>
							</li>
						</c:if>
						<c:if test="${not empty loginUser }">
							<li data-toggle="tab" class="recoverA">
								<a href='<c:url value="/user/userCenter.jsp"></c:url>'>用户首页</a>
							</li>
							<li data-toggle="tab" class="recoverA">
								<a href='<c:url value="/user/information.jsp"></c:url>'>个人信息</a>
							</li>
							<li data-toggle="tab" class="recoverA">
								<a href="#">设置</a>
							</li>
							<li role="separator" class="divider"></li>
							<li data-toggle="tab">
								<a href="#logoutModal" data-toggle="modal">注销</a>
							</li>
						</c:if>
					</ul>
				</li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
</nav>
<!-- #模态框# -->
<!-- 登录模态框 -->
<div class="modal fade modalControl" id="loginModal" tabindex="-1"
	role="dialog" aria-labelledby="loginModalLabel">
	<div class="modal-dialog" role="document" style="width:400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="loginModalLabel">用户登录</h4>
			</div>
			<div class="modal-body">
				<form action="${ctx }/userServlet?method=login">
					<div class="form-group">
						<label for="userId" class="control-label">用户名：</label>
						<input type="text" class="form-control" id="userId" name="userId">
					</div>
					<div class="form-group">
						<label for="userPassword" class="control-label">密码：</label>
						<input type="password" class="form-control" id="userPassword"
							name="userPassword">
					</div>
					<div class="checkbox">
						<label>
							<input type="checkbox" name="remember-me" value="on">
							记住密码
						</label>
						<a href="#" class="pull-right">忘记密码?</a>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<!-- <div class="has-error pull-left">
					<label class="control-label error-text"></label>
				</div> -->
				<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
				<button type="button" class="btn btn-primary ModalSubmitBtn">
					登录</button>
			</div>
		</div>
	</div>
</div>
<!-- 登录结束 -->
<!-- 注册模态框 -->
<div class="modal fade modalControl" id="registModal" tabindex="-1"
	role="dialog" aria-labelledby="registModalLabel">
	<div class="modal-dialog" role="document"
		style="max-width:600px;min-width: 400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="registModalLabel">用户注册</h4>
			</div>
			<div class="modal-body">
				<form action="${ctx }/userServlet?method=regist" id="registForm"
					class="form-horizontal">
					<div class="form-group">
						<label for="userId" class="col-lg-3 control-label">
							用户名<sup>*</sup>
						</label>
						<div class="col-lg-7">
							<input type="text" class="form-control" name="userId"
								placeholder="请输入5-30位长度的用户Id" autocomplete="off"
								autofocus="autofocus">
						</div>
					</div>
					<div class="form-group">
						<label for="userPassword" class="col-lg-3 control-label">
							密码<sup>*</sup>
						</label>
						<div class="col-lg-7">
							<input type="password" class="form-control" name="userPassword"
								placeholder="请输入不少于3位的密码">
						</div>
					</div>
					<div class="form-group">
						<label for="confirmPassword" class="col-lg-3 control-label">再输入密码</label>
						<div class="col-lg-7">
							<input type="password" class="form-control"
								name="confirmPassword" placeholder="请再输入一次密码" />
						</div>
						<div class="col-lg-2">
							<button type="button" class="btn btn-link showMoreBtn"
								data-toggle="#baseInfo">更多信息</button>
						</div>
					</div>
					<div id="baseInfo" style="display: none;">
						<div class="form-group">
							<label for="userNickname" class="col-lg-3 control-label">昵称</label>
							<div class="col-lg-7">
								<input type="text" class="form-control" name="userNickname"
									placeholder="请输入你的昵称" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-3 control-label">性别</label>
							<div class="col-lg-7">
								<label class="radio-inline">
									<input type="radio" name="userSex" value="1">
									男
								</label>
								<label class="radio-inline">
									<input type="radio" name="userSex" value="-1">
									女
								</label>
								<label class="radio-inline">
									<input type="radio" name="userSex" checked="checked" value="0">
									保密
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="userBirth" class="col-lg-3 control-label">生日</label>
							<div class="col-lg-7">
								<div class="input-group date birthday" data-date=""
									data-date-format="yyyy-mm-dd" data-link-field="userBirth"
									data-link-format="yyyy-mm-dd">
									<input type="text" class=" form-control" readonly="readonly" />
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-remove"></span>
									</span>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
									<input type="hidden" id="userBirth" name="userBirth" value="" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="userPhone" class="col-lg-3 control-label">手机</label>
							<div class="col-lg-7">
								<input type="text" class="form-control" name="userPhone"
									placeholder="请输入你的手机号" />
							</div>
						</div>
						<div class="form-group">
							<label for="userMail" class="col-lg-3 control-label">邮箱</label>
							<div class="col-lg-7">
								<input type="text" class="form-control" name="userMail"
									placeholder="请输入你的邮箱" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<!-- <div class="has-error pull-left">
					<label class="control-label error-text"></label>
				</div> -->
				<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
				<button type="button" class="btn btn-primary ModalSubmitBtn">
					注册</button>
			</div>
		</div>
	</div>
</div>
<!-- 注册结束 -->
<!-- 注销模态框 -->
<div class="modal fade modalControl" id="logoutModal" tabindex="-1"
	role="dialog" aria-labelledby="logoutModalLabel">
	<div class="modal-dialog" role="document" style="width:400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="loginModalLabel">确认？</h4>
			</div>
			<div class="modal-body">
				<form action="${ctx }/userServlet?method=logout">
					<div class="form-group">
						<label class="control-label text-center">你确定要注销吗？</label>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-danger ModalSubmitBtn">确定</button>
			</div>
		</div>
	</div>
</div>
<!-- 注销结束 -->
<!-- #模态框END# -->
<script src='<c:url value="/js/header.js"></c:url>'></script>
<script>
	$('.searchBtn').click(function(e) {
		e.preventDefault();
		var productName = encodeURI($('#productName').val());
		$.pjax({
			cache : false, // 上传文件不需要缓存
			url : ctx + '/page/search.jsp',
			data : {
				"searchName" : productName,
			},
			type : 'post',
			container : '#flush'
		})
	})
</script>