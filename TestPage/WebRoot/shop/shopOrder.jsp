<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>我的订单</title>
<ul class="breadcrumb">
	<li>
		<a href='<c:url value="/user/userCenter.jsp"></c:url>'>
			<span class="glyphicon glyphicon-home"></span>
		</a>
	</li>
	<li class="active">我的订单</li>
</ul>

<nav id="toolbar" class="navbar navbar-default" role="navigation">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#bs-navbar-collapse-order">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">订单表</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-navbar-collapse-order">
		<ul class="nav navbar-nav" id="statusSelect">
			<li class="active" data-toggle="tab">
				<a href="#" data-status="all">全部订单</a>
			</li>
			<li data-toggle="tab">
				<a href="#" data-status="pay">待付款</a>
			</li>
			<li data-toggle="tab">
				<a href="#" data-status="send">待发货</a>
			</li>
			<li data-toggle="tab">
				<a href="#" data-status="certain">待确认</a>
			</li>
			<li data-toggle="tab">
				<a href="#" data-status="success">交易成功</a>
			</li>
			<li data-toggle="tab">
				<a href="#" data-status="cancel">已取消</a>
			</li>
		</ul>
		<form class="navbar-form navbar-right" role="search">
			<div class="form-group">
				<input type="text" class="form-control" id="text_search" />
			</div>
			<button class="btn btn-default" id="btn_query">查询订单</button>
		</form>
	</div>
