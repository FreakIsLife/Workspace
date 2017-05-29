/**
 * 属于侧边导航栏的js代码
 */
$(function() {
	$('.child').click(function(e) {
		/* 切换折叠指示图标 */
		$(this).find("em").toggleClass("glyphicon-plus");
		$(this).find("em").toggleClass("glyphicon-minus");
	});
	$('.kind').click(function(e) {
		/* 切换折叠指示图标 */
		$($(this).siblings('.kind')).find('ul').collapse('hide');
		$($(this).siblings('.kind')).find("em").removeClass("glyphicon-minus");
		$($(this).siblings('.kind')).find("em").addClass("glyphicon-plus");
		$($(this).siblings('.kind')).find('li').removeClass("active");
		$($(this).siblings('.kind')).find('li:first').addClass("active");
	});
});