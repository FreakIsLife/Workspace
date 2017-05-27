<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>购物车</title>
<ul class="breadcrumb">
	<li>
		<a href='<c:url value="/user/userCenter.jsp"></c:url>'>
			<span class="glyphicon glyphicon-home"></span>
		</a>
	</li>
	<li class="active">购物车</li>
</ul>
<div id="toolbar" class="btn-group">
	<button id="btn_delete" type="button" class="btn btn-default"
		disabled="disabled">
		<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
		删除
	</button>
</div>
<table id="tb_myCart" data-classes="table table-no-bordered table-hover"></table>
<div class="pull-right" style="margin-top:30px;font-size: 18px;">
	<label>
		已选择：
		<strong class="text-primary selectNum">0</strong>
		项
	</label>
	<label style="margin-left:50px;">
		总计：
		<strong class="text-primary">
			<span class="glyphicon glyphicon-jpy"></span>
			<em class="totalPrice">0</em>
		</strong>
	</label>
	<a href="/user/commitCart.jsp" data-target="/cartServlet"
		data-method="commitCart" id="commitCart" type="button"
		class="btn btn-info btn-lg disabled" style="margin-left:50px;">生成订单</a>
</div>
<!-- 删除模态框 -->
<div class="modal fade modalControl" id="CartDelModal" tabindex="-1"
	role="dialog" aria-labelledby="productDelModalLabel">
	<div class="modal-dialog" role="document" style="width:400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="productDelModalLabel">确认？</h4>
			</div>
			<div class="modal-body">
				<form action="${ctx }/cartServlet?method=delete">
					<div class="form-group">
						<label class="control-label text-center">你确定要删除吗？</label>
						<input type="text" hidden="hidden" name="delData" id="delData">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-danger CartSubmitBtn">确定</button>
			</div>
		</div>
	</div>
