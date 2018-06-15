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
.grid th {
    background: none repeat scroll 0 0 #f7f7f7;
    color:#707070
}
.cli_image{padding-left:5px;}
</style>
<script type="text/javascript" src="/static/zoomify.js"></script>
<script type="text/javascript">
   	$(function(){
	    initImg();
	    $('#moneyFlowGrid').datagrid({
 				url : '/business/moneyFlowData',
 				striped : true,
 	            rownumbers : true,
 	            pagination : true,
 	            singleSelect : true,
 	            pageSize : 5,
 	            pageList : [ 5, 10 ],
 				queryParams : {
 					carLoanId : '${carLoanDetail.id}'
 				},
 				columns : [ [
						{
 							width : '168',
 							title : '放款账户',
 							align : 'center',
 							field : 'fromAccountName'
 						},{
 							width : '80',
 							title : '放款账户银行',
 							align : 'center',
 							field : 'fromAccountBankName'
 						},{
 							width : '168',
 							title : '收款账户',
 							align : 'center',
 							field : 'toAccountName'
 						},{
 							width : '80',
 							title : '收款账户银行',
 							align : 'center',
 							field : 'toAccountBankName'
 						},{
 							width : '90',
 							title : '放款金额',
 							align : 'center',
 							field : 'money'
 						},{
 							width : '140',
 							title : '放款时间',
 							align : 'center',
 							field : 'addTime'
 				}] ]			
 		});
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
		$("img").zoomify();
	}
   	
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow-y:scroll;padding: 3px;" >
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
                <td >${carLoanDetail.vehicleLife}个月</td>
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
                <th>行驶公里数</th>
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
                    <th >利率</th>
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
        <div class='cli' style="border:1px solid #2679B5">
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
        <div class="center_title"><span>资金流向</span></div>
		<table id="moneyFlowGrid" data-options="border:false"></table>        
    </div>
</div>
