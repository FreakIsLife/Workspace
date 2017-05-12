<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<title>个人资料</title>

<link
	href="${pageContext.request.contextPath }/AmazeUI-2.4.2/assets/css/admin.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/AmazeUI-2.4.2/assets/css/amazeui.css"
	rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath }/css/personal.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/infstyle.css"
	rel="stylesheet" type="text/css">
<script
	src="${pageContext.request.contextPath }/AmazeUI-2.4.2/assets/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/AmazeUI-2.4.2/assets/js/amazeui.js"></script>
<div class="center">
	<div class="col-main">
		<div class="main-wrap">
			<div class="user-info">
				<!--标题 -->
				<div class="am-cf am-padding">
					<div class="am-fl am-cf">
						<strong class="am-text-danger am-text-lg">个人资料</strong> / <small>Personal&nbsp;information</small>
					</div>
				</div>
				<hr />

				<!--头像 -->
				<div class="user-infoPic">

					<div class="filePic">
						<input type="file" class="inputPic"
							allowexts="gif,jpeg,jpg,png,bmp" accept="image/*">
						<img class="am-circle am-img-thumbnail"
							src="${pageContext.request.contextPath }/images/getAvatar.do.jpg"
							alt="" />
					</div>

					<p class="am-form-help">头像</p>

					<div class="info-m">
						<div>
							<b>用户名：<i>${loginUser.userId }</i></b>
						</div>
						<div class="vip">
							<span></span>
							<a href="#">会员专享</a>
						</div>
					</div>
				</div>

				<!--个人信息 -->
				<div class="info-main">
					<form action="#" method="post" class="am-form am-form-horizontal"
						id="doc-vld-msg">

						<div class="am-form-group">
							<label for="user-name" class="am-form-label">昵称</label>
							<div class="am-form-content">
								<input type="text" id="user-name" minlength="3" maxlength="12"
									name="userNickname" value="${loginUser.userNickname }"
									placeholder="nickname" required>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-name2" class="am-form-label">姓名</label>
							<div class="am-form-content">
								<input type="text" id="user-name2" name="userName"
									value="${loginUser.userName }" placeholder="name">

							</div>
						</div>

						<div class="am-form-group">
							<label class="am-form-label">性别</label>
							<div class="am-form-content sex">
								<label class="am-radio-inline">
									<input type="radio" name="userSex" value="male" checked data-am-ucheck>
									男
								</label>
								<label class="am-radio-inline">
									<input type="radio" name="userSex" value="female"
										data-am-ucheck>
									女
								</label>
								<label class="am-radio-inline">
									<input type="radio" name="userSex" value="secret"
										data-am-ucheck>
									保密
								</label>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-birth" class="am-form-label">生日</label>
							<div class="am-form-content birth">
								<div class="am-input-group am-datepicker-date"
									data-am-datepicker="{format: 'yyyy-mm-dd'}">
									<input type="text" class="am-form-field" placeholder="日历组件"
										readonly>
									<span class="am-input-group-btn am-datepicker-add-on">
										<button class="am-btn am-btn-default" type="button">
											<span class="am-icon-calendar"></span>
										</button>
									</span>
								</div>
							</div>

						</div>
						<div class="am-form-group">
							<label for="user-phone" class="am-form-label">电话</label>
							<div class="am-form-content">
								<input id="user-phone" placeholder="telephonenumber" type="tel">

							</div>
						</div>
						<div class="am-form-group">
							<label for="user-email" class="am-form-label">电子邮件</label>
							<div class="am-form-content">
								<input id="user-email" placeholder="Email" type="email"
									data-validation-message="邮箱格式不正确">

							</div>
						</div>
						<div class="info-btn">
							<div class="am-btn am-btn-danger">保存修改</div>
						</div>
					</form>
					<script>
						$(function() {
							$('.info-btn div').on('click', function() {
								$('#doc-vld-msg').submit();
							});
							$('#doc-vld-msg')
									.validator(
											{
												onValid : function(validity) {
													$(validity.field).closest(
															'.am-form-group')
															.find('.am-alert')
															.hide();
												},

												onInValid : function(validity) {
													var $field = $(validity.field);
													var $group = $field
															.closest('.am-form-group');
													var $alert = $group
															.find('.am-alert');
													// 使用自定义的提示信息 或 插件内置的提示信息
													var msg = $field
															.data('validationMessage')
															|| this
																	.getValidationMessage(validity);

													if (!$alert.length) {
														$alert = $(
																'<div class="am-alert am-alert-danger" style="font-size:10px;text-align:center;"></div>')
																.hide()
																.appendTo(
																		$group);
													}

													$alert.html(msg).show();
												}
											});
						});
					</script>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="aside.jsp"></jsp:include>
</div>