</div>
<!-- 模态框结束  -->
<script>
	$(function() {
		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();
		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();
	});
	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_myCart').bootstrapTable({
				url : ctx + '/cartServlet?method=getCart', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : "application/x-www-form-urlencoded", //post方式必须（*）
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortOrder : "asc", //排序方式
				queryParams : oTableInit.queryParams,//传递参数（*）
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 5, 10, 25, 50 ], //可供选择的每页的行数（*）
				search : false, //是否显示表格搜索，若true且为server分页则传递参数需要将search传递过去 */
				strictSearch : true,
				showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				uniqueId : "cartItem", //每一行的唯一标识，一般为主键列
				detailView : false, //是否显示父子表
				responseHandler : function(res) {//这里我查看源码的，在ajax请求成功后，发放数据之前可以对返回的数据进行处理，返回什么部分的数据，比如我的就需要进行整改的！
					return res;
				},
				columns : [ {
					checkbox : true
				}, {
					field : 'cartItem',
					title : '商品Id',
					switchable : false,
					align : 'center',
					valign : 'middle',
					visible : false
				}, {
					field : 'cartImg',
					title : '商品图片',
					align : 'center',
					formatter : function(value, row, index) {
						var tmp = value.split('.');
						tmp[tmp.length - 1] = '_small.' + tmp[tmp.length - 1];
						var smpic = tmp.join('');
						return '<img src='+smpic+' class="img-rounded" >';
					}
				}, {
					field : 'cartName',
					title : '商品名称',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'cartPrice',
					title : '单价',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'cartNum',
					title : '数量',
					align : 'center',
					valign : 'middle',
					events : NumEvents,
					formatter : NumFormatter
				}, {
					field : 'singleTotalPrice',
					title : '价格',
					width : '10%',
					align : 'center',
					valign : 'middle',
					formatter : function(value, row, index) {
						value = row.cartPrice * row.cartNum
						return value;
					}
				}, {
					field : 'operate',
					title : '操作',
					align : 'center',
					valign : 'middle',
					events : operateEvents,
					formatter : operateFormatter
				} ],
				onAll : function() {
					$(".bs-checkbox").css({
						'text-align' : 'center',
						'vertical-align' : 'middle'
					});
				}
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset
			//页码
			};
			return temp;
		};
		function operateFormatter(value, row, index) {
			return [ '<a class="remove" href="javascript:void(0)" title="删除">',
					'<i class="glyphicon glyphicon-remove"></i>', '</a>' ]
					.join('');
		}
		;
		function NumFormatter(value, row, index) {
			return [
					'<a class="plus" href="javascript:void(0)" title="增加">',
					'<i class="glyphicon glyphicon-plus"></i></a>',
					'<input class="write" type="text" style="width:40px;text-align:center;" value="' + value + '"/>',
					'<a class="minus" href="javascript:void(0)" title="减少">',
					'<i class="glyphicon glyphicon-minus"></i></a>' ].join('');
		}
		;
		window.operateEvents = {
			'click .remove' : function(e, value, row, index) {
				$('#delData').val(row.cartItem + '-' + row.cartNum);
				$('#CartDelModal').modal();
			}
		};
		window.NumEvents = {
			'click .plus' : function(e, value, row, index) {
				if (changeNum(1, row.cartItem)) {
					$(this).next().val(parseInt($(this).next().val()) + 1);
					var num = parseInt(value) + 1;
					$('#tb_myCart').bootstrapTable('updateCell', {
						"index" : index,
						"field" : "cartNum",
						"value" : num
					});
				}
			},
			'click .minus' : function(e, value, row, index) {
				if (parseInt(value) > 1 && changeNum(-1, row.cartItem)) {
					$(this).prev().val($(this).prev().val() - 1);
					$()
					var num = value - 1;
					$('#tb_myCart').bootstrapTable('updateCell', {
						"index" : index,
						"field" : "cartNum",
						"value" : num
					});
				}
			},
			'blur .write' : function(e, value, row, index) {
				if (isNaN($(this).val()) || parseInt($(this).val()) < 0
						|| !changeNum($(this).val() - value, row.cartItem)) {
					$(this).val(value);
				} else {
					var num = parseInt($(this).val());
					$('#tb_myCart').bootstrapTable('updateCell', {
						"index" : index,
						"field" : "cartNum",
						"value" : num
					});
				}
			},
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};

		oInit.Init = function() {
			//初始化页面上面的按钮事件
			$('#btn_delete').click(function() {
				$('#delData').val(getDelSelections());
				$('#CartDelModal').modal();
			});
		};
		return oInit;
	};
	function getDelSelections() {
		return $.map($('#tb_myCart').bootstrapTable('getSelections'), function(
				row) {
			return row.cartItem + '-' + row.cartNum;
		});
	};
	function getItemSelections() {
		return $.map($('#tb_myCart').bootstrapTable('getSelections'), function(
				row) {
			return row.cartItem;
		});
	};
	function getPriceSelections() {
		return $.map($('#tb_myCart').bootstrapTable('getSelections'), function(
				row) {
			return row.cartPrice * row.cartNum;
		});
	};
	function getPriceSelections() {
		return $.map($('#tb_myCart').bootstrapTable('getSelections'), function(
				row) {
			return row.cartPrice * row.cartNum;
		});
	};
	function changeNum(value, id) {
		var result = true;
		$.ajax({
			url : ctx + '/cartServlet',
			data : {
				"productId" : id,
				"changeNum" : value,
				"method" : "changeNum"
			},
			type : 'post',
			dataType : 'text',
			success : function(msg) {
				if (msg.length > 0) {
					toastr.error(msg);
					return false;
				}
			},
			error : function() {
				toastr.error("连接超时失败，请稍后再试！");
			}
		})
		return result;
	};
	$('.CartSubmitBtn').on('click', function() {
		var $_modal = $($(this).parents('.modal'));
		var $submitForm = $($(this).parent().prev().find('form'));
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
					toastr.success("操作成功！");
					$_modal.modal('hide');
					$('#tb_myCart').bootstrapTable('refresh');
				}
			},
			error : function() {
				toastr.error("连接超时失败，请稍后再试！");
			}
		})
	});
	$('#tb_myCart')
			.on(
					'check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table',
					function() {
						var length = $('#tb_myCart').bootstrapTable(
								'getSelections').length;
						$('#btn_delete').prop('disabled', !length);
						if (length) {
							$('#commitCart').removeClass('disabled');
						} else {
							$('#commitCart').addClass('disabled');
						}
					});
	$('#tb_myCart').on('all.bs.table', function() {
		var length = $('#tb_myCart').bootstrapTable('getSelections').length;
		$('.selectNum').text(length);
		var selectPrice = getPriceSelections();
		var single = selectPrice.toString().split(",");
		var total = 0.00;

		for (var i = 0; i < length; i++) {
			total += parseFloat(single[i]);
		}
		total.toFixed(2);
		$('.totalPrice').text(total)
	});
	$('#tb_myCart').on('refresh.bs.table', function() {
		$('#btn_delete').prop('disabled', true);
		$('#commitCart').addClass('disabled');
	});
	$('#commitCart').click(
			function(e) {
				e.preventDefault();
				var item = JSON.stringify($('#tb_myCart').bootstrapTable(
						'getSelections'));
				var itemId = JSON.stringify(getItemSelections());
				var total = $('.totalPrice').text();
				var url = $(this).attr('href');
				var target = $(this).data('target');
				var method = $(this).data('method');
				$.pjax({
					url : ctx + target,
					data : {
						"method" : method,
						"url" : url,
						"item" : item,
						"itemId" : itemId,
						"total" : total
					},
					type : 'post',
					container : "#flush"
				})
			});
</script>