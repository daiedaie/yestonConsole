<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>当前流程图</title>
</head>
<body>
<!-- 1.获取到规则流程图 -->
<img style="position: absolute;top: 0px;left: 0px;" src="/process/viewImg?id=${deploymentId}&imgName=${imageName}">

<!-- 2.根据当前活动的坐标，动态绘制DIV -->
<div style="position: absolute;border:2px solid red;top:${coordinate.y-2}px;
	left: ${coordinate.x-2}px;width: ${coordinate.width}px;height:${coordinate.height}px;">
</div>
</body>
</html>