<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"
	scope="session" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href='<c:url value="/bootstrap/css/bootstrap.min.css"></c:url>'
	rel="stylesheet">
<link href='<c:url value="/css/formValidation.min.css"></c:url>'
	rel="stylesheet">
<link
	href='<c:url value="/css/bootstrap-datetimepicker.min.css"></c:url>'
	rel="stylesheet">
<link href='<c:url value="/css/bootstrap-table.min.css"></c:url>'
	rel="stylesheet">
<link href='<c:url value="/toastr/toastr.min.css"></c:url>'
	rel="stylesheet">
<link href='<c:url value="/css/common.css"></c:url>' rel="stylesheet">
<script src='<c:url value="/js/jquery.min.js"></c:url>'></script>
<script src='<c:url value="/bootstrap/js/bootstrap.min.js"></c:url>'></script>
<script src='<c:url value="/js/formValidation.min.js"></c:url>'></script>
<script src='<c:url value="/js/framework/bootstrap.min.js"></c:url>'></script>
<script src='<c:url value="/js/language/zh_CN.js"></c:url>'></script>
<script
	src='<c:url value="/js/bootstrap-datetimepicker.min.js"></c:url>'></script>
<script
	src='<c:url value="/js/locales/bootstrap-datetimepicker.zh-CN.js"></c:url>'></script>
<script
	src='<c:url value="/js/bootstrap-table/bootstrap-table.min.js"></c:url>'></script>
<script
	src='<c:url value="/js/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></c:url>'></script>
<script src='<c:url value="/toastr/toastr.min.js"></c:url>'></script>
<script src='<c:url value="/js/jquery.pjax.js"></c:url>'></script>
<script src='<c:url value="/js/common.js"></c:url>'></script>
<script type="text/javascript">
	var ctx = '${ctx }';
</script>
</head>
<!-- 这是一个未完成的主页  -->
<body>
	<div id="head">
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<div class="container" style="margin-top:50px;">
		<div class="page-header">
			<h3>
				类淘宝购物平台<small> -Demo 1.0</small>
			</h3>
		</div>
		<div class="row" id="body">
			<div class="navbar-left col-sm-3 col-lg-2 text-center">
				<jsp:include page="navSider.jsp"></jsp:include>
			</div>
			<div class="col-sm-9 col-lg-10" id="flush">
				<jsp:include page="showPage.jsp"></jsp:include>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			if (${choose!=null?true:false}) {
				chooseNav('${choose }');
			}
		});
	</script>
</body>
</html>
