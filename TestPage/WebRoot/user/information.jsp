<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<title>个人信息</title>
<form action="${ctx }/userServlet?method=saveInfo"
	class="form-horizontal" id="informationForm">
	<fieldset>
		<legend>个人信息表</legend>
		<div class="form-group">
			<label for="userImg" class="col-lg-2 control-label"
				style="margin-top:40px;">头像</label>
			<!-- File Upload -->
			<div class="col-lg-2 form-file">
				<input id="fileInput" type="file" name="userImg"
					value="${loginUser.userImg }" />
				<img alt="头像"
					src="${loginUser.userImg == null ?'/images/no-headImg.jpg':loginUser.userImg}"
					class="img-circle" style="width:100px;height:100px;">
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="userId" class="col-lg-2 control-label">用户名</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入用户名" id="userId"
						name="userId" type="text" readonly="readonly"
						value="${loginUser.userId }">
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="userNickname" class="col-lg-2 control-label">昵称</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入昵称" id="userNickname"
						name="userNickname" type="text" value="${loginUser.userNickname }">
				</div>
				<p class="help-block">昵称不得超过10个字符</p>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="userName" class="col-lg-2 control-label">姓名</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入姓名" id="userName"
						name="userName" type="text" value="${loginUser.userName }">
				</div>
				<p class="help-block">姓名不得超过10个字符</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-lg-2 control-label">性别</label>
			<div class="col-lg-7">
				<!-- Inline Radios -->
				<label class="radio-inline">
					<input type="radio" value="1" name="userSex"
						${loginUser.userSex eq 1 ? 'checked="checked"':''} />
					男
				</label>
				<label class="radio-inline">
					<input type="radio" value="-1" name="userSex"
						${loginUser.userSex eq -1 ? 'checked="checked"':''} />
					女
				</label>
				<label class="radio-inline">
					<input type="radio" value="0" name="userSex"
						${loginUser.userSex eq 0 ? 'checked="checked"':''} />
					保密
				</label>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="userBirth" class="col-lg-2 control-label">生日</label>
			<div class="col-lg-7">
				<div class="input-group date birthday" data-date=""
					data-date-format="yyyy-mm-dd" data-link-field="userBirth"
					data-link-format="yyyy-mm-dd">
					<span class="input-group-addon">^_^</span>
					<input type="text" class="form-control" placeholder="请选择你的生日"
						readonly="readonly"
						value='<fmt:formatDate value="${loginUser.userBirth }" type="both" pattern="yyyy-mm-dd"/>'>

					<span class="input-group-addon">
						<span class="glyphicon glyphicon-remove"></span>
					</span>
					<span class="input-group-addon">
						<span class="glyphicon glyphicon-calendar"></span>
					</span>
					<input type="hidden" id="userBirth" name="userBirth"
						value='<fmt:formatDate value="${loginUser.userBirth }" type="both" pattern="yyyy-mm-dd"/>' />

				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- Prepended text-->
			<label for="userPhone" class="col-lg-2 control-label">手机</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入手机号" id="userPhone"
						name="userPhone" type="text" value="${loginUser.userPhone }">
				</div>
			</div>
		</div>

		<div class="form-group">
			<!-- Prepended text-->
			<label for="userMail" class="col-lg-2 control-label">邮箱</label>
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">^_^</span>
					<input class="form-control" placeholder="请输入邮箱" id="userMail"
						name="userMail" type="text" value="${loginUser.userMail }">
				</div>
				<p class="help-block"></p>
			</div>
		</div>
		<div class="form-group">
			<!-- Button -->
			<div class="col-lg-4 col-lg-offset-4">
				<button class="btn btn-info usualSubmitBtn">保存修改</button>
			</div>
		</div>
	</fieldset>
</form>