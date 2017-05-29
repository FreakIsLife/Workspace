<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.wxb.com/Decoder" prefix="DeCorder"%>
<title>查询结果</title>
<div class="panel-body" style="padding-bottom:0px;">
	<div class="panel panel-default">
		<div class="panel-heading">查询条件</div>
		<div class="panel-body">
			<form id="formSearch" class="form-horizontal">
				<div class="form-group" style="margin-top:15px">
					<label class="control-label col-md-2" for="txt_search_productName">商品名称</label>
					<div class="col-md-3">
						<input type="text" class="form-control"
							id="txt_search_productName"
							value="${DeCorder:decode(param.searchName) }">
					</div>
					<div class="col-md-2" style="text-align:left;">
						<button type="button" style="margin-left:50px" id="btn_query"
							class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<table id="tb_products"
		data-classes="table table-no-bordered table-hover"></table>
</div>
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
			$('#tb_products').bootstrapTable({
				url : ctx + '/productServlet?method=getSearchProduct', //请求后台的URL（*）
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
				showColumns : true, //是否显示所有的列
				minimumCountColumns : 2, //最少允许的列数
				uniqueId : "productId", //每一行的唯一标识，一般为主键列
				showToggle : true, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				responseHandler : function(res) {//这里我查看源码的，在ajax请求成功后，发放数据之前可以对返回的数据进行处理，返回什么部分的数据，比如我的就需要进行整改的！
					return res;
				},
				columns : [ {
					field : 'productId',
					title : '商品Id',
					switchable : false,
					valign : 'middle',
					visible : false
				}, {
					field : 'productImg',
					title : '商品图片',
					align : 'center',
					formatter : function(value, row, index) {
						var tmp = value.split('.');
						tmp[tmp.length - 1] = '_small.' + tmp[tmp.length - 1];
						var smpic = tmp.join('');
						return '<img src='+smpic+' class="img-rounded" >';
					}
				}, {
					field : 'productName',
					title : '名称',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'productLeft',
					title : '库存',
					sortable : true,
					align : 'center',
					valign : 'middle'
				}, {
					field : 'productPrice',
					title : '单价',
					sortable : true,
					align : 'center',
					valign : 'middle'
				}, {
					field : 'productSale',
					title : '销量',
					sortable : true,
					align : 'center',
					valign : 'middle'
				}, {
					field : 'operate',
					title : '操作',
					align : 'center',
					valign : 'middle',
					events : operateEvents,
					formatter : operateFormatter
				} ],
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				order : params.order,
				ordername : params.sort,
				productName : $("#txt_search_productName").val()
			};
			return temp;
		};
		function operateFormatter(value, row, index) {
			return [
					'<a class="add" href="javascript:void(0)" title="加入购物车">',
					'<i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>',
					'</a>' ].join('');
		}
		;
		window.operateEvents = {
			'click .add' : function(e, value, row, index) {
				e.preventDefault();
				if (${empty loginUser?true:false}) {
					$('#loginModal').modal();
				} else {
					var productId = row.productId;
					var num = 1;
					$.ajax({
						cache : false, // 上传文件不需要缓存
						url : ctx + '/cartServlet?method=add',
						data : {
							"productId" : productId,
							"number" : num
						},
						type : 'post',
						dataType : 'text',
						success : function(dates) {
							toastr.success("成功加入购物车！");
						},
						error : function() {
							toastr.error("连接超时失败，请稍后再试！");
						}
					})
				}
			}
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};

		oInit.Init = function() {
			//初始化页面上面的按钮事件
			$('#btn_query').click(function() {
				$('#tb_products').bootstrapTable('refresh');
			});
		};

		return oInit;
	};
</script>