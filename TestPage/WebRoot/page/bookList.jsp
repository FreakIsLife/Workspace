<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>童话类</title>
<script type="text/javascript">
	/* 此处做收藏的切换 */
	$(document).ready(
			function() {
				$(".heart").click(
						function(e) {
							e.preventDefault();
							$(this).find('span').toggleClass(
									"glyphicon glyphicon-heart");
							$(this).find('span').toggleClass(
									"glyphicon glyphicon-heart-empty");
						})
			});
</script>
<style type="text/css">
.hover_ora:hover {
	color: orange;
}

.for_price {
	color: #FF4400;
	font-size: 20px;
	font-weight: bold;
}

.fin_num {
	margin-top: 6px;
	float: right;
	font-size: 12px;
}

.cap_div {
	height: 90px;
}

.bottom_footer {
	position: fixed; /*or前面的是absolute就可以用*/
	bottom: 0px;
}
</style>
<!-- 显示数据； -->
<c:if test="${empty pageBean}">暂无商品信息</c:if>
<c:if test="${not empty pageBean}">
	<c:forEach items="${pageBean.beanList}" var="bean">
		<div class="col-sm-6 col-md-3">
			<div class="thumbnail">
				<img style="height:150px" src="${bean.productImg }" alt="通用的占位符缩略图">
				<div class="caption" class="cap_div">
					<b class="for_price">RMB:${bean.productPrice } </b> <b
						class="fin_num">${bean.productSale }人付款</b> <br>
					<a class="hover_ora flushPage"
						href="/TestPage/productServlet?method=getProductIntro&productId=${bean.productId}">
						${bean.productName }</a>
				</div>
				<p>
					<a href="javascript:void(0)" data-id="${bean.productId}"
						data-num="1" class="btn btn-primary addCart" role="button">
						加入购物车
						<span class="glyphicon glyphicon-shopping-cart"></span>
					</a>
					&nbsp;&nbsp;&nbsp;
					<a href="#" class="btn btn-default btn-md heart" role="button">
						<span class="glyphicon glyphicon-heart-empty"></span>
					</a>
				</p>
			</div>
		</div>
	</c:forEach>
	<c:if test="${pageBean.totalPage>1}">
		<nav aria-label="Page navigation" class="bottom_footer">
			<ul class="pagination">
				<li>
					<a class="flushPage ${pageBean.pageNum==1?'disabled':''}"
						href="/TestPage/productServlet?method=getProduct&pageNum=${pageBean.pageNum-1}"
						aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				<!-- 当前页  -->
				<c:forEach begin="${pageBean.pageNum-2>0?pageBean.pageNum-2:1 }"
					end="${pageBean.pageNum+2<=pageBean.totalPage?pageBean.pageNum+2:pageBean.totalPage}">
					<c:if test="${pageBean.pageNum==i }">
						<li>
							<a class="active" href="#">${i }</a>
						</li>
					</c:if>
					<c:if test="${pageBean.pageNum!=i }">
						<li>
							<a
								href="/TestPage/productServlet?method=getProduct&pageNum=${i }">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<li>
					<a
						class="flushPage ${pageBean.pageNum==pageBean.totalPage?'disabled':''}"
						href="/TestPage/productServlet?method=getProduct&pageNum=${pageBean.pageNum+1 }"
						aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</nav>
	</c:if>
</c:if>
<script>
	$('.addCart').click(function(e) {
		e.preventDefault();
		if (${empty loginUser?true:false}) {
			$('#loginModal').modal();
		} else {
			var productId = $(this).data('id');
			var num = $(this).data('num');
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
</script>
