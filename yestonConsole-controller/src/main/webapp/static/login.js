// 判断时候在Iframe框架内,在则刷新父页面
if (self != top) {
	parent.location.reload(true);
	if (!!(window.attachEvent && !window.opera)) {
		document.execCommand("stop");
	} else {
		window.stop();
	}
}

$(function() {
	// 登录
	$('#loginform')
			.form(
					{
						url : '/login',
						onSubmit : function() {
							progressLoad();
							var isValid = $(this).form('validate');
							if (!isValid) {
								progressClose();
							}
							return isValid;
						},
						success : function(result) {
							progressClose();
							result = $.parseJSON(result);
							if (result.success) {
								window.location.href = '/index';
							} else {
								$.messager
										.show({
											title : '提示',
											msg : '<div class="light-info"><div class="light-tip icon-tip"></div><div>'
													+ result.msg
													+ '</div></div>',
											showType : 'show'
										});
							}
						}
					});
});
function submitForm() {
	$('#loginform').submit();
}
function clearForm() {
	$('#loginform').form('clear');
}
// 回车登录
function enterlogin() {
	if (event.keyCode == 13) {
		event.returnValue = false;
		event.cancel = true;
		$('#loginform').submit();
	}
}
