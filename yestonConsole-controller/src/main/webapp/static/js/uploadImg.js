$(function(){
	$('.grid input').attr("accept","image/jpg,image/jpeg,image/png");
})

//预览图片
function showLocalImage(divClass){
	var pics = $("." + divClass)[0];
	var previewDiv = $("." + divClass);
	if (pics.files && pics.files.length > 0) {
		// 校验图片
		if(!checkImg(pics.files)){
			//验证失败，清空文件框
			$("." + divClass).val("");
			return;
		}
		// 清空预览
		previewDiv.empty();
		// 创建img
		for(var i = 0;i < pics.files.length;i++){
			previewDiv.append("<img width='150' src='" + window.URL.createObjectURL(pics.files[i]) + "'/>");
		}
	}
}
//图片校验
function checkImg(imgFiles){
	var len = imgFiles.length;
	if(imgFiles && len > 0){
		for(var i = 0;i < len;i++){
			// 格式校验
	    	if(!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(imgFiles[i].name)){
	    		$.messager.alert('提示','请上传有效的图片'); 
	    		return false;
	    	}
			// 大小校验
			if(imgFiles[i].size > 500*1024){
				$.messager.alert('提示','图片大小不能超过500k'); 
	    		return false;
			}		    	
		}
	}
	return true;
}
// 取消选中
function reselect(divClass){
	$("." + divClass).val("");
   	$("." + divClass).empty();
}
// 上传
function upload(fileId){
	if($("." + fileId).val() == ''){
		$.messager.alert("提示","请选择图片","error");
		return;
	}
	progressLoad();
	$.ajaxFileUpload({
		url:'/business/uploadFile?carLoanId=' + $('#dataid').val(),
		type : 'post',
		// 与input的file类型的域id绑定
		fileElementId : fileId,
		// 是否使用安全的方式
		secureuri : false,
		data : {},
		dataType : 'json',
		success :function(msg){
			progressClose();
			if(msg.success){
				$.messager.alert("提示","上传成功","info");
			}else{
				$.messager.alert("错误","上传失败","error");
			}
		}
	});
}