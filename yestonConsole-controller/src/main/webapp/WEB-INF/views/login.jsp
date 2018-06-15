<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>领钱儿后台交互系统-用户登录</title>
    <meta name="viewport" content="width=device-width">
    <%@ include file="/commons/basejs.jsp" %>
    <script type="text/javascript" src="/static/js/fingerprint.js" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/static/style/css/login.css" />
    <script type="text/javascript" src="/static/login.js" charset="utf-8"></script>
    
    <script type="text/javascript">
    	$(function(){
	    	FPSLID1.ConnectfpScanner();
    		submitVerify();
    	})
    </script>
    
    <script type="text/javascript" for='FPSLID1' event='OnFpCapture(ActionResult,Atemplate,ReaderSerNum)'>
		//'验证指纹事件
		queryUserFingerPrint();
	</script>
</head>
<body onkeydown="enterlogin();">
<div class="top_div"></div>
<div style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
    <form method="post" id="loginform">
		<div title="指纹登录" style="padding:20px">
			<P style="padding: 30px 25px 15px; position: relative;">
				<span class="u_logo"></span>
				<input id="fp_username" class="ipt" type="text" name="fp_username" placeholder="请输入用户名或邮箱" value="" />
			</P>
       		<div style="height: 50px; line-height: 50px; margin-top: 5px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
        		<span>
                    <img alt="指纹GIF" src="/static/style/images/timg.gif">
                </span>
        	</div>
		</div>
    </form>
</div>

<div>
	<OBJECT ID="FPSLID1" WIDTH=0 HEIGHT=0
		CLASSID="CLSID:AEC85E68-EC97-4656-AE30-CFBB0B8DBA75">
		<PARAM NAME="_ExtentX" VALUE="5133">
		<PARAM NAME="_ExtentY" VALUE="5715">
	</OBJECT>
</div>

</body>
</html>
