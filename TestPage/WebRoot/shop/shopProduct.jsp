<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>上架商品</title>
<div class="panel-body" style="padding-bottom:0px;">
	<div class="panel panel-default">
		<div class="panel-heading">查询条件</div>
		<div class="panel-body">
			<form id="formSearch" class="form-horizontal">
				<div class="form-group" style="margin-top:15px">
					<label class="control-label col-md-2" for="txt_search_productName">商品名称</label>
					<div class="col-md-3">
						<input type="text" class="form-control"
							id="txt_search_productName">
					</div>
					<div class="col-md-2" style="text-align:left;">
						<button type="button" style="margin-left:50px" id="btn_query"
							class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="toolbar" class="btn-group">
		<button id="btn_add" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
			新增
		</button>
		<!-- <button id="btn_edit" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
			修改
		</button> -->
		<button id="btn_delete" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			删除
		</button>
	</div>
	<table id="tb_products" data-classes="table table-no-bordered"></table>

	<!-- 商品模态框 -->
	<div class="modal fade modalControl" id="productModal" tabindex="-1"
		role="dialog" aria-labelledby="productAddModalLabel">
		<div class="modal-dialog" role="document" style="width:700px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="productAddModalLabel">商品信息</h4>
				</div>
				<div class="modal-body">
					<form action="${ctx }/productServlet?method=add"
						class="form-horizontal">
						<div class="form-group col-md-4">
							<div class="form-file" style="width:100%;height:150px;float:left">
								<input id="fileInput" type="file" name="productImg"
									value="${product.prductImg }" style="width:100%;height:100%;" />
								<img alt="头像"
									src="${product.userImg == null ?'/images/no-headImg.jpg':product.productImg}"
									class="img-rounded" style="width:100%;height:100%;">
							</div>
						</div>
						<div class="form-group" hidden="hidden">
							<input type="text" class="form-control" id="productId"
								name="productId">
							<input type="text" class="form-control" id="productSale"
								name="productSale">
						</div>
						<div class="form-group col-md-8">
							<label for="productName" class="col-md-4 control-label">商品名称：</label>
							<div class="col-md-8">
								<input type="text" class="form-control" id="productName"
									name="productName">
							</div>
						</div>
						<div class="form-group col-md-8">
							<label for="productLeft" class="col-md-4 control-label">库存：</label>
							<div class="col-md-8">
								<input type="text" class="form-control" id="productLeft"
									name="productLeft">
							</div>
						</div>
						<div class="form-group col-md-8">
							<label for="productPrice" class="col-md-4 control-label">价格：</label>
							<div class="col-md-8">
								<input type="text" class="form-control" id="productPrice"
									name="productPrice">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer" style="clear: both;">
					<!-- <div class="has-error pull-left">
					<label class="control-label error-text"></label>
				</div> -->
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button type="button" class="btn btn-primary ProductSubmitBtn">
						<span class="glyphicon glyphicon-floppy-disk"></span>
						保存
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 删除模态框 -->
	<div class="modal fade modalControl" id="productDelModal" tabindex="-1"
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
					<form action="${ctx }/productServlet?method=delete">
						<div class="form-group">
							<label class="control-label text-center">你确定要删除吗？</label>
							<input type="text" hidden="hidden" name="delData" value="">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger productSubmitBtn">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态框结束  -->
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
				url : ctx + '/productServlet?method=getShopProduct', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : "application/x-www-form-urlencoded", //post方式必须（*）
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				/* sortable : false, //是否启用排序 */
				sortOrder : "asc", //排序方式
				queryParams : oTableInit.queryParams,//传递参数（*）
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 5, 10, 25, 50 ], //可供选择的每页的行数（*）
				search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大 */
				strictSearch : true,
				showColumns : true, //是否显示所有的列
				showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				/* height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度 */
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
					align : 'center',
					valign : 'middle',
					checkbox : true
				}, {
					field : 'productImg',
					title : '商品图片',
					align : 'center',
					formatter : function(value, row, index) {
						return '<img src='+value+' class="img-rounded" >';
					}
				}, {
					field : 'productName',
					title : '名称',
					align : 'center',
					valign : 'middle'
				}, {
					field : 'productLeft',
					title : '库存',
					align : 'center',
					valign : 'middle',
					sortable : true
				}, {
					field : 'productPrice',
					title : '单价',
					align : 'center',
					valign : 'middle',

					sortable : true
				}, {
					field : 'productSale',
					title : '销量',
					align : 'center',
					valign : 'middle',
					sortable : true
				}, {
					field : 'operate',
					title : '操作',
					align : 'center',
					valign : 'middle',
					events : operateEvents,
					formatter : operateFormatter
				}, ]
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				order : params.order,
				ordername : params.sort,
				productName : $("#txt_search_productName").val(),
			};
			return temp;
		};
		function operateFormatter(value, row, index) {
			return [
					'<a class="edit"   href="javascript:void(0)" title="编辑">',
					'<i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>',
					'</a>',
					'<a class="remove" href="javascript:void(0)" title="删除">',
					'<i class="glyphicon glyphicon-remove"></i>', '</a>' ]
					.join('');
		}
		;
		window.operateEvents = {
			'click .remove' : function(e, value, row, index) {
				if (confirm('您确认想要删除记录吗？')) {
					$.ajax({
						url : ctx + "/productServlet?method=removeProduct",
						type : "POST",
						data : {
							id : row.productId
						},
						success : function(msg) {
							if (msg.length > 0) {
								toastr.error(msg);
							} else {
								toastr.success("删除成功!");
								$('#tb_products').bootstrapTable('refresh');
							}
						}
					});
				}
			},
			'click .edit' : function(e, value, row, index) {
				$('#productId').val(row.productId);
				$('#productImg').val(row.productImg);
				$('#productName').val(row.productName);
				$('#productPrice').val(row.productPrice);
				$('#productSale').val(row.productSale);
				$('#productLeft').val(row.productLeft);
				$('#productModal').find('form').attr('action',ctx+'/productServlet?method=edit');
				$('#productModal').modal();
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
			$('#btn_add').click(function() {
				$('#productModal').modal();
			});
		};

		return oInit;
	};
	$('.ProductSubmitBtn').on('click', function() {
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
					location.reload();
				}
			},
			error : function() {
				toastr.error("连接超时失败，请稍后再试！");
			}
		})
	});
</script>