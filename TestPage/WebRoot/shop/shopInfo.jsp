<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
	$(function() {
		//初始化数据
		var oInfo = new InfoInit();
		oInfo.Init();
	});
	var InfoInit = function() {
		var oInfoInit = new Object();
		oInfoInit.Init = function() {
			$.ajax({
				cache : false, // 上传文件不需要缓存
				url : ctx + '/shopServlet?method=getShopInfo',
				data : '',
				type : 'post',
				dataType : 'text',
				success : function(dates) {
					$("#flush").html(dates);
				},
				error : function() {
					toastr.error("连接超时失败，请稍后再试！");
				}
			})
		}
		return oInfoInit;
	}
</script>