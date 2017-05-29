/**
 * 存放Web项目通用js
 */
$(function() {
	/**
	 * toastr 参数设置
	 */

	toastr.options = {
		closeButton : false, // 是否显示关闭按钮(提示框右上角关闭按钮)
		debug : false, // 是否为调试
		progressBar : true, // 是否显示进度条(设置关闭的超时时间进度条)
		/*
		 * 消息框在页面显示的位置 toast-top-left 顶端左边 toast-top-right 顶端右边 toast-top-center
		 * 顶端中间 toast-top-full-width 顶端，宽度铺满整个屏幕 toast-botton-right
		 * toast-bottom-left toast-bottom-center toast-bottom-full-width
		 */
		positionClass : "toast-top-center",
		onclick : null, // 点击消息框自定义事件
		showDuration : "300", // 显示动作时间
		hideDuration : "1000", // 隐藏动作时间
		timeOut : "2000", // 自动关闭超时时间
		extendedTimeOut : "1000",
		showEasing : "swing",
		hideEasing : "linear",
		showMethod : "fadeIn", // 显示的方式，和jquery相同
		hideMethod : "fadeOut" // 隐藏的方式，和jquery相同
	};
	/**
	 * 校验用的jQuery语句
	 */
	/**
	 * 个人信息校验
	 */
	$(document).on('click', '#informationForm', function() {
		$(this).off('click');
		$(this).formValidation({
			message : '输入值无效！',
			icon : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
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
				userName : {
					message : '用户姓名无效！',
					validators : {
						stringLength : {
							min : 0,
							max : 10,
							message : '姓名长度需要在0-10之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.\u4e00-\u9fa5]+$/,
							message : '姓名只能由中文，字母，数字，小数点或者下划线组成！'
						}
					}
				},
				userBirth : {
					message : '用户生日无效！',
					validators : {
						date : {
							message : '您输入的生日格式无效！'
						}
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
	 * 个人信息校验
	 */
	$(document).on('click', '#setShopForm', function() {
		$(this).off('click');
		$(this).formValidation({
			message : '输入值无效！',
			icon : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				shopName : {
					message : '店铺名无效！',
					validators : {
						stringLength : {
							min : 1,
							max : 10,
							message : '店铺名长度需要在1-10之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.\u4e00-\u9fa5]+$/,
							message : '店铺名只能由中文，字母，数字，小数点或者下划线组成！'
						}
					}
				},
				shopQQ : {
					message : '联系QQ无效！',
					validators : {
						digits : {
							message : 'QQ只能是数字！'
						}
					}
				}
			}
		});
	});
	/**
	 * ajax刷新div
	 */
	/*
	 * $(document).on('click', '.flushPage', function(event) {
	 * event.preventDefault(); var url = $(this).attr('href'); var data = { type :
	 * 1 }; $.ajax({ type : "get", async : true, // 异步请求 url : url, data : data,
	 * timeout : 1000, success : function(dates) {
	 * window.history.pushState(null, null, url); // 改变URL和添加返回历史 document.title =
	 * data.title; // 设置标题 $(".flush").html(dates);// 要刷新的div }, error :
	 * function() { toastr.error("连接超时失败，请稍后再试！"); } }); });
	 */
	/**
	 * pjax 可回退页面
	 */
	$(document).pjax('.flushPage', '#flush');
	$(window).on('popstate', function() {
		$.pjax.reload('#flush');
	});
	function PjaxreLoad(loadPage) {
		$.pjax.reload('#' + loadPage);
	}
	/**
	 * 恢复一些被bootstrap 禁用的a标签
	 */
	$('.recoverA a').click(function() {
		location.href = $(this).attr('href');
	});
	/**
	 * 日期控件 与document绑定防止局部刷新失效
	 */
	$(document).on('mouseenter', '.birthday', function() {
		$(this).off('mouseenter');
		$(this).datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 1,
			initialDate : new Date(),
			endDate : new Date(),
			pickerPosition : 'bottom-left'
		}).on('hide', '.birthday', function(event) {
			event.preventDefault();
			event.stopPropagation();
		});
	});
	/**
	 * 文件上传 绑定document防止失效
	 */
	$(document)
			.on(
					'mouseenter',
					'.form-file',
					function() {
						$(this).off('mouseenter');
						var $this = $(this), btn = $this.find('#fileInput'), img = $this
								.find('img');
						btn.off('change');
						btn
								.on(
										'change',
										function() {
											var file = $(this)[0].files[0], imgSrc = $(this)[0].value, url = URL
													.createObjectURL(file);
											if (!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/
													.test(imgSrc)) {
												toastr
														.error("请上传jpg或png格式的图片！");
												return false;
											} else {
												img.attr('src', url);

											}
										});
					});
	/**
	 * Modal的ajax提交
	 */
	$(document).on('click', '.ModalSubmitBtn', function() {
		/* var $submitError = $($(this).parent().find('.error-text')); */
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
					/* $submitError.text(msg); */
					toastr.error(msg);
				} else {
					location.href = ctx + '/page/home.jsp';
				}
			},
			error : function() {
				toastr.error("连接超时失败，请稍后再试！");
			}
		})
	});
	/**
	 * usual的ajax提交
	 */
	$(document).on('click', '.usualSubmitBtn', function(e) {
		e.preventDefault();
		toastr.info("保存数据中...");
		var $submitForm = $($(this).parents('form'));
		var Form = $submitForm[0];
		var submitUrl = $submitForm.attr('action');
		var submitMsg = new FormData(Form);
		$.ajax({
			cache : false, // 上传文件不需要缓存
			url : submitUrl,
			data : submitMsg,
			type : 'post',
			dataType : 'text',
			processData : false, // data值是FormData对象，不需要对数据做处理
			contentType : false,
			success : function(msg) {
				if (msg.length > 0) {
					toastr.error(msg);
				} else {
					toastr.success("保存成功！");
					// 重新加载 还在当前页面,ajax重新局部刷新？？待解决
					setTimeout(function() {
						clearTimeout();
						$.pjax.reload('#flush');
					}, 2000);
					/* history.go(-1); */
				}
			},
			error : function() {
				toastr.error("连接超时失败，请稍后再试！");
			}
		})
	});
	/**
	 * 当模态框退出时，清空内部表单
	 */
	$(document).on('hide.bs.modal', '.modalControl', function() {
		/* $('.modalControl').on('hide.bs.modal', function() { */
		$(this).find("form").formValidation('resetForm', true);
	});
});
/**
 * 导航栏选择
 */
function chooseNav(choose) {
	$('#' + choose).parents('ul:first').prev().click();
	$('#' + choose).click();
}