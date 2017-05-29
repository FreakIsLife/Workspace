<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.JavaWeb.com/PicTranser" prefix="TranPic"%>
<div class="row">
	<div class="col-xs-5 col-md-5">
		<a href="#" class="thumbnail">
			<img src="${product.productImg }" alt="${product.productName}"
				style="height:400px;">
		</a>
	</div>
	<div class="col-xs-6 col-xs-offset-1 col-md-6 col-md-offset-1">
		<form>
			<div class="form-group">
				<h3 style="font-weight: bolder; color: black;">名字：${product.productName}</h3>
			</div>
			<div class="form-group">
				<div class="tb-detail-price">
					<b class="sys_item_mktprice">价格：<em>¥</em>${product.productPrice}</b>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">配送至</label>
				<div data-toggle="distpicker" style="clear:left">
					<label>
						<select name="province" class="form-control"
							data-province="---- 选择省 ----"></select>
						<select name="city" class="form-control" data-city="---- 选择市 ----"></select>
						<select name="district" class="form-control"
							data-district="---- 选择区 ----"></select>
						<input type="text" name="detail" id="detail"
							placeholder="写详细地址、收件人、联系方式，空格分隔" />
					</label>
				</div>
				<label class="control-label">
					快递：<b style="color:olive;">包邮</b>
				</label>
			</div>
			<div class="form-group">
				<label class="control-label">
					<span>销量：${product.productSale}</span>
				</label>
			</div>
			<div class="form-group">
				<label class="control-label">
					<span>数量：</span>
				</label>
				<a class="math" href="javascript:void(0)" title="增加" data-number="1">
					<i class="glyphicon glyphicon-plus"></i>
				</a>
				<input class="write" type="text" id="orderNum"
					style="width:40px;text-align:center;" value="1" />
				<a class="math" href="javascript:void(0)" title="减少"
					data-number="-1">
					<i class="glyphicon glyphicon-minus"></i>
				</a>
				<span>库存:${product.productLeft}件</span>
			</div>
			<div class="form-group">
				<p>
					<a href="#" class="btn btn-warning" role="button">
						立即购买
						<span class="glyphicon glyphicon-shopping-cart"></span>
					</a>
					&nbsp;&nbsp;&nbsp;
					<a href="#" class="btn btn-primary addCart" role="button">
						加入购物车
						<span class="glyphicon glyphicon-shopping-cart"></span>
					</a>
				</p>
			</div>
		</form>
	</div>
</div>
<script src='<c:url value="/js/distpicker/distpicker.js"></c:url>'></script>
<script>
	$('.addCart').click(function(e) {
		e.preventDefault();
		if (${empty loginUser?true:false}) {
			$('#loginModal').modal();
		} else {
			var productId = '${product.productId }';
			var num = $('#orderNum').val();
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
	})
	$('.math').click(function() {
		var num = parseInt($(this).data('number'));
		var number = num + parseInt($('#orderNum').val());
		if (parseInt(number) > 0 && number <= parseInt(${product.productLeft})) {
			$('#orderNum').val(number);
		}
	})
	$('.write').blur(function(){
		var number = $('#orderNum').val();
		if(isNaN(number) || parseInt(number) < 0 || number > parseInt(${product.productLeft})) {
			$('#orderNum').val(1);
		}
	})
</script>