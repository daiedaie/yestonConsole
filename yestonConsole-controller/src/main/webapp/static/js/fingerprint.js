var enrollNum;
var fg1;
var fg2;

$(function(){
	$('#input_finger').on('click', function(){
		//1、判断用户是否存在
		fingerPrintLogin();
	});
	
	$('#dis_finger').on('click', function(){
		disConnectfpScanner();
	});
	
	$('#save_finger').on('click', function(){
		//5
		submitVerify();
	})
})

/**
 * 2、初始化，链接指纹仪
 */
function getConnectfpScanner() {
	enrollNum = 0;
	if(FPSLID1.ConnectfpScanner()){
		$('#info').append("<p> " + FPSLID1.GetSerialNumber() + "<p>");
		return true;
	}
	showMessager("请插入指纹仪");
	return false;
}

/**
 * 断开指纹仪
 */
function disConnectfpScanner(){
	FPSLID1.DisConnectFPScanner()
	showMessager("断开指纹仪");
}

/**
 * 开始出发登记指纹
 */
function submitRegister() {
	FPSLID1.EnrollCount = 3;// 这里设置登记次数
	FPSLID1.BeginEnroll();// 开始触发登记
	$('#info').append("<p>开始登记指纹<p>");
}

/**
 * 获取登记指纹数据，于登记次数有关，登记次数完成后，才能获取数据
 * 数据为字符串
 */
function appendfingerPrint(){
	msg.value = FPSLID1.GetRegTemplateAsStr();
}

/**
 * 验证用户是否存在
 */
function fingerPrintLogin() {
	var username = $("#username").val();
	if (username != '') {
		// 通过用户名获取数据库中的指纹信息
		queryFingerInfo(username);
	} else {
		showMessager("登录账号不能为空");
	}
}

/**
 * 登录账号查询用户是否存在
 * @param username
 */
function queryFingerInfo(username) {
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : '/user/verifyHaveUser?v=' + new Date().getTime(),
		data : {username:username},
		success : function(data) {
			if(data.success){
				if($('#erci').is(":checked")){
					if(data.msg == null || data.msg == ''){
						showMessager("请先进行第一次录入！");
						return false;
					}else{
						onefinger = data.msg;
					}
				}
				var conn = getConnectfpScanner();
				if(conn){
					submitRegister();
				}
			}else{
				showMessager(data.msg);
			}
		}
	});
}

/**
 * 设置开始验证
 */
function submitVerify() {
	FPSLID1.StateMark = 2;// 设置进入指纹验证状态
	showMessager('开始验证');
}

function verifySaveTemplate(){
	var username = $('#fp_username').val();
	//获取用户指纹信息
	fg2 = FPSLID1.GetVerTemplateAsStr();
	if (FPSLID1.VerifyTemplateFromStr(fg1, fg2) || FPSLID1.VerifyTemplateFromStr(fg11, fg2)) {
		showMessager("验证成功！"); 
		$.ajax({
			async:true,
			type : 'POST',
			dataType : "json",
			url : '/loginfg',
			data : {username:username, ok:fg1},
			success : function(data) {
				if (data.success) {
					window.location.href = '/index';
				} else {
					showMessager("登录失败！");
				}
			}
		});
	} else {
		showMessager("验证失败，请重新按指纹仪！");
	}
}

function queryUserFingerPrint(){
	var username = $('#fp_username').val();
	showMessager(username);
	if(username == ''){
		showMessager("用户名不能为空！");
	}else{
		$.ajax({
			async:true,
			type : 'POST',
			dataType : "json",
			url : '/user/verifyHaveUser?v=' + new Date().getTime(),
			data : {username:username},
			success : function(data) {
				if(data.success){
					fg1 = data.msg.split(";")[0];
					fg11 = data.msg.split(";")[1];
					verifySaveTemplate();
				}else{
					showMessager("用户不存在！");
					return false;
				}
			}
		});
	}
}

/**
 * 7、保存用户指纹信息
 */
function saveFingerPrint(){
	var fingerInfo = "";
	var fingerInfo2 = "";
	
	if($('#erci').is(":checked")){
		fingerInfo2 = msg.value;
	}else{
		fingerInfo = msg.value;
	}
	
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : '/user/saveFingerPrint?v=' + new Date().getTime(),
		data : {fingerPrint:fingerInfo, fingerPrint2:fingerInfo2, username:$("#username").val()},
		success : function(data) {
			showMessager(data.msg)
		}
	});
}


/**
 * 消息提示窗口
 * @param msgs
 */
function showMessager(msgs){
	$.messager.show({
		title : '提示',
		msg : '<div class="light-info"><div class="light-tip icon-tip"></div><div>' + msgs + '</div></div>',
		showType : 'show'
	});
}
