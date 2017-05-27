<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.JavaWeb.com/PicTranser" prefix="TranPic"%>
<title>订单确认</title>
<ul class="breadcrumb">
	<li>
		<a href='<c:url value="/user/userCenter.jsp"></c:url>'>
			<span class="glyphicon glyphicon-home"></span>
		</a>
	</li>
	<li class="active">生成订单</li>
</ul>
<table class="table">
	<tr>
		<th>商品图片</th>
		<th>名称</th>
		<th>单价</th>
		<th>数量</th>
		<th>价格</th>
	</tr>
	<c:if test="${empty item }">
		<tr>
			<td colspan="5">暂无订单信息，请返回购物车确认！</td>
		</tr>
	</c:if>
	<c:if test="${not empty item }">
		<c:forEach items="${item }" var="bean">
			<tr>
				<td><img src="${TranPic:smPic(bean.cartImg) }"></img></td>
				<td>${bean.cartName }</td>
				<td>${bean.cartPrice }</td>
				<td>${bean.cartNum }</td>
				<td>${bean.cartPrice * bean.cartNum}</td>
			</tr>
		</c:forEach>
	</c:if>
</table>
<p>
	总计：
	<strong>${total }<span class="glyphicon glyphicon-jpy"></span>
	</strong>
</p>
<form class="form-inline mt-2 mb-4" action="${ctx }/orderServlet"
	id="commitForm">
	<div class="radio">
		<label>
			<input type="radio" name="orderAddress" id="orderAddress"
				value="${address }" ${empty address?'disabled':'' } />
			<c:if test="${not empty address }">${address }</c:if>
			<c:if test="${empty address }">您暂未设置默认地址！</c:if>
		</label>
	</div>
	<br />
	<div class="radio" data-toggle="distpicker" style="clear:left">
		<label>
			<input type="radio" name="orderAddress" id="orderAddress" value="diy" />
			<select name="province" class="form-control"
				data-province="---- 选择省 ----"></select>
			<select name="city" class="form-control" data-city="---- 选择市 ----"></select>
			<select name="district" class="form-control"
				data-district="---- 选择区 ----"></select>
			<input type="text" name="detail" id="detail"
				placeholder="写详细地址、收件人、联系方式，空格分隔" />
		</label>
	</div>
	<div class="form-group">
		<input type="text" hidden="hidden" name="itemId" value='${itemId }'>
	</div>
	<div class="form-group pull-right">
		<button type="submit" class="btn btn-default">确认订单</button>
	</div>
</form>
<script src='<c:url value="/js/distpicker/distpicker.min.js"></c:url>'></script>
<script>
	$(function() {
		$('#commitForm').submit(function(e) {
			e.preventDefault();
			var $submitForm = $(this);
			var Form = $submitForm[0];
			var submitUrl = $submitForm.attr('action');
			var submitMsg = new FormData(Form);
			$.ajax({
				url : submitUrl + '?method=add',
				data : submitMsg,
				type : 'post',
				processData : false, // data值是FormData对象，不需要对数据做处理
				contentType : false,
				success : function(msg) {
					$('#flush').html(msg);
				},
				error : function() {
					toastr.error("连接超时失败，请稍后再试！");
				}
			})
		});
	});
</script>