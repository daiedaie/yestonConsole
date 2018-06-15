<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp"%>
<meta http-equiv="X-UA-Compatible" content="edge" />
<script type="text/javascript" src="/static/js/fingerprint.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="/static/style/css/fingerprint.css" />
<title>指纹信息管理</title>
<script type="text/javascript" for='FPSLID1' event='onFingerGone(onGone,ReaderSerNum)'>  //'手指离开事件
	//3
	if(enrollNum == FPSLID1.EnrollCount){
		showMessager("指纹采集完成！请点击保存按钮！");
	}else{
		$('#info').append("<p>手指离开" + enrollNum + "</p>");
	}
	appendfingerPrint();
</script> 

<script type="text/javascript" for='FPSLID1' event='EnrollIndex(Index)'>//'还需要按压多少次手指事件
	//4
	enrollNum = enrollNum + 1;
	$('#info').html("<p>您还需要按压" + Index + "次手指<p>");
</script>

<script type="text/javascript" for='FPSLID1' event='OnFpCapture(ActionResult,Atemplate,ReaderSerNum)'>
	//'6、验证指纹事件
// 	verifySaveTemplate();
	saveFingerPrint();
</script>

</head>
<body>
	<div id='main_div' class="easyui-layout" data-options="fit:true,border:false">
		<div class='input_div'>
			<span>请输入登录账号:</span>
			<input class="easyui-textbox" type="text" id="username" style="width: 200px; height: 25px;">
		</div>
		<div class='input_erci'>
			<span>录入次指纹:</span>
			<input type="checkbox" id="erci" value="1"/>
		</div>
		<div id="finger_button">
			<a id="input_finger" href="#" class="easyui-linkbutton"></a>
			<a id="dis_finger" href="#" class="easyui-linkbutton"></a>
			<a id="save_finger" href="#" class="easyui-linkbutton"></a>
		</div>
		
		<div id = "info_heard">
			<span>*操作提示信息</span>
		</div>
		<div id="info">
		</div>	
			
		<div id='object_div' >
			<textarea name="msg" style="height: 211px; width: 188px"></textarea>
			<textarea name="msg1" style="height: 211px; width: 188px"></textarea>
			<OBJECT ID="FPSLID1" WIDTH=40 HEIGHT=40
				CLASSID="CLSID:AEC85E68-EC97-4656-AE30-CFBB0B8DBA75">
				<PARAM NAME="_ExtentX" VALUE="5133">
				<PARAM NAME="_ExtentY" VALUE="5715">
			</OBJECT>
		</div>
	</div>
</body>
</html>