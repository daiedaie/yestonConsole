<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="/static/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript" src="/static/js/uploadImg.js"></script>
<link rel="stylesheet" type="text/css" href="/static/style/css/business.css" />
<style>
.grid input{
	height: 25px;
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
.box-images img{
  padding-left:5px;
}
</style>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<input type="hidden" id="dataid" value="${carLoanId}">
    <div id="upload_info" data-options="region:'center',border:false" title="" style="padding: 3px; overflow-y: scroll;" >
    <div style="color: red;height: 30px;line-height: 20px;">注：上传多张图片时，在选择文件窗口中选择多张图片，每张图片最大500KB</div>
    <!-- 行驶本 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">行驶本</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="travelBook" class="travelBook" name="travelBook" type="file" onchange="showLocalImage('travelBook');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('travelBook')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('travelBook');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="travelBook box-images"></div>
    <!-- 身份证  / 营业执照 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">身份证  / 营业执照</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="idcardLicense" class="idcardLicense" name="idcardLicense" type="file" onchange="showLocalImage('idcardLicense');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('idcardLicense')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('idcardLicense');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="idcardLicense box-images"></div>
    <!-- 车辆评估报告 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">车辆评估报告</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicleEvaluationReport" class="vehicleEvaluationReport" name="vehicleEvaluationReport" type="file" onchange="showLocalImage('vehicleEvaluationReport');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicleEvaluationReport')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleEvaluationReport');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicleEvaluationReport box-images"></div>
    <!-- 委托借款协议 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">委托借款协议</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="loanAgreement" class="loanAgreement" name="loanAgreement" type="file" onchange="showLocalImage('loanAgreement');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('loanAgreement')">上传</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('loanAgreement');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="loanAgreement box-images"></div>
	<!-- 机动车登记证 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">机动车登记证</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicleCertificate" class="vehicleCertificate" name="vehicleCertificate" type="file" onchange="showLocalImage('vehicleCertificate');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicleCertificate')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleCertificate');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicleCertificate box-images"></div>
    <!-- 车辆购置完税证明 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">车辆购置完税证明</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicleTaxCertificate" class="vehicleTaxCertificate" name="vehicleTaxCertificate" type="file" onchange="showLocalImage('vehicleTaxCertificate');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicleTaxCertificate')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleTaxCertificate');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicleTaxCertificate box-images"></div>
    <!-- 车辆发票 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">车辆发票</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicalInvoice" class="vehicalInvoice" name="vehicalInvoice" type="file" onchange="showLocalImage('vehicalInvoice');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicalInvoice')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicalInvoice');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicalInvoice box-images"></div>
    <!-- 车辆照片 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">车辆照片</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicalPhoto" class="vehicalPhoto" name="vehicalPhoto" type="file" onchange="showLocalImage('vehicalPhoto');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicalPhoto')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicalPhoto');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicalPhoto box-images"></div>
    <!-- 借款合同 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">借款合同</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="loanContract" class="loanContract" name="loanContract" type="file" onchange="showLocalImage('loanContract');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('loanContract')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('loanContract');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="loanContract box-images"></div>
    <!-- 借条 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">借条</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="iou" class="iou" name="iou" type="file" onchange="showLocalImage('iou');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('iou')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('iou');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="iou box-images"></div>
    <!-- 资金需求表 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">资金需求表</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="capitalRequirement" class="capitalRequirement" name="capitalRequirement" type="file" onchange="showLocalImage('capitalRequirement');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('capitalRequirement')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('capitalRequirement');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="capitalRequirement box-images"></div>
    <!-- 保单 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">保单</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="policy" class="policy" name="policy" type="file" onchange="showLocalImage('policy');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('policy')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('policy');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="policy box-images"></div>
    <!-- 机动车封存清单 -->
         <table class="grid">
             <tr align="center">
                 <td width="150px">机动车封存清单</td>
                 <td colspan="3">
                 	<div class="upload-box" style="float:left;margin-left:20px;margin-right:100px;">
	   			   		<input id="vehicleInventory" class="vehicleInventory" name="vehicleInventory" type="file" onchange="showLocalImage('vehicleInventory');" multiple="multiple">
	   					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-images'">选择文件</a>
	   			    </div>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="upload('vehicleInventory')">上传</a>
                 	<a class="easyui-linkbutton" data-options="iconCls:'icon-refresh'" href="javascript:reselect('vehicleInventory');" >重新选择</a>  
                 </td>
             </tr>
         </table>
         <div class="vehicleInventory box-images"></div>
    </div>
</div>