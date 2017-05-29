<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<title>修改密码</title>
<form action="${ctx }/userServlet?method=changePwd"
	class="form-horizontal" id="passWordForm">
	<fieldset>
		<legend>修改密码</legend>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="oldPassword" class="col-lg-2 control-label">原始密码</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入旧密码" id="oldPassword"
						name="oldPassword" type="password">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="newPassword" class="col-lg-2 control-label">新密码</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入新密码" id="newPassword"
						name="newPassword" type="password">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="rnewPassword" class="col-lg-2 control-label">再输入一次密码</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请再输入密码" id="rnewPassword"
						name="rnewPassword" type="password">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Button -->
			<div class="col-lg-4 col-lg-offset-4">
				<button class="btn btn-info usualSubmitBtn">确认修改</button>
			</div>
		</div>
	</fieldset>
</form>