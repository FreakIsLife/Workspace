/**
 * 顶部导航栏的js
 * 
 */
$(function() {
	/**
	 * 悬浮显示购物车
	 */
	$('#cart a').popover({
		trigger : 'manual',
		placement : 'bottom',
		title : '<div class="text-center"><strong>购物车</div>',
		html : 'true',
		animation : false
	}).on("mouseenter", function() {
		var _this = this;
		$(this).popover("show");
		$(this).siblings(".popover").on("mouseleave", function() {
			$(_this).popover('hide');
		});
	}).on("mouseleave", function() {
		var _this = this;
		setTimeout(function() {
			if (!$(".popover:hover").length) {
				$(_this).popover("hide")
			}
		}, 100);
	});
	/**
	 * 注册表单校验
	 */
	$(document).on('click', '#registForm', function() {
		$(this).formValidation({
			message : '输入值无效！',
			icon : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				userId : {
					message : '用户Id无效！',
					validators : {
						notEmpty : {
							message : '用户名不能为空！'
						},
						stringLength : {
							min : 5,
							max : 30,
							message : '用户名长度需要在5-30之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.]+$/,
							message : '用户名只能由字母，数字，小数点或者下划线组成！'
						},
						remote : {
							type : 'POST',
							url : ctx + '/userServlet?method=validate',
							message : '用户名已存在！',
							delay : 1000
						}
					}
				},
				userPassword : {
					message : '用户密码无效！',
					validators : {
						notEmpty : {
							message : '密码不能为空！'
						},
						stringLength : {
							min : 3,
							max : 20,
							message : '密码长度需>3,<20！'
						}
					}
				},
				confirmPassword : {
					message : '再次输入的密码无效！',
					validators : {
						notEmpty : {
							message : '请再次输入密码！',
						},
						identical : {
							field : 'userPassword',
							message : '两次输入的密码不一致！'
						}
					}
				},
				userNickname : {
					message : '用户昵称无效！',
					validators : {
						stringLength : {
							min : 1,
							max : 10,
							message : '昵称长度需要在1-10之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.\u4e00-\u9fa5]+$/,
							message : '昵称只能由中文，字母，数字，小数点或者下划线组成！'
						}
					}
				},
				userBirth : {
					message : '用户生日无效！',
					validators : {

					}
				},
				userPhone : {
					message : '用户手机无效',
					validators : {
						digits : {
							message : '手机格式不正确！'
						}
					}
				},
				userMail : {
					message : '用户邮箱无效',
					validators : {
						emailAddress : {
							message : '邮箱地址格式不正确！'
						}
					}
				}
			}
		});
	});
	/**
	 * 按钮显示隐藏信息
	 */
	$(document).on('click', '.showMoreBtn', function() {
		var $target = $($(this).attr('data-toggle'));
		var $parent = $($(this).parent().parent().parent());
		$target.toggle();
		if (!$target.is(':visible')) {
			// Enable the submit buttons in case additional fields are not valid
			$parent.data('formValidation').disableSubmitButtons(false);
		}
	});

});