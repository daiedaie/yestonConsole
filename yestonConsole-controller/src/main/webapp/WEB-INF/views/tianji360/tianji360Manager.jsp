<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp"%>
<title>天机360管理</title>
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="stylesheet" type="text/css" href="/static/style/css/echoapi.css" />
<style type="text/css">
.panel-header, .my-easyui-panel {
	border: 1px solid #95B8E7;
}

.panel-header {
	border-bottom: 0;
	background: #95B8E7;
}

.panel-title {
	margin-left: 5px;
}
</style>
<script type="text/javascript" src="/static/zoomify.js"></script>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		searchList();		
		$(":checkbox").click(function(){
			if ($(this).val() == "tianji.api.kaola.bankcard4item" && $(this).is(":checked")) {
				alert($(this).val());
				$('#bankCard').attr("required", "required");
			} else {
				$('#bankCard').removeAttr("required", "required");
			}
		});
	});
	
	function searchList(){
		var name = $("#name").val();
		var idNumber = $("#idNumber").val();
		var phone = $("#phone").val();
		var bankCard = $("#bankCard").val();
		var method = []; 
        $('input:checkbox:checked').each(function() {
        	if ($(this).val() == "tianji.api.kaola.bankcard4item" && (null == bankCard || bankCard.trim() == "")) {
        		$.messager.alert('错误', '银行卡号不能为空', 'error');
        		return false;
        	} else {
	        	method.push($(this).val());
        	}
        });
	   
		dataGrid = $('#dataGrid').datagrid({
			url : '/tianji360/saveRong360BaseData',
			queryParams:{
				methods : method.toString(),
				name : name,
				idNumber : idNumber,
				phone : phone,
				bankCard : bankCard
			},
			traditional : true,
			striped : true,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			selectOnCheck:false,
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			onLoadSuccess: function(data) {
				if (data.code != 200) {
					$.messager.alert('错误', data.msg, 'error');
					return false;
				}
			},
			columns : [ [
					{ width : '150', align : 'center', title : 'id', field : 'id' },
					{ width : '100', align : 'center', title : '姓名', field : 'name' },
					{ width : '150', align : 'center', title : '身份证号', field : 'idNumber' },
					{ width : '120', align : 'center', title : '手机号', field : 'phone' },
					{ width : '80', align : 'center', title : '状态', field : 'status' },					
					{ width : '150', align : 'center', title : '查询时间', field : 'createDate' },
					{ field : 'opt', title : '操作', width : '100', align : 'center',
						formatter : function(value, rec, index) {
							if (rec.status == 1) {
								return '<a href="#" onclick="searchResult(\''+rec.id+'\');">查看结果</a>';
							} else {
								return '<a disabled="true">查看结果</a>';
							}
						}
					},
					{ width : '180', align : 'center', title : '查询类型', field : 'methodName' }				
			] ]
		});
	}
	
	function searchResult(id) {
		$.ajax({
			url : '/tianji360/getInfoList',
			type : 'POST',
			data : {
				'id' : id
			},
			dataType : 'json',
			success: function(data) {
			    if (data.code == 200) {
			    	var result = data.obj;
			    	if (result.length > 0) {
			    		for (var i = 0; i < result.length; i++) {
			    			var objList = result[i];
			    			if (objList.length > 0) {
			    				var html = "";
			    				for (var j = 0; j < objList.length; j++) {
			    					var obj = objList[j];
			    					switch (obj.method) {
			    					case "tianji.api.rong360.sdk": // 融360抓取服务
			    						break;
			    					case "tianji.api.baidu.blacklist": // 黑名单-百度
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.type+"</td>";
			    						html += "<td>"+obj.desc+"</td>";
			    						html += "<td>"+obj.blackReason+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody1").empty();
			    						$("#tbody1").append(html);
			    						break;
			    					case "tianji.api.agentr.blacklist": // 黑名单-机构R
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.feature1+"</td>";
			    						html += "<td>"+obj.feature2+"</td>";
			    						html += "<td>"+obj.feature3+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody2").empty();
			    						$("#tbody2").append(html);
			    						break;
			    					case "tianji.api.xinyan.blacklist": // 黑名单-新颜征信
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.code+"</td>";
			    						html += "<td>"+obj.desc+"</td>";
			    						html += "<td>"+obj.maxOverdueAmt+"</td>";
			    						html += "<td>"+obj.maxOverdueDays+"</td>";
			    						html += "<td>"+obj.latestOverdueTime+"</td>";
			    						html += "<td>"+obj.currentlyOverdue+"</td>";
			    						html += "<td>"+obj.currentlyPerformance+"</td>";
			    						html += "<td>"+obj.accExc+"</td>";
			    						html += "<td>"+obj.accSleep+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody3").empty();
			    						$("#tbody3").append(html);
			    						break;
			    					case "tianji.api.fahai.lawblacklist": // 灰名单-法海法律
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.type+"</td>";
			    						html += "<td>"+obj.date+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody4").empty();
			    						$("#tbody4").append(html);
			    						break;
			    					case "tianji.api.fahai.blacklistdetail": // 灰名单-法海涉诉详情
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.type+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody5").empty();
			    						$("#tbody5").append(html);
			    						break;
			    					case "tianji.api.fahai.keywordsearch": // 灰名单-法海法律（企业相关）
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.type+"</td>";
			    						html += "<td>"+obj.date+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody6").empty();
			    						$("#tbody6").append(html);
			    						break;
			    					case "tianji.api.faceplus.getrandomnumber": // FACE++-获取随机数-H5
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.randomNumber+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody7").empty();
			    						$("#tbody7").append(html);
			    						break;
			    					case "tianji.api.faceplus.validatevideo": // FACE++-自拍视频的活体验证-H5
			    						break;
			    					case "tianji.api.kaola.bankcard4item": // 身份验证-考拉征信
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.bankCard+"</td>";
			    						var status = "";
			    						if(obj.checkStatus == 'S'){
			    							status = "一致";
										}else if (obj.checkStatus == 'F') {
											status = "不一致";
										}else {
											status = "U未知，数据源没有覆盖到";
										}
			    						html += "<td>"+status+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody8").empty();
			    						$("#tbody8").append(html);
			    						break;
			    					case "tianji.api.pengyuan.mobilecheck3item": // 身份验证-机构c
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						var status = "";
			    						if(obj.checkStatus == 'S'){
			    							status = "一致";
										} else if (value == 'F') {
											status = "不一致";
										} else {
											status = "U未知，数据源没有覆盖到";
										}
			    						html += "<td>"+status+"</td>";
			    						html += "<td>"+obj.nameCheckResult+"</td>";
			    						html += "<td>"+obj.documentNoCheckResult+"</td>";
			    						html += "<td>"+obj.phoneCheckResult+"</td>";
			    						html += "<td>"+obj.areaInfo+"</td>";
			    						var operator = "";
			    						if(obj.operator == 1){
			    							operator = "中国电信";
										} else if (obj.operator == 2) {
											operator = "中国移动";
										} else {
											operator = "中国联通";
										}
			    						html += "<td>"+operator+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody9").empty();
			    						$("#tbody9").append(html);
			    						break;
			    					case "tianji.api.jiao.phonestatus": // 身份查询-机构k手机状态
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						var status = "";
			    						if(obj.checkStatus == 'S'){
			    							status = "一致";
										} else if (obj.checkStatus == 'F') {
											status = "不一致";
										} else {
											status = "U未知，数据源没有覆盖到";
										}
			    						html += "<td>"+status+"</td>";
			    						html += "<td>"+obj.province+"</td>";
			    						html += "<td>"+obj.city+"</td>";
			    						html += "<td>"+obj.isp+"</td>";
			    						html += "<td>"+obj.desc+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody10").empty();
			    						$("#tbody10").append(html);
			    						break;
			    					case "tianji.api.jiao.phonenetworklength": // 身份查询-机构k手机号码在网时长
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.province+"</td>";
			    						html += "<td>"+obj.city+"</td>";
			    						html += "<td>"+obj.isp+"</td>";
			    						html += "<td>"+obj.desc+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody11").empty();
			    						$("#tbody11").append(html);
			    						break;
			    					case "tianji.api.jiao.phoneconsumption": // 身份查询-机构k手机消费档次
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						var status = "";
			    						if(obj.checkStatus == 'S'){
			    							status = "一致";
										} else if (obj.checkStatus == 'F') {
											status = "不一致";
										} else {
											status = "U未知，数据源没有覆盖到";
										}
			    						html += "<td>"+status+"</td>";
			    						html += "<td>"+obj.province+"</td>";
			    						html += "<td>"+obj.city+"</td>";
			    						html += "<td>"+obj.isp+"</td>";
			    						html += "<td>"+obj.desc+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody12").empty();
			    						$("#tbody12").append(html);
			    						break;
			    					case "tianji.api.bairong.icredit": // 外部信用报告-百融
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						var flagScore = "";
			    						if(obj.flagScore == 0	){
											return "未匹配上";
										} else if (obj.flagScore == 1) {
											return "输出成功";
										} else if (obj.flagScore == 99) {
											return "系统异常";
										} else {
											return "没有选择该报告或信息不充足";
										}
			    						html += "<td>"+flagScore+"</td>";
			    						html += "<td>"+obj.brcreditpoint+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody13").empty();
			    						$("#tbody13").append(html);
			    						break;
			    					case "tianji.api.jiguang.policy": // 反欺诈报告-极光
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						html += "<td>"+obj.CPL_AGE_LEVEL+"</td>";
			    						html += "<td>"+obj.CPL_SEX_LEVEL+"</td>";
			    						html += "<td>"+obj.CPL_DEVICE_LEVEL+"</td>";
			    						html += "<td>"+obj.CPL_CPS_LEVEL+"</td>";
			    						html += "<td>"+obj.SOM_RNI_RSI+"</td>";
			    						html += "<td>"+obj.FIM_NF_BCI2+"</td>";
			    						html += "<td>"+obj.FIM_NF_BCI3+"</td>";
			    						html += "<td>"+obj.FIM_NF_BPI+"</td>";
			    						html += "<td>"+obj.FIM_NF_BFI+"</td>";
			    						html += "<td>"+obj.FIM_NF_BSI+"</td>";
			    						html += "<td>"+obj.FIM_CC_BSI1+"</td>";
			    						html += "<td>"+obj.FIM_CC_BSI2+"</td>";
			    						html += "<td>"+obj.FIM_CC_BSI3+"</td>";
			    						html += "<td>"+obj.FIM_CC_BFI+"</td>";
			    						html += "<td>"+obj.FIM_PAY_BPI+"</td>";
			    						html += "<td>"+obj.FIM_PAY_BFI+"</td>";
			    						html += "<td>"+obj.GBM_TM_BSI+"</td>";
			    						html += "<td>"+obj.GBM_LH_BFI+"</td>";
			    						html += "<td>"+obj.GBM_SBH_HSI+"</td>";
			    						html += "<td>"+obj.GBM_CBH_HSI+"</td>";
			    						html += "<td>"+obj.createDate+"</td>";
			    						html += "</tr>";
			    						$("#tbody14").empty();
			    						$("#tbody14").append(html);
			    						break;
			    					case "tianji.api.umeng.score": // 特色报告-友盟+
			    						html += "<tr>";
			    						html += "<td>"+obj.name+"</td>";
			    						html += "<td>"+obj.idNumber+"</td>";
			    						html += "<td>"+obj.phone+"</td>";
			    						html += "<td>"+obj.methodName+"</td>";
			    						var devicePrice = "";
			    						if(obj.devicePrice == 1){
			    							devicePrice = "1000元以下";
										}else if (obj.devicePrice == 2) {
											devicePrice = "1000-2000元";
										}else if (obj.devicePrice == 3) {
											devicePrice = "2000-3000元";
										} else if (obj.devicePrice == 4) {
											devicePrice = "3000-4000元";
										} else if (obj.devicePrice == 5) {
											devicePrice = "4000元以上";
										}
			    						html += "<td>"+devicePrice+"</td>";
			    						html += "<td>"+obj.creditScore+"</td>";
			    						html += "<td>"+obj.idScore+"</td>";
			    						html += "<td>"+obj.deviceBrand+"</td>";
			    						html += "<td>"+obj.interestScore+"</td>";
			    						html += "<td>"+obj.locationScore+"</td>";
			    						html += "<td>"+obj.deviceRank+"</td>";
			    						html += "<td>"+obj.deviceOs+"</td>";
			    						html += "<td>"+obj.deviceScore+"</td>";
			    						html += "<td>"+obj.appScore+"</td>";
			    						html += "</tr>";
			    						$("#tbody15").empty();
			    						$("#tbody15").append(html);
			    						break;

									default:
										break;
									}
			    				}
			    			}
			    		}
			    	}
			    	$("#DivAdd").dialog('open');
					$("#DivAdd").dialog('setTitle','查询结果');
			    } else {
			    	$.messager.alert('错误', data.msg, 'error');
			    }
			},
			error: function(data) {}
		});
		
	}
	
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div class="queryButton" data-options="region:'north',border:false" style="margin-bottom: 10px; width: 100%; height: 180px; padding: 10px;">
		<form id="searchForm">
			<div id="d1">
				<span class="query_title">姓名</span><input id="name"
					class="easyui-textbox" name="name" style="width: 100px" required="true">
				<span class="query_title">身份证号</span><input id="idNumber"
					class="easyui-textbox" name="idNumber" style="width: 150px" required="true">
				<span class="query_title">手机号</span><input id="phone"
					class="easyui-textbox" name="phone" style="width: 150px" required="true">
				<span class="query_title">银行卡号</span><input id="bankCard"
					class="easyui-textbox" name="bankCard" style="width: 150px">
			</div>
			<div style="margin:10px 0;">
				<input type="checkbox" value="tianji.api.baidu.blacklist">黑名单-百度</input>
			    <input type="checkbox" value="tianji.api.agentr.blacklist">黑名单-机构R</input>
			    <input type="checkbox" value="tianji.api.xinyan.blacklist">黑名单-新颜征信</input>
			    <input type="checkbox" value="tianji.api.fahai.lawblacklist">灰名单-法海法律</input>
			    <input type="checkbox" value="tianji.api.fahai.blacklistdetail">灰名单-法海涉诉详情</input>
			    <input type="checkbox" value="tianji.api.fahai.keywordsearch">灰名单-法海法律（企业相关）</input>
		    </div>
			<div style="margin:10px 0;">
				<input type="checkbox" value="tianji.api.faceplus.getrandomnumber">FACE++-获取随机数-H5</input>
			    <input type="checkbox" value="tianji.api.kaola.bankcard4item">身份验证-考拉征信</input>
			    <input type="checkbox" value="tianji.api.pengyuan.mobilecheck3item">身份验证-机构c</input>
			    <input type="checkbox" value="tianji.api.jiao.phonestatus">身份查询-机构k手机状态</input>
			    <input type="checkbox" value="tianji.api.jiao.phonenetworklength">身份查询-机构k手机号码在网时长</input>
			    <input type="checkbox" value="tianji.api.jiao.phoneconsumption">身份查询-机构k手机消费档次</input>
		    </div>
			<div style="margin:10px 0;">
				<input type="checkbox" value="tianji.api.bairong.icredit">外部信用报告-百融</input>
			    <input type="checkbox" value="tianji.api.jiguang.policy">反欺诈报告-极光</input>
			    <input type="checkbox" value="tianji.api.umeng.score">特色报告-友盟+</input>
		    </div>
			<div>
				<a href="javascript:void(0);" class="easyui-linkbutton" 
					data-options="iconCls:'icon-search'" onclick="searchList();">查询列表</a>
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false"
		style="width: 550px; height: 350px; overflow: hidden;">
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	
	<!-- 添加弹出层 -->
	<div id="DivAdd" class="easyui-dialog" style="width: 70%; height: 80%; padding: 10px 20px" closed="true" resizable="true" modal="true"
		data-options="buttons: '#dlg-buttons'">
		<form id="ffAdd" method="post" novalidate="novalidate" enctype="multipart/form-data">
			<table class="view">
				<tr>
					<thead>
						<tr><h3>黑名单-百度：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>黑名单类型</th>
	                        <th>黑名单等级</th>
	                        <th>黑名单原因</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody1">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>黑名单-机构R：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>业务字段1</th>
	                        <th>业务字段2</th>
	                        <th>业务字段3</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody2">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>黑名单-新颜征信：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>查询结果码</th>
	                        <th>查询结果描述</th>
	                        <th>最大逾期金额</th>
	                        <th>最长逾期天数</th>
	                        <th>最近预期时间</th>
	                        <th>当前逾期机构数</th>
	                        <th>当前履约机构数</th>
	                        <th>异常还款机构数</th>
	                        <th>睡眠机构数</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody3">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>灰名单-法海法律：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>黑名单类型</th>
	                        <th>时间</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody4">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>灰名单-法海涉诉详情：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>黑名单类型</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody5">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>灰名单-法海法律（企业相关）：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>黑名单类型</th>
	                        <th>时间</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody6">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>FACE++-获取随机数-H5：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>四位随机数</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody7">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>身份验证-考拉征信：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>银行卡号</th>
	                        <th>是否一致</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody8">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>身份验证-机构c：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>是否一致</th>
	                        <th>姓名查询结果</th>
	                        <th>身份证查询结果</th>
	                        <th>手机号查询结果</th>
	                        <th>地区信息</th>
	                        <th>运营商</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody9">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>身份查询-机构k手机状态：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>是否一致</th>
	                        <th>省</th>
	                        <th>城市</th>
	                        <th>运营商</th>
	                        <th>返回信息</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody10">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>身份查询-机构k手机号码在网时长：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>省</th>
	                        <th>城市</th>
	                        <th>运营商</th>
	                        <th>返回信息</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody11">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>身份查询-机构k手机消费档次：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>是否一致</th>
	                        <th>省</th>
	                        <th>城市</th>
	                        <th>运营商</th>
	                        <th>返回信息</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody12">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>外部信用报告-百融：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>查询状态</th>
	                        <th>百融征信评分</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody13">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>反欺诈报告-极光：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>行为年龄水平</th>
	                        <th>行为性别水平</th>
	                        <th>设备价值水平指数</th>
	                        <th>客户触达稳定指数</th>
	                        <th>风险人群关联指数</th>
	                        <th>互金业务关注指数2</th>
	                        <th>互金业务关注指数3</th>
	                        <th>互金业务偏好指数</th>
	                        <th>互金业务频度指数</th>
	                        <th>互金业务强度指数</th>
	                        <th>信用消费规模指数1</th>
	                        <th>信用消费规模指数2</th>
	                        <th>信用消费规模指数3</th>
	                        <th>信用消费频度指数</th>
	                        <th>支付行为偏好指数</th>
	                        <th>支付行为频度指数</th>
	                        <th>出行方式规模指数</th>
	                        <th>生活服务频度指数</th>
	                        <th>特定行为规模指数</th>
	                        <th>一般行为规模指数</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody14">
                    
                    </tbody>
				</tr>
			</table>
			<table class="view">
				<tr>
					<thead>
						<tr><h3>特色报告-友盟+：</h3></tr>
	                    <tr>
	                        <th>姓名</th>
	                        <th>身份证号</th>
	                        <th>手机号</th>
	                        <th>查询类型</th>
	                        <th>设备价格</th>
	                        <th>综合风控评分</th>
	                        <th>idmmapping评分</th>
	                        <th>设备品牌</th>
	                        <th>兴趣偏好分</th>
	                        <th>地理分</th>
	                        <th>设备质量等级</th>
	                        <th>操作系统</th>
	                        <th>设备基本信息分</th>
	                        <th>app评分</th>
	                        <th>查询时间</th>
	                    </tr>
                    </thead>
                    <tbody id="tbody15">
                    
                    </tbody>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