</nav>
<table id="tb_myOrder"
	data-classes="table table-condensed table-no-bordered table-hover"></table>
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
			$('#tb_myOrder')
					.bootstrapTable(
							{
								url : ctx + '/orderServlet?method=getShopOrder',
								method : 'post',
								contentType : "application/x-www-form-urlencoded", //post方式必须（*）
								toolbar : '#toolbar',
								striped : true,
								cache : false,
								striped : true,
								pagination : true,
								sortOrder : "asc", //排序方式
								uniqueId : "orderId", //每一行的唯一标识，一般为主键列
								queryParams : oTableInit.queryParams,
								queryParamsType : "limit",
								detailView : true,//父子表
								sidePagination : "server",
								pageNumber : 1, //初始化加载第一页，默认第一页
								pageSize : 5, //每页的记录行数（*）
								pageList : [ 5, 10, 25, 50 ],
								minimumCountColumns : 2,
								clickToSelect : true,
								//注册加载子表的事件。注意下这里的三个参数！
								onExpandRow : function(index, row, $detail) {
									oTableInit
											.InitSubTable(index, row, $detail);
								},
								rowStyle : function(row, index) {
									//这里有5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
									var strclass = "";
									if (row.orderStatus == "1") {//待付款
										strclass = 'info';
									} else if (row.orderStatus == "2") {//待发货
										strclass = 'active';
									} else if (row.orderStatus == "3") {//待确认
										strclass = 'warning';
									} else if (row.orderStatus == "4") {//交易成功
										strclass = 'success';
									} else if (row.orderStatus == "5") {//已取消
										strclass = 'danger';
									} else {
										return {};
									}
									return {
										classes : strclass
									}
								},
								columns : [
										{
											field : 'orderId',
											title : '订单号',
											width : '10%',
											align : 'center',
											valign : 'middle',
											formatter : function(value, row,
													index) {
												var strAddress = '<lable class="cut" title="' + value + '">'
														+ value + '</lable>'
												return strAddress;
											}
										},
										{
											field : 'orderTime',
											title : '下单时间',
											align : 'center',
											valign : 'middle'
										},
										{
											field : 'orderAddress',
											title : '下单地址',
											width : '30%',
											align : 'center',
											valign : 'middle',
											formatter : function(value, row,
													index) {
												var strAddress = '<lable class="cut" style="width:200px;" title="' + value + '">'
														+ value + '</lable>'
												return strAddress;
											}
										},
										{
											field : 'orderTotal',
											title : '总价',
											align : 'center',
											valign : 'middle',
											formatter : function(value, row,
													index) {
												return [
														'<em>' + value
																+ '</em>',
														'<span class="glyphicon glyphicon-jpy"></span>' ]
														.join('');
											}
										}, {
											field : 'orderStatus',
											title : '状态',
											align : 'center',
											valign : 'middle',
											formatter : StatusFormatter
										}, {
											field : 'operator',
											title : '操作',
											align : 'center',
											valign : 'middle',
											events : operatorEvents,
											formatter : operatorFormatter
										} ],
								onAll : function() {
									$(".detail-icon").parent().css({
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
				offset : params.offset, //页码
				order : params.order,
				ordername : params.sort,
				orderId : $("#text_search").val(),
				statusSelect : $("#statusSelect").find('.active a').data(
						'status')
			};
			return temp;
		};
		function StatusFormatter(value, row, index) {
			var strStatus = "";
			if (value == "1") {//待付款
				strStatus = '待付款';
			} else if (value == "2") {//待发货
				strStatus = '待发货';
			} else if (value == "3") {//待确认
				strStatus = '待确认';
			} else if (value == "4") {//交易成功
				strStatus = '交易成功';
			} else if (value == "5") {//已取消
				strStatus = '已取消';
			}
			return '<lable class="text-muted">' + strStatus + '</lable>';
		}
		;
		function operatorFormatter(value, row, index) {
			var cancel = "";
			if(row.orderStatus == "4"){
				cancel = '<lable class="text-success"><a class="cancel" href="javascript:void(0)" title="售后评价">售后评价</a></lable>';
			} else if (row.orderStatus != "5") {
				cancel = '<lable class="text-danger"><a class="cancel" href="javascript:void(0)" title="取消订单">取消订单</a></lable>';
			}
			var btnStatus = "";
			if (row.orderStatus == "2") {
				btnStatus = '<button class="btn btn-default send">立即发货</button>';
			}
			return [ cancel, '<br/>', btnStatus ].join('');
		}
		;
		window.operatorEvents = {
			'click .send' : function(e, value, row, index) {
				var orderId = row.orderId;
				var orderStatus = "certain";
				$.ajax({
					cache : false, // 上传文件不需要缓存
					url : ctx + '/orderServlet?method=updateStatus',
					data : {
						"orderId" : orderId,
						"status" : orderStatus
					},
					type : 'post',
					dataType : 'text',
					success : function(msg) {
						if (msg.length > 0) {
							toastr.error(msg);
						} else {
							toastr.success("成功发货！");
							$('#tb_myOrder').bootstrapTable('refresh');
						}
					},
					error : function() {
						toastr.error("连接超时失败，请稍后再试！");
					}
				});
			},
			'click .cancel' : function(e, value, row, index) {
				var orderId = row.orderId;
				var orderStatus = "cancel";
				$.ajax({
					cache : false, // 上传文件不需要缓存
					url : ctx + '/orderServlet?method=updateStatus',
					data : {
						"orderId" : orderId,
						"status" : orderStatus
					},
					type : 'post',
					dataType : 'text',
					success : function(msg) {
						if (msg.length > 0) {
							toastr.error(msg);
						} else {
							toastr.success("成功取消！");
							$('#tb_myOrder').bootstrapTable('refresh');
						}
					},
					error : function() {
						toastr.error("连接超时失败，请稍后再试！");
					}
				});
			}
		};

		//初始化子表格(无线循环)
		oTableInit.InitSubTable = function(index, row, $detail) {
			var parentid = row.orderId;
			var cur_table = $detail.html(
					'<table data-classes="table table-condensed table-no-bordered"></table>')
					.find('table');
			$(cur_table).bootstrapTable({
				url : ctx + '/orderServlet?method=getOrderItem',
				method : 'post',
				contentType : "application/x-www-form-urlencoded", //post方式必须（*）
				striped : true,
				cache : false,
				sortable : false,
				queryParams : {
					orderId : parentid
				},
				ajaxOptions : {
					orderId : parentid
				},
				/* sidePagination : "server",
				pageSize : 5,
				pageList : [ 10, 25, 50, 100 ], */
				columns : [ {
					field : 'itemImg',
					title : '商品图片',
					align : 'center',
					formatter : function(value, row, index) {
						var tmp = value.split('.');
						tmp[tmp.length - 1] = '_small.' + tmp[tmp.length - 1];
						var smpic = tmp.join('');
						return '<img src='+smpic+' class="img-rounded" >';
					}
				}, {
					field : 'itemName',
					title : '名称',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'itemPrice',
					title : '单价',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'itemNum',
					title : '数量',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'itemTotal',
					title : '总计',
					width : '10%',
					align : 'center',
					valign : 'middle'
				}, ],
			});
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var strrole_id = "";
		var postdata = {};
		//var arrsubmenutable = [];
		var arrmenuid = [];

		oInit.Init = function() {
			//条件查询click事件注册
			$("#btn_query").click(function(e) {
				e.preventDefault();
				$("#tb_myOrder").bootstrapTable('refresh');
			});
			$("#statusSelect a").click(function(e) {
				e.preventDefault();
				setTimeout(function() {
					$("#tb_myOrder").bootstrapTable('refresh');
				}, 100);
			});
		};
		return oInit;
	};

	$(document).ready(function() {
		/* var width = $('#toolbar').parent().parent().width();
		$('#toolbar').width(width); */
		$('#toolbar').parent().removeClass('pull-left');
	});
</script>
