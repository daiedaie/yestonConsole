<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet" type="text/css" href="/static/style/css/business.css" />
<style type="text/css" >
.center_title {
    border-bottom-color:#2679B5;
    color: #2679B5;
}
.center_title span {
    border-left-color: #2679B5;
}
.cli {
    border-color: #ddd;
}
.cli_title {
    margin-left:0;
    margin-bottom:10px;
    border-bottom-color:#E2E2E2;
    width: 100%;
}
.cli_title span{
       margin-left: 20px;
}
.upload_div_btns{padding-top:10px;}
.cli img{
   padding-left:10px;
   padding-top:10px;
}
.upload-box{
   position:relative;
   z-index:1;
   width:89px;
   height:25px;
   cursor:pointer;
}
.upload-box input{
   display:block;
   position:absolute;
   z-index:3;
   left:0;
   top:0;
   width:89px;
   height:25px;
   opacity:0;
   filter:alpha(opacity=0)
}
.upload-box a{
   position:absolute;
   z-index:2;
   left:0;
   top:0;
   width:89px;
   height:25px;
}
</style>
<script type="text/javascript" src="/static/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript" src="/static/js/uploadImg.js"></script>
<script type="text/javascript">
   	$(function(){
   		$('#businessEditForm').form({
            url : '/business/edit',
            onSubmit : function() {
            	var plateNumber = $("#plateNumber").combobox("getValue");
            	var plateNumber2 = $("#plateNumber2").textbox("getText");
            	$("input[name='plateNumber']").val(plateNumber + plateNumber2);
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
	    $('#plateNumber').combobox({    
           url:'/static/json/province.json', 
           method:'get',
           valueField:'name',    
     	   textField:'name',
     	   editable:false, 
     	   onLoadSuccess:function(){
     		   var province = "${carLoanDetail.plateNumber}";
     		   $('#plateNumber').combobox("setValue",province.charAt(0));
     		   $('#plateNumber2').textbox("setText",province.slice(1,province.length));
     	   }
     	}); 
	    initImg();
   	});
   	function initImg(){
		var travelBook = "${carLoanDetail.travelBook}".split(",");// 行驶本
		if(travelBook == 0){
			if("${carLoanDetail.travelBook}" != ''){
				$(".travelBook").append("<img src='${carLoanDetail.travelBook}' width='100px'>");
			}
		} else{
			for(var i in travelBook){
				$(".travelBook").append("<img src='" + travelBook[i] + "' width='100px'>");
			}
		}
		var idcardLicense = "${carLoanDetail.idcardLicense}".split(",");// 身份证  / 营业执照
		if(idcardLicense == 0){
			if("${carLoanDetail.idcardLicense}" != ''){
				$(".idcardLicense").append("<img src='${carLoanDetail.idcardLicense}' width='100px'>");
			}
		} else{
			for(var i in idcardLicense){
				$(".idcardLicense").append("<img src='" + idcardLicense[i] + "' width='100px'>");
			}
		}
		var vehicleEvaluationReport = "${carLoanDetail.vehicleEvaluationReport}".split(",");// 车辆评估报告
		if(vehicleEvaluationReport == 0){
			if("${carLoanDetail.vehicleEvaluationReport}" != ''){
				$(".vehicleEvaluationReport").append("<img src='${carLoanDetail.vehicleEvaluationReport}' width='100px'>");
			}
		} else{
			for(var i in vehicleEvaluationReport){
				$(".vehicleEvaluationReport").append("<img src='" + vehicleEvaluationReport[i] + "' width='100px'>");
			}
		}
		var loanAgreement = "${carLoanDetail.loanAgreement}".split(",");// 委托借款协议
		if(loanAgreement == 0){
			if("${carLoanDetail.loanAgreement}" != ''){
				$(".loanAgreement").append("<img src='${carLoanDetail.loanAgreement}' width='100px'>");
			}
		} else{
			for(var i in loanAgreement){
				$(".loanAgreement").append("<img src='" + loanAgreement[i] + "' width='100px'>");
			}
		}
		var vehicleCertificate = "${carLoanDetail.vehicleCertificate}".split(",");// 机动车登记证
		if(vehicleCertificate == 0){
			if("${carLoanDetail.vehicleCertificate}" != ''){
				$(".vehicleCertificate").append("<img src='${carLoanDetail.vehicleCertificate}' width='100px'>");
			}
		} else{
			for(var i in vehicleCertificate){
				$(".vehicleCertificate").append("<img src='" + vehicleCertificate[i] + "' width='100px'>");
			}
		}
		var vehicleTaxCertificate = "${carLoanDetail.vehicleTaxCertificate}".split(",");// 车辆购置完税证明
		if(vehicleTaxCertificate == 0){
			if("${carLoanDetail.vehicleTaxCertificate}" != ''){
				$(".vehicleTaxCertificate").append("<img src='${carLoanDetail.vehicleTaxCertificate}' width='100px'>");
			}
		} else{
			for(var i in vehicleTaxCertificate){
				$(".vehicleTaxCertificate").append("<img src='" + vehicleTaxCertificate[i] + "' width='100px'>");
			}
		}
		var vehicalInvoice = "${carLoanDetail.vehicalInvoice}".split(",");// 车辆发票
		if(vehicalInvoice == 0){
			if("${carLoanDetail.vehicalInvoice}" != ''){
				$(".vehicalInvoice").append("<img src='${carLoanDetail.vehicalInvoice}' width='100px'>");
			}
		} else{
			for(var i in idcardLicense){
				$(".vehicalInvoice").append("<img src='" + vehicalInvoice[i] + "' width='100px'>");
			}
		}
		var vehicalPhoto = "${carLoanDetail.vehicalPhoto}".split(",");// 车辆照片
		if(vehicalPhoto == 0){
			if("${carLoanDetail.vehicalPhoto}" != ''){
				$(".vehicalPhoto").append("<img src='${carLoanDetail.vehicalPhoto}' width='100px'>");
			}
		} else{
			for(var i in vehicalPhoto){
				$(".vehicalPhoto").append("<img src='" + vehicalPhoto[i] + "' width='100px'>");
			}
		}
		var loanContract = "${carLoanDetail.loanContract}".split(",");// 借款合同
		if(loanContract == 0){
			if("${carLoanDetail.loanContract}" != ''){
				$(".loanContract").append("<img src='${carLoanDetail.loanContract}' width='100px'>");
			}
		} else{
			for(var i in loanContract){
				$(".loanContract").append("<img src='" + loanContract[i] + "' width='100px'>");
			}
		}
		var iou = "${carLoanDetail.iou}".split(",");// 借条
		if(iou == 0){
			if("${carLoanDetail.iou}" != ''){
				$(".iou").append("<img src='${carLoanDetail.iou}' width='100px'>");
			}
		} else{
			for(var i in iou){
				$(".iou").append("<img src='" + iou[i] + "' width='100px'>");
			}
		}
		var capitalRequirement = "${carLoanDetail.capitalRequirement}".split(",");// 资金需求表
		if(capitalRequirement == 0){
			if("${carLoanDetail.capitalRequirement}" != ''){
				$(".capitalRequirement").append("<img src='${carLoanDetail.capitalRequirement}' width='100px'>");
			}
		} else{
			for(var i in capitalRequirement){
				$(".capitalRequirement").append("<img src='" + capitalRequirement[i] + "' width='100px'>");
			}
		}
		var policy = "${carLoanDetail.policy}".split(",");// 保单
		if(policy == 0){
			if("${carLoanDetail.policy}" != ''){
				$(".policy").append("<img src='${carLoanDetail.policy}' width='100px'>");
			}
		} else{
			for(var i in policy){
				$(".policy").append("<img src='" + policy[i] + "' width='100px'>");
			}
		}
		var vehicleInventory = "${carLoanDetail.vehicleInventory}".split(",");// 机动车封存清单
		if(policy == 0){
			if("${carLoanDetail.vehicleInventory}" != ''){
				$(".vehicleInventory").append("<img src='${carLoanDetail.vehicleInventory}' width='100px'>");
			}
		} else{
			for(var i in vehicleInventory){
				$(".vehicleInventory").append("<img src='" + vehicleInventory[i] + "' width='100px'>");
			}
		}
	}
   	
   	function count(){
   		var loanAmount = $('#loanAmount').textbox('getText');
   		if(loanAmount != '' && !verifyNumber(loanAmount)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#loanAmount").textbox('setText','');
    		return;
    	}
		var loanTerm = $('#loanTerm').textbox('getText');
		if(loanTerm != '' && !verifyNumber(loanTerm)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#loanTerm").textbox('setText','');
    		return;
    	}
		var rate = $('#rate').textbox('getText');
		if(rate != '' && !verifyNumber(rate)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#rate").textbox('setText','');
    		return;
    	}
		var value = Number(loanAmount) + Number((loanAmount * rate / 100 / 365 * loanTerm).toFixed(2));
		$('#estRepAmount').textbox('setText',value); 
		$('input[name=\'estRepAmount\']').val(value);
		$('#actRepAmount').textbox('setText',value);                
		$('input[name=\'actRepAmount\']').val(value);
   	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="padding: 3px; overflow-y: scroll;" >
        <form id="businessEditForm" method="post">
        	<input type="hidden" name="id" id="dataid" value="${carLoanDetail.id}">
        	<div class="center_title"><span>车辆基本信息</span></div>
            <table class="grid">
                <tr>
                    <td style="width:100px">车牌号</td>
                    <td >
                    	<input id="plateNumber" name="plateNumber" style="width:40px" data-options="required:true"/>
                    	<input id="plateNumber2" class="easyui-textbox" style="width:107px" data-options="required:true"> 
                    </td>
                    <td style="width:100px">车辆型号</td>
                    <td><input name="vehicleType" class="easyui-textbox" value="${carLoanDetail.vehicleType}" style="width:150px" data-options="required:true"></td>
                </tr>
                <tr>
                	<td style="width:100px">是否运营</td>
                    <td>
                    	<select name="whetherOperation" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="0" <c:if test="${carLoanDetail.whetherOperation == 0}">selected="selected"</c:if>>否</option>
                    		<option value="1" <c:if test="${carLoanDetail.whetherOperation == 1}">selected="selected"</c:if>>是</option>
                    	</select>
                    </td>
                     <td style="width:100px">车辆年限</td>
                    <td><input name="vehicleLife" class="easyui-numberbox" value="${carLoanDetail.vehicleLife}" style="width:148px" data-options="required:true">&nbsp;&nbsp;月</td>
                 </tr>
                 <tr>
                 	<td style="width:100px">车辆所属</td>
                    <td>
                    	<select name="vehicleOwnership" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="1" <c:if test="${carLoanDetail.vehicleOwnership == 1}">selected="selected"</c:if>>个人</option>
                    		<option value="2" <c:if test="${carLoanDetail.vehicleOwnership == 2}">selected="selected"</c:if>>公司</option>
                    	</select>
                    </td>
                    <td style="width:100px">姓名/名称</td>
                    <td><input name="ownerName" class="easyui-textbox" value="${carLoanDetail.ownerName}" data-options="required:true" style="width:150px"></td>
                </tr>
                
                <tr>
                    <td style="width:100px">行驶公里数</td>
                    <td colspan="3"><input name="kilometers" class="easyui-numberbox" data-options="required:true" value="${carLoanDetail.kilometers}" style="width:148px">&nbsp;&nbsp;公里</td>
                </tr>
            </table>
            <div class="center_title"><span>借款信息</span></div>
            <table class="grid">
            	<tr>
                    <td style="width:100px">借款金额</td>
                    <td><input id="loanAmount" name="loanAmount" value="${carLoanDetail.loanAmount}" class="easyui-textbox" data-options="onChange:count,required:true" style="width:148px">&nbsp;&nbsp;元</td>
                    <td style="width:100px">借款期限</td>
                    <td><input id="loanTerm" name="loanTerm" value="${carLoanDetail.loanTerm}" class="easyui-textbox" data-options="onChange:count,required:true" style="width:148px">&nbsp;&nbsp;天</td>
                </tr>
                <tr>
                    <td style="width:100px">利率</td>
                    <td><input id="rate" class="easyui-textbox" value="${carLoanDetail.rate}" name="rate" style="width:148px" data-options="onChange:count,required:true">&nbsp;&nbsp;%</td>
                    <td style="width:100px">抵押方式</td>
                    <td>
                    	<select name="singleDoubleCharge" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="1" <c:if test="${carLoanDetail.singleDoubleCharge == 1}">selected="selected"</c:if>>单押</option>
                    		<option value="2" <c:if test="${carLoanDetail.singleDoubleCharge == 2}">selected="selected"</c:if>>双押</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px">是否一抵押</td>
                    <td>
                    	<select name="dollarsNumber" class="easyui-combobox" style="width:150px" data-options="
                    			panelHeight:'auto',editable:false,
                    			onSelect: function(record){
                    				if(record.value == 1){
                    					$('#oneDollarsName').textbox('disable');
                    				} else {
										$('#oneDollarsName').textbox('enable');
                    				}
                    			}" >
                    		<option value="1" <c:if test="${carLoanDetail.dollarsNumber == 1}">selected="selected"</c:if>>一抵押</option>
                    		<option value="2" <c:if test="${carLoanDetail.dollarsNumber == 2}">selected="selected"</c:if>>二抵押</option>
                    	</select>
                    </td>
                    <td style="width:100px">上一抵押人</td>
                    <td><input id="oneDollarsName" name="oneDollarsName" value="${carLoanDetail.oneDollarsName}" <c:if test="${carLoanDetail.dollarsNumber == 1}">data-options="disabled:'true'"</c:if> class="easyui-textbox" style="width:150px"></td>
                </tr>
                <tr>
                	<td style="width:100px">预计还款金额</td>
                    <td><input id="estRepAmount" name="estRepAmount" value="${carLoanDetail.estRepAmount}" class="easyui-textbox" data-options="readonly:'true'" style="width:148px">&nbsp;&nbsp;元</td>
                    <td style="width:100px">实际还款金额</td>
                    <td><input id="actRepAmount" name="actRepAmount" value="${carLoanDetail.actRepAmount}" class="easyui-textbox" data-options="readonly:'true'" style="width:148px">&nbsp;&nbsp;元</td>
                </tr>
            </table>
        </form>
        <div class="center_title"><span>资料信息</span></div>
        <div class='cli' style="border:1px solid #2679B5">
        	<div class='cli_title'><span>行驶本</span></div>
        	<div class='upload_div'>
        	    <div class="upload-box">
   			   		<input id="travelBook" class="travelBook" name="travelBook" type="file" onchange="showLocalImage('travelBook');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
	       		<div class='travelBook' ></div>
	       		<div class="upload_div_btns">
	       		   <a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('travelBook')">上传</a>
	               <a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('travelBook');" >重新选择</a>  
	       		</div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #5FAA60">
        	<div class='cli_title'><span>身份证/营业执照</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="idcardLicense" class="idcardLicense" name="idcardLicense" type="file" onchange="showLocalImage('idcardLicense');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='idcardLicense' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('idcardLicense')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('idcardLicense');" >重新选择</a>  
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #CB6FD7">
        	<div class='cli_title'><span>车辆评估报告</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="vehicleEvaluationReport" class="vehicleEvaluationReport" name="vehicleEvaluationReport" type="file" onchange="showLocalImage('vehicleEvaluationReport');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicleEvaluationReport' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicleEvaluationReport')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleEvaluationReport');" >重新选择</a>        	
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #D5595A">
        	<div class='cli_title'><span>委托借款协议</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="loanAgreement" class="loanAgreement" name="loanAgreement" type="file" onchange="showLocalImage('loanAgreement');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='loanAgreement' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('loanAgreement')">上传</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('loanAgreement');" >重新选择</a>  
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #F79263">
        	<div class='cli_title'><span>机动车登记证</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="vehicleCertificate" class="vehicleCertificate" name="vehicleCertificate" type="file" onchange="showLocalImage('vehicleCertificate');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicleCertificate' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicleCertificate')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleCertificate');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #2679B5">
        	<div class='cli_title'><span>车辆购置完税证明</span></div>
        	<div class='upload_div'>
                <div class="upload-box">
   			   		<input id="vehicleTaxCertificate" class="vehicleTaxCertificate" name="vehicleTaxCertificate" type="file" onchange="showLocalImage('vehicleTaxCertificate');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicleTaxCertificate' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicleTaxCertificate')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleTaxCertificate');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #5FAA60">
        	<div class='cli_title'><span>车辆发票</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="vehicalInvoice" class="vehicalInvoice" name="vehicalInvoice" type="file" onchange="showLocalImage('vehicalInvoice');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicalInvoice' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicalInvoice')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicalInvoice');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #CB6FD7">
        	<div class='cli_title'><span>车辆照片</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="vehicalPhoto" class="vehicalPhoto" name="vehicalPhoto" type="file" onchange="showLocalImage('vehicalPhoto');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicalPhoto' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicalPhoto')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicalPhoto');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #D5595A">
        	<div class='cli_title'><span>借款合同</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="loanContract" class="loanContract" name="loanContract" type="file" onchange="showLocalImage('loanContract');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='loanContract' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('loanContract')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('loanContract');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #9ABC32">
        	<div class='cli_title'><span>借条</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="iou" class="iou" name="iou" type="file" onchange="showLocalImage('iou');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='iou' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('iou')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('iou');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #FFB752">
        	<div class='cli_title'><span>资金需求表</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="capitalRequirement" class="capitalRequirement" name="capitalRequirement" type="file" onchange="showLocalImage('capitalRequirement');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='capitalRequirement' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('capitalRequirement')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('capitalRequirement');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli' style="border:1px solid #CE6F9E">
        	<div class='cli_title'><span>保单</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="policy" class="policy" name="policy" type="file" onchange="showLocalImage('policy');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='policy' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('policy')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('policy');" >重新选择</a>
        	    </div>
        	</div>
        </div>
        <div class='cli'>
        	<div class='cli_title'><span>机动车封存清单</span></div>
        	<div class='upload_div'>
               	<div class="upload-box">
   			   		<input id="vehicleInventory" class="vehicleInventory" name="vehicleInventory" type="file" onchange="showLocalImage('vehicleInventory');" multiple="multiple" accept="image/*">
   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
   			    </div>
               	<div class='vehicleInventory' ></div>
               	<div class="upload_div_btns">
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" href="javascript:upload('vehicleInventory')">上传</a>
               		<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleInventory');" >重新选择</a>  
        	    </div>
        	</div>
        </div>
    </div>
</div>