<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet" type="text/css" href="/static/style/css/task.css" />
<style type="text/css" >
.center_title {
    border-bottom-color:#2679B5;
    color: #2679B5;
    line-height:30px;
}
.center_title span {
    border-left:8px solid #2679B5;
    padding-left:5px;
}
.cli {
    border-color: #ddd;
}
.cli_title {
    margin-left:0;
    margin-bottom:10px;
    border-bottom-color:#E2E2E2;
    width: 100%;
    transform:rotate(0);
    background:none
}
.cli_title span{
       margin-left: 20px;
}
.grid th {
    background: none repeat scroll 0 0 #f7f7f7;
    color:#707070
}
.cli_image{padding-left:5px;}
#append_button{
    float:right;
    margin-right:35px;
    width:120px;
    background:#B74635;
    color:#fff;
    border:0;
    outline:none
}
#evidenceImg{clear:both;padding-top:10px;}
#evidenceImg img{padding-left:5px;}
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
.btn-dynamic{
    background: #fff;
	color: black;
	border: 1px solid #B7D2FF;
    border-radius:5px;
    -webkit-border-radius:5px;
}
.btn-dynamic:hover{
    background: #EAF2FF;
}
.validatebox-invalid{
   width:720px !important;
   background-color:#fff !important;
}
.textbox, .textbox text{
   width:720px !important;
}
</style>
<script type="text/javascript" src="/static/zoomify.js"></script>
<script type="text/javascript">
	var fromBank = "";
	var toBank = "";
   	$(function(){
   		<c:if test="${task.name == '垫付账户放款' || task.name == '借款账户放款' || task.name == '归还垫付款' || task.name == '缴纳保证金' || task.name == '供应商还款' || task.name == '退还保证金'}">
   			initCombogridData();
   			initCombogrid();
		</c:if>
   		$('#mann_ul').append($('#append_ul').html());
		$('#append_button').click(function(){
        	$('#mann_ul').append($('#append_ul').html());
        });
        
        $('#remove_button').click(function(){
        	$('#mann_ul').append($('#append_ul').html());
        	initCombogrid();
        });
   		$('#commentForm').form({
            url : '/personalTask/transactTask',
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
                	parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                    loadTask();
                } else {
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
	    initImg();
   	});
   	
   	function initImg(){
		var travelBook = "${carLoanDetail.travelBook}".split(",");// 行驶本
		if(travelBook == 0){
			if("${carLoanDetail.travelBook}" != ''){
				$("#travelBook").append("<img src='${carLoanDetail.travelBook}' width='100px'>");
			}
		} else{
			for(var i in travelBook){
				$("#travelBook").append("<img src='" + travelBook[i] + "' width='100px'>");
			}
		}
		var idcardLicense = "${carLoanDetail.idcardLicense}".split(",");// 身份证  / 营业执照
		if(idcardLicense == 0){
			if("${carLoanDetail.idcardLicense}" != ''){
				$("#idcardLicense").append("<img src='${carLoanDetail.idcardLicense}' width='100px'>");
			}
		} else{
			for(var i in idcardLicense){
				$("#idcardLicense").append("<img src='" + idcardLicense[i] + "' width='100px'>");
			}
		}
		var vehicleEvaluationReport = "${carLoanDetail.vehicleEvaluationReport}".split(",");// 车辆评估报告
		if(vehicleEvaluationReport == 0){
			if("${carLoanDetail.vehicleEvaluationReport}" != ''){
				$("#vehicleEvaluationReport").append("<img src='${carLoanDetail.vehicleEvaluationReport}' width='100px'>");
			}
		} else{
			for(var i in vehicleEvaluationReport){
				$("#vehicleEvaluationReport").append("<img src='" + vehicleEvaluationReport[i] + "' width='100px'>");
			}
		}
		var loanAgreement = "${carLoanDetail.loanAgreement}".split(",");// 委托借款协议
		if(loanAgreement == 0){
			if("${carLoanDetail.loanAgreement}" != ''){
				$("#loanAgreement").append("<img src='${carLoanDetail.loanAgreement}' width='100px'>");
			}
		} else{
			for(var i in loanAgreement){
				$("#loanAgreement").append("<img src='" + loanAgreement[i] + "' width='100px'>");
			}
		}
		var vehicleCertificate = "${carLoanDetail.vehicleCertificate}".split(",");// 机动车登记证
		if(vehicleCertificate == 0){
			if("${carLoanDetail.vehicleCertificate}" != ''){
				$("#vehicleCertificate").append("<img src='${carLoanDetail.vehicleCertificate}' width='100px'>");
			}
		} else{
			for(var i in vehicleCertificate){
				$("#vehicleCertificate").append("<img src='" + vehicleCertificate[i] + "' width='100px'>");
			}
		}
		var vehicleTaxCertificate = "${carLoanDetail.vehicleTaxCertificate}".split(",");// 车辆购置完税证明
		if(vehicleTaxCertificate == 0){
			if("${carLoanDetail.vehicleTaxCertificate}" != ''){
				$("#vehicleTaxCertificate").append("<img src='${carLoanDetail.vehicleTaxCertificate}' width='100px'>");
			}
		} else{
			for(var i in vehicleTaxCertificate){
				$("#vehicleTaxCertificate").append("<img src='" + vehicleTaxCertificate[i] + "' width='100px'>");
			}
		}
		var vehicalInvoice = "${carLoanDetail.vehicalInvoice}".split(",");// 车辆发票
		if(vehicalInvoice == 0){
			if("${carLoanDetail.vehicalInvoice}" != ''){
				$("#vehicalInvoice").append("<img src='${carLoanDetail.vehicalInvoice}' width='100px'>");
			}
		} else{
			for(var i in idcardLicense){
				$("#vehicalInvoice").append("<img src='" + vehicalInvoice[i] + "' width='100px'>");
			}
		}
		var vehicalPhoto = "${carLoanDetail.vehicalPhoto}".split(",");// 车辆照片
		if(vehicalPhoto == 0){
			if("${carLoanDetail.vehicalPhoto}" != ''){
				$("#vehicalPhoto").append("<img src='${carLoanDetail.vehicalPhoto}' width='100px'>");
			}
		} else{
			for(var i in vehicalPhoto){
				$("#vehicalPhoto").append("<img src='" + vehicalPhoto[i] + "' width='100px'>");
			}
		}
		var loanContract = "${carLoanDetail.loanContract}".split(",");// 借款合同
		if(loanContract == 0){
			if("${carLoanDetail.loanContract}" != ''){
				$("#loanContract").append("<img src='${carLoanDetail.loanContract}' width='100px'>");
			}
		} else{
			for(var i in loanContract){
				$("#loanContract").append("<img src='" + loanContract[i] + "' width='100px'>");
			}
		}
		var iou = "${carLoanDetail.iou}".split(",");// 借条
		if(iou == 0){
			if("${carLoanDetail.iou}" != ''){
				$("#iou").append("<img src='${carLoanDetail.iou}' width='100px'>");
			}
		} else{
			for(var i in iou){
				$("#iou").append("<img src='" + iou[i] + "' width='100px'>");
			}
		}
		var capitalRequirement = "${carLoanDetail.capitalRequirement}".split(",");// 资金需求表
		if(capitalRequirement == 0){
			if("${carLoanDetail.capitalRequirement}" != ''){
				$("#capitalRequirement").append("<img src='${carLoanDetail.capitalRequirement}' width='100px'>");
			}
		} else{
			for(var i in capitalRequirement){
				$("#capitalRequirement").append("<img src='" + capitalRequirement[i] + "' width='100px'>");
			}
		}
		var policy = "${carLoanDetail.policy}".split(",");// 保单
		if(policy == 0){
			if("${carLoanDetail.policy}" != ''){
				$("#policy").append("<img src='${carLoanDetail.policy}' width='100px'>");
			}
		} else{
			for(var i in policy){
				$("#policy").append("<img src='" + policy[i] + "' width='100px'>");
			}
		}
		var vehicleInventory = "${carLoanDetail.vehicleInventory}".split(",");// 机动车封存清单
		if(policy == 0){
			if("${carLoanDetail.vehicleInventory}" != ''){
				$("#vehicleInventory").append("<img src='${carLoanDetail.vehicleInventory}' width='100px'>");
			}
		} else{
			for(var i in vehicleInventory){
				$("#vehicleInventory").append("<img src='" + vehicleInventory[i] + "' width='100px'>");
			}
		}
		// 点击放大
		$("img").zoomify();
	}
   	
  	//预览图片
   	function showLocalImage(){
   		var pics = $("#evidence")[0];
   		var previewDiv = $("#evidenceImg");
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
   	function reselect(){
   		$("#evidence").val("");
   		$("#evidenceImg").empty();
   	}
   	
   	function doSubmit(val){
   		if(val == '发布'){
    		if('${carLoanDetail.productId}' == ''){
    			$.messager.alert('提示','请先发布产品！','info');
    			return;
    		}
    	}
    	if(val == '不发布'){
    		if('${carLoanDetail.productId}' != ''){
    			$.messager.alert('提示','已发布产品，请点击发布按钮','info');
    			return;
    		}
    	}
   		$("#outcome").val(val);
   		var msg = '确认办理任务';
   		if(val == '通过'){
   			msg = '确认通过吗';
   		}else if(val == '拒绝'){
   			msg = '确认拒绝吗？拒绝后流程结束';
   		}else if(val == '驳回'){
   			msg = '确认驳回吗？驳回后需要申请人修改申请';
   		}else if(val == '发布'){
   			msg = '确认发布产品吗？';
   		}else if(val == '不发布'){
   			msg = '确认不发布产品吗？';
   		}
   		$.messager.confirm('确认',msg,function(r){    
		    if (r){
		    	$("#commentForm").submit();
		    }    
		}); 
   	}
   	function loadTask(){
   		$.get('/personalTask/loadTask',{},function(result){
   			if(result > 0){
   				$("#msg").html(result);
   			}else{
   				$("#msg").html(0);
   			}
   		},'json');
   	}
   	function showVoucher(urls){
    	$('#voucherWin').empty();
    	$('#voucherWin').window('open');
    	var urlArray = urls.split(",");
    	if(urlArray.length == 1){
    		$("#voucherWin").append("<img src='" + urlArray[0] + "' width='100px'>");
    	}else{
    		for(var i in urlArray){
				$("#voucherWin").append("<img src='" + urlArray[i] + "' width='100px'>");
			}
    	}
    	$("img").zoomify();
    }
   	
   	function deleteInput(ele){
		if($("#mann_ul").children().size() == 1){
			$.messager.alert('提示','必须输入一条数据','info');
			return;
		}
   		$(ele).parent().remove();
   	}
   	
	function initCombogridData(){
		$.ajax({
			async: false,
            type:"POST",
            url:"/personalTask/fromBankInfoList",
            data:{
            	"carLoanId" : "${carLoanDetail.id}",                                
        		"taskName" : "${task.name}"},
        	dataType: "json",
            success:function(data){
            	fromBank = data;
            }        
         });
		
		$.ajax({
			async: false,
            type:"POST",
            url:"/personalTask/toBankInfoList",
            data:{
            	"carLoanId" : "${carLoanDetail.id}",                                
        		"taskName" : "${task.name}"},
            dataType: "json",
            success:function(data){
            	toBank = data;
            }        
         });
	}
	
	function initCombogrid(){
		//var fromBank = "";
		//var toBank = "";
		//append_ul
		for (var i = 0; i < fromBank.length; i++) {
			$('#fromAccount').append('<option value="'+fromBank[i].id+'">'+fromBank[i].typeName + '--' + fromBank[i].accountName + '--' + fromBank[i].bank + '</option>');
		}
		
		for (var i = 0; i < toBank.length; i++) {
			$('#toAccount').append('<option value="'+toBank[i].id+'">'+toBank[i].typeName + '--' + toBank[i].accountName + '--' + toBank[i].bank + '</option>');
		}
	}
	
	function verifyMoney(e){
		if(!verifyNumber(e.value)){
			$.messager.alert('提示','请输入数字！','info');
			e.value = '';
		}
	}
</script>
<style>
</style>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow-y: scroll;padding: 3px;" >
       	<div class="center_title"><span>车辆基本信息</span></div>
        <table class="grid">
            <tr>
                <th>车牌号</th>
                <td>${carLoanDetail.plateNumber}</td>
                <th>车辆型号</th>
                <td>${carLoanDetail.vehicleType}</td>
            </tr>
            <tr>
            	<th >是否运营</th>
                <td >
               		<c:if test="${carLoanDetail.whetherOperation == 0}">否</c:if>
               		<c:if test="${carLoanDetail.whetherOperation == 1}">是</c:if>
                </td>
                <th >车辆年限</th>
                <td >${carLoanDetail.vehicleLife}&nbsp;&nbsp;&nbsp;月</td>
            </tr>
            <tr>
                <th>车辆所属</th>
                <td>
                	<c:if test="${carLoanDetail.vehicleOwnership == 1}">个人</c:if>
                	<c:if test="${carLoanDetail.vehicleOwnership == 2}">公司</c:if>
                </td>
                <th>车主姓名</th>
                <td>${carLoanDetail.ownerName}</td>
            </tr>
            <tr>
            	<th >行驶公里数</th>
                <td colspan="3">${carLoanDetail.kilometers}&nbsp;&nbsp;&nbsp;公里</td>
            </tr>
        </table>
        <div class="center_title"><span>借款信息</span></div>
        <table class="grid">
        	<tr>
                <th >借款金额</th>
                <td >${carLoanDetail.loanAmount}&nbsp;&nbsp;&nbsp;元</td>
                <th >借款期限</th>
                <td >${carLoanDetail.loanTerm}&nbsp;&nbsp;&nbsp;天</td>
            </tr>
            <tr>
            	<th >利息</th>
                <td >${carLoanDetail.rate}&nbsp;&nbsp;&nbsp;%</td>
                <th >抵押方式</th>
                <td >
               		<c:if test="${carLoanDetail.singleDoubleCharge == 1}">单押</c:if>
               		<c:if test="${carLoanDetail.singleDoubleCharge == 2}">双押</c:if>
                </td>
            </tr>
            <tr>
            	<th >是否一抵押</th>
                <td >
               		<c:if test="${carLoanDetail.dollarsNumber == 1}">一抵押</c:if>
               		<c:if test="${carLoanDetail.dollarsNumber == 2}">二抵押</c:if>
                </td>
                <th >上一抵押人</th>
                <td >${carLoanDetail.oneDollarsName}</td>
            </tr>
            <tr>
            	<th >预计还款金额</th>
                <td >${carLoanDetail.estRepAmount}&nbsp;&nbsp;&nbsp;元</td>
                <th >实际还款金额</th>
                <td >${carLoanDetail.actRepAmount}&nbsp;&nbsp;&nbsp;元</td>
            </tr>
        </table>
        
        <div class="center_title"><span>资料信息</span></div>
        <div>
        	<div class='cli'  style="border:1px solid #2679B5">
	        	<div class='cli_title'><span>行驶本</span></div>
	        	<div class='cli_image' id='travelBook' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #5FAA60">
	        	<div class='cli_title'><span>身份证/营业执照</span></div>
	        	<div class='cli_image' id='idcardLicense' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #CB6FD7">
	        	<div class='cli_title'><span>车辆评估报告</span></div>
	        	<div class='cli_image' id='vehicleEvaluationReport' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #D5595A">
	        	<div class='cli_title'><span>委托借款协议</span></div>
	        	<div class='cli_image' id='loanAgreement' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #F79263">
	        	<div class='cli_title'><span>机动车登记证</span></div>
	        	<div class='cli_image' id='vehicleCertificate' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #2679B5">
	        	<div class='cli_title'><span>车辆购置完税证明</span></div>
	        	<div class='cli_image' id='vehicleTaxCertificate' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #5FAA60">
	        	<div class='cli_title'><span>车辆发票</span></div>
	        	<div class='cli_image' id='vehicalInvoice' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #CB6FD7">
	        	<div class='cli_title'><span>车辆照片</span></div>
	        	<div class='cli_image' id='vehicalPhoto' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #D5595A">
	        	<div class='cli_title'><span>借款合同</span></div>
	        	<div class='cli_image' id='loanContract' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #9ABC32">
	        	<div class='cli_title'><span>借条</span></div>
	        	<div class='cli_image' id='iou' ></div>
	        </div>
	        <div class='cli' style="border:1px solid #FFB752">
	        	<div class='cli_title'><span>资金需求表</span></div>
	        	<div class='cli_image' id='capitalRequirement' ></div>
	        </div>
        </div>
        
        <div class="center_title"><span>批注</span></div>
	    <div>
	    	<form id="commentForm" method="post" enctype="multipart/form-data">
	    		<input type="hidden" name="taskId" value="${task.id}">
	    		<input type="hidden" name="carLoanId" value="${carLoanDetail.id}">
	    		<input type="hidden" id="outcome" name="outcome">
	    		
	    		<div class='cli2'>
	    			<div class='cli_title'><span>批注信息</span></div>
	    			<div class='cli_pizu' style="margin-bottom: 10px;">
	    				<input id="commentMsg" name="commentMsg" class="easyui-textbox" data-options="multiline:true,required:true" style="width:610px;height:100px;background-color:#fff">
	    			</div>
	    			
	    			<!-- 涉及资金流动的任务，记录来往信息-->
	    			<c:if test="${task.name == '垫付账户放款' || task.name == '借款账户放款' || task.name == '归还垫付款' || task.name == '缴纳保证金' || task.name == '供应商还款' || task.name == '退还保证金'}">
	    				<div class='cli_title'><span>资金流向</span></div>
						<div class='cli_pizu'>
							<ul id='mann_ul'></ul>
							<div style="height:35px;">
							   <a href="javascript:void(0)" id='append_button' class="easyui-linkbutton" >添加记录</a>
							  <!--  <a href="javascript:void(0)" id='append_button' class='easyui-linkbutton' data-options="iconCls:'icon-add'" style="float:right">添加记录</a> -->
							</div>
						</div>
	    			</c:if>
	    			
	    			<div class='cli_title'><span>凭证图片</span></div>
	    			<div class='cli_pizu' style="min-height:30px;">
	    			   <div class="upload-box" style="float:left">
	    			   		<input id="evidence" name="evidence" type="file" onchange="showLocalImage();" multiple="multiple" accept="image/*">
	    					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	    			   </div>
	    				<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect();" style="float:left;margin-left:50px;">重新选择</a>
	    				<div id="evidenceImg"></div>
	    			</div>
	    			
	    			<div class='dono_button'>
		    			<c:forEach items="${outcomeList}" var="outcome">
		    				<!-- <c:if test="${carLoanDetail.productId != null && outcome == '不发布' || carLoanDetail.productId == null && outcome == '发布'}">disabled</c:if> -->
							<input type="button" onclick="doSubmit(this.value)" name="outcome" value="${outcome}" class="btn-dynamic" />
						</c:forEach>
	    			</div>
	    		</div>
	    	</form>
	    	
	    	
	    	<div class="center_title"><span>历史批注</span></div>
	    	
    		<c:if test="${commentList == null}">（暂无批注信息！）</c:if>
	    	<c:if test="${commentList != null}">
			    <table class="grid">
			    	<tr>
			    		<td width="380px">批注信息</td>
			    		<td>凭证</td>
			    		<td>批注人</td>
			    		<td>时间</td>
			    	</tr>
		    		<c:forEach items="${commentList}" var="comment">
			    		<tr>
				    		<td>${comment.message}</td>
				    		<td>
				    			<c:if test="${comment.voucher != null}">
					    			<a href="#" onclick="showVoucher('${comment.voucher}')">查看</a>
				    			</c:if>
				    		</td>
				    		<td>${comment.userName}</td>
			    			<td><fmt:formatDate value="${comment.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			    		</tr>
		    		</c:forEach>
			    </table>
	   		</c:if>
	    </div>
    </div>
</div>
<div id="voucherWin" class="easyui-window" title="凭证信息" data-options="closed:true"
	style="width: 520px; height: 400px; padding: 5px;">
</div>

<div  style="display: none;">
	<ul id='append_ul'>
		<li>
			<span>放款账户：</span>
			<select id="fromAccount" name="fromAccount" style="margin-right:10px;width:200px">
				<option value="">选择账号</option>	
			</select>
			<span>收款账户：</span>
			<select id="toAccount" name="toAccount" style="margin-right:10px;width:200px">
				<option value="">选择账号</option>	
			</select>
			<span>金额：</span><input name="money" onchange="verifyMoney(this)" style="margin-right:10px;width: 70px;" type="text">
			<a href="#" onclick="deleteInput(this)" class='easyui-linkbutton' >移除</a>
		</li>
	</ul>
</div>
