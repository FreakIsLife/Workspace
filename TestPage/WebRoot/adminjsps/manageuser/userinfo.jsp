<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
	<form class="form">
		<table class="table table-bordered">
			<caption class="text-center">用户信息</caption>
			<tr>
				<th>用户名</th>
				<th>密码</th>
				<th>昵称</th>
				<th>姓名</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>联系方式</th>
				<th>电子邮箱</th>
				<th>是否开店</th>
				<th colspan='2' style="text-align: center">管理</th>
			</tr>
			<c:forEach var="bean" items="${pagebean.user}">
				<tr id="myclass">
					<td>${bean.userId }</td>
					<td>${bean.userPassword}</td>
					<td>${bean.userNickname}</td>
					<td>${bean.userName}</td>
					<c:if test="${bean.userSex eq 0}">
						<td>保密</td>
					</c:if>
					<c:if test="${bean.userSex eq 1}">
						<td>男</td>
					</c:if>
					<c:if test="${bean.userSex eq -1}">
						<td>女</td>
					</c:if>

					<td>${bean.userBirth}</td>
					<td>${bean.userPhone}</td>
					<td>${bean.userMail}</td>
					<c:if test="${bean.userIsShop eq 0 }">
						<td><a href="#shopModal" data-toggle="modal" class="addShop">开店</a></td>
					</c:if>
					<c:if test="${bean.userIsShop eq 1 }">
						<td>已开店</td>
					</c:if>
					<td><a href="#userModal" data-toggle="modal" class="edit">修改</a></td>
					<td><a
						href="${pageContext.request.contextPath }/adminServlet?method=deleteUser&userId=${bean.userId }"
						onclick="return confirm('你确定删除吗');">删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<div style="text-align: center">
		<h4>第${pagebean.pageNum}页,共${pagebean.totalPages}页</h4>
		<c:if test="${pagebean.pageNum!=1 }">
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryDate&pageNum=1"
				class="flushA">首页</a>
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryDate&pageNum=${pagebean.pageNum-1}"
				class="flushA">上一页</a>
		</c:if>
		<c:if test="${pagebean.pageNum!=pagebean.totalPages }">
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryDate&pageNum=${pagebean.pageNum+1}"
				class="flushA">下一页</a>
			<a
				href="${pageContext.request.contextPath }/adminServlet?method=PageQueryDate&pageNum=${pagebean.totalPages}"
				class="flushA">尾页</a>
		</c:if>
	</div>
</div>




<!-- 使用模态框修改用户信息 -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">用户信息</h4>
			</div>
			<div class="modal-body">
				<form
					action="${pageContext.request.contextPath }/adminServlet?method=EditUser"
					method="post" id="editForm">
					<table class="table table-bordered">
						<tr>
							<th>用户名</th>
							<td><input type="text" name="userId" id="userId" readOnly></td>
						</tr>
						<tr>
							<th>密码</th>
							<td><input type="password" name="userPassword"
								id="userPassword"></td>
						</tr>
						<tr>
							<th>昵称</th>
							<td><input type="text" name="userNickname" id="userNickname"></td>
						</tr>
						<tr>
							<th>姓名</th>
							<td><input type="text" name="userName" id="userName"></td>
						</tr>
						<tr>
							<th>性别</th>
							<td><input type="text" name="userSex" id="userSex"></td>
						</tr>
						<tr>
							<th>出生日期</th>
							<td><input type="text" name="userBirth" id="userBirth"></td>
						</tr>
						<tr>
							<th>联系方式</th>
							<td><input type="text" name="userPhone" id="userPhone"></td>
						</tr>
						<tr>
							<th>电子邮箱</th>
							<td><input type="text" name="userMail" id="userMail"></td>
						</tr>
						<tr>
							<th>是否开店</th>
							<td><input type="text" name="userIsShop" id="userIsShop"
								readOnly></td>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary EditSubmitbtn"
					value="提交">提交</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<script>
	$(function() {
		$('.edit').click(function() {
			var td = $($(this).parents('tr').find('td'));
			var $_edit = $($('#editForm'));
			$_edit.find('#userId').val(td.eq(0).text());
			$_edit.find('#userPassword').val(td.eq(1).text());
			$_edit.find('#userNickname').val(td.eq(2).text());
			$_edit.find('#userName').val(td.eq(3).text());
			$_edit.find('#userSex').val(td.eq(4).text());
			$_edit.find('#userBirth').val(td.eq(5).text());
			$_edit.find('#userPhone').val(td.eq(6).text());
			$_edit.find('#userMail').val(td.eq(7).text());
			$_edit.find('#userIsShop').val(td.eq(8).text());
		});
	});
</script>
<script>
	$(function() {
		$(".addShop").click(function() {
			var td = $($(this).parents('tr').find('td'));
			$('#shopId').val(td.eq(0).text());
		});
	});
</script>

