<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div>
	<form class="form1">
		<table class="table table-bordered">
			<caption class="text-center">商店信息</caption>
			<tr>
				<th>商店ID</th>
				<th>商店名称</th>
				<th>商店QQ</th>
				<th>开店日期</th>
				<th colspan="2" style="text-align: center">管理</th>
			</tr>
			<c:forEach var="shop" items="${pageshop.shop}">
				<tr>
					<td>${shop.shopId }</td>
					<td>${shop.shopName}</td>
					<td>${shop.shopQQ}</td>
					<td>${shop.shopStart}</td>
					<td><a href="#editshopModal" data-toggle="modal"
						class="editshop">修改</a></td>
					<td><a href="${pageContext.request.contextPath }/adminServlet?method=deleteShop&shopId=${shop.shopId }"
						onclick="return confirm('你确定删除吗');">删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<div style="text-align: center">
		<h4>第${pageshop.pageNum}页,共${pageshop.totalPages}页</h4>
		<c:if test="${pageshop.pageNum!=1 }">
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryShop&pageNum=1"
				class="flushA">首页</a>
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryShop&pageNum=${pageshop.pageNum-1}"
				class="flushA">上一页</a>
		</c:if>
		<c:if test="${pageshop.pageNum!=pageshop.totalPages }">
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryShop&pageNum=${pageshop.pageNum+1}"
				class="flushA">下一页</a>
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryShop&pageNum=${pageshop.totalPages}"
				class="flushA">尾页</a>
		</c:if>
	</div>
</div>

<!-- 使用模态框对商店进行修改 -->
<div class="modal fade" id="editshopModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">商店信息</h4>
			</div>
			<div class="modal-body">
				<form
					action="${pageContext.request.contextPath }/adminServlet?method=EditShop"
					method="post" id="addShopForm">
					<table class="table table-bordered">
						<tr>
							<th>商店ID</th>
							<td><input type="text" name="shopId" id="shopId" readonly></td>
						</tr>
						<tr>
							<th>商店名</th>
							<td><input type="text" name="shopName" id="shopName"></td>
						</tr>
						<tr>
							<th>qq联系方式</th>
							<td><input type="text" name="shopQQ" id="shopQQ"></td>
						</tr>
						<tr>
							<td colspan='2' style="text-align: center"><button
									type="submit" class="btn btn-primary" value="提交">提交</button></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(function() {
		$(".editshop").click(function() {
			var td = $($(this).parents('tr').find('td'));
			$("#shopId").val(td.eq(0).text());
			$("#shopName").val(td.eq(1).text());
			$("#shopQQ").val(td.eq(2).text());
		});
	});
</script>
