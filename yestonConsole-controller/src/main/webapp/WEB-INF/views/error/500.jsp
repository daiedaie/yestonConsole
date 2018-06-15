<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/commons/global.jsp"%>
<%@ include file="/commons/basejs.jsp"%>
<script type="text/javascript">
$(function() {
	timeCountInterval = setInterval("timeCount()", 1000);
});
//五秒倒计时
var time = 5;
function timeCount() {
	time -= 1;
	if (time <= 0) {
		window.location.href = "/";
		return false;
	} else {
		$("#time").text(time + "秒")
	}
}
</script>
<div class='indexdg'>
	<img alt="首页背景图片" src="/static/style/images/500.jpg">
	<div>你访问的页面出现异常,<span id="time">5</span>秒钟自动跳到首页</div>
</div>