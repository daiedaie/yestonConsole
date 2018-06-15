<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp"%>
<title>个人信用信息管理</title>
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
	});
	
	function shareToEcho(){
		$("#showqueryInfo").html("");
		var row = $('#dataGrid').datagrid('getChecked');
		
		if(row == null || row == ""){
			$("#queryInfoErrWin").window("open");
			$("#queryInfoErrWin span").html("请选择要分享的数据");
			return false;
		}
		
		var arr = new Array();
		for (var i = 0; i < row.length; i++) {
			arr[i] = row[i].id_no;
			if(row[i].share == 1){
				$("#queryInfoErrWin").window("open");
				$("#queryInfoErrWin span").html("选择的数据中包含已分享的数据.");
				return false;
			}
		}
		
		$.ajax({
			async : false,
			type:"POST",
			url : "/echoApi/shareIdNo",
			data : {
				idNo : arr.join(",")
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if(!data.success){
					$("#queryInfoErrWin").window("open");
					$("#queryInfoErrWin span").html(data.msg);
					return false;
				}
				
				var obj = data.obj;
				var resData = obj.data;
				$("#queryInfoSucWin").window("open");
				
				var showHtml = "<table class='easyui-datagrid table-box' >";
				showHtml += "<tr><td>业务类型编号</td><td>" +  obj.tx + "</td></tr>";
				showHtml += "<tr><td>错误码</td><td>" +  obj.errorCode + "</td></tr>";
				showHtml += "<tr><td>错误信息</td><td>" +  obj.message + "</td></tr>";
				showHtml += "<tr><td>总上传的证件号码数</td><td>" +  resData.totalUploadCount + "</td></tr>";
				showHtml += "<tr><td>实际上传的号码数</td><td>" +  resData.uploadedIdNoCount + "</td></tr>";
				showHtml += "<tr><td>无效的证件号码数</td><td>" +  resData.invalidIdNoCount + "</td></tr>";
				showHtml += "<tr><td>无效的证件号</td><td>" +  resData.existingIdNoCount + "</td></tr>";
				showHtml += "<tr><td>已存在的证件号码数</td><td>" +  resData.existingIdNos + "</td></tr>";
				showHtml += "<tr><td>已存在的证件号码</td><td>" +  resData.existingIdNos + "</td></tr>";
				showHtml += "<tr><td>获取的积分</td><td>" +  resData.pointsGot + "</td></tr>";
				showHtml += "</table>";
				$("#showqueryInfo").html(showHtml);
			}
		});
	}
	
	function clearQueryWher(){
		$("#personal").textbox('setValue','');
		$("#idCNo").textbox('setValue','');
		searchList();
	}
	
	function searchList(){
		dataGrid = $('#dataGrid').datagrid(
			{
				url : '/echoApi/dataGrid',
				queryParams:{
					name : $("#personal").val(),
					idNo : $("#idCNo").val()
				},
				striped : true,
				rownumbers : true,
				pagination : true,
				selectOnCheck:false,
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				columns : [ [
						{ width : '50', field:'ck', checkbox:true},
						{ width : '150', align : 'center', title : '身份证号', field : 'id_no' },
						{ width : '80', align : 'center', title : '姓名', field : 'persional_name' },
						{ width : '150', align : 'center', title : '创建时间', field : 'create_time' },
						{ width : '150', align : 'center', title : '最后一次查询时间', field : 'last_query_time' },
						{ width : '80', align : 'center', title : '分享给平台', field : 'share', 
							formatter:function(value, row, index){
								if(value == 0){
									return "未分享";
								}else{
									return "已分享";
								}
							}
						},
						{ field : 'opt', title : '操作', width : '80', align : 'center',
							formatter : function(value, rec, index) {
								return '<a href="#" onclick="queryHistory(' + index + ')">查询历史</a>';
							}
						} 
				] ]
			});
	}

	function queryHistory(index) {
		var data = $('#dataGrid').datagrid("getRows")[index];
		$.ajax({
			async : false,
			type:"POST",
			url : "/echoApi/queryHistory",
			data : {
				"idNo" : data.id_no
			},
			dataType : "json",
			success : function(data) {
				if (data.success) {
					$("#queryHistoryWin").window("open");
					showQueryHistory(data.obj);
				} else {
					$("#queryInfoErrWin").window("open");
					$("#queryInfoErrWin span").html(data.msg);
				}
			}
		});
	}

	function showQueryHistory(dataobj) {
		
		var pch = dataobj.personalCreditHistory;
		var mortd = dataobj.mortgagorData;
		var riskList = dataobj.riskList;
		var showHtml = "<table class='easyui-datagrid table-box' ><thead><tr><th>序号</th><th>查询时间</th><th>数据来源</th><th>致诚信用分</th><th>违约概率</th></tr></thead><tbody>";
		for (var i = 0; i < pch.length; i++) {
			var obj = pch[i];
			showHtml += "<tr>";
			showHtml += "<td>" + (i + 1) + "</td>";
			showHtml += "<td>" + obj.query_time + "</td>";
			showHtml += "<td>" + obj.source_info + "</td>";
			showHtml += "<td>" + obj.zcCreditScore + "</td>";
			showHtml += "<td>" + obj.contractBreakRate + "</td>";
			showHtml += "</tr>";
		}
		showHtml += "</tbody></table>";
		
		showHtml += "<table class='easyui-datagrid  table-box'><thead><tr> " +
		"<th>序号</th><th>借款时间</th><th>期数</th><th>借款金额</th><th>审批结果码</th>" +
		"<th>还款状态码</th><th>借款类型码</th><th>逾期金额</th><th>逾期情况</th><th>历史逾期总次数</th>" +
		"<th>历史逾期M3+次数</th><th>历史逾期M6+次数据</th><th>记录来源</th></tr></thead><tbody>";
		
		for (var i = 0; i < mortd.length; i++) {
			var obj = mortd[i];
			showHtml += "<tr>";
			showHtml += "<td  >" + (i + 1) + "</td>";
			showHtml += "<td  >" + obj.loanDate + "</td>";
			showHtml += "<td  >" + obj.periods + "</td>";
			showHtml += "<td  >" + obj.loanAmount + "</td>";
			showHtml += "<td  >" + transApprovalStatus(obj.approvalStatusCode) + "</td>";
			showHtml += "<td  >" + transloanStatus(obj.loanStatusCode) + "</td>";
			showHtml += "<td  >" + transloanType(obj.loanTypeCode) + "</td>";
			showHtml += "<td  >" + obj.overdueAmount + "</td>";
			showHtml += "<td  >" + obj.overdueStatus + "</td>";
			showHtml += "<td  >" + obj.overdueTotal + "</td>";
			showHtml += "<td  >" + obj.overdueM3 + "</td>";
			showHtml += "<td  >" + obj.overdueM6 + "</td>";
			showHtml += "<td  >" + obj.dataCome + "</td>";
			showHtml += "</tr>";
		}
		showHtml += "</tbody></table>";
		
		showHtml += "<table class='easyui-datagrid  table-box'><thead><tr> " +
		"<th>序号</th><th>命中项码</th> <th>命中内容</th><th>风险明细</th>" +
		"<th>风险最近时间</th><th>记录来源</th></tr></thead><tbody>";
		
		for (var i = 0; i < riskList.length; i++) {
			var obj = riskList[i];
			showHtml += "<td  >" + (i + 1) + "</td>";
			showHtml += "<td  >" + obj.riskItemTypeCode + "</td>";
			showHtml += "<td  >" + obj.riskItemValue + "</td>";
			showHtml += "<td  >" + obj.riskDetail + "</td>";
			showHtml += "<td  >" + obj.riskTime + "</td>";
			showHtml += "<td  >" + obj.dataCome + "</td>";
		}
		showHtml += "</tbody></table>";
		
		$("#queryHistoryWin").html(showHtml);
	}
	
	//查询历史转换审批结果码
	function transApprovalStatus(code){
		if(code == "201"){
			return "审核中"
		}
		if(code == "202"){
			return "批贷已放款"
		}
		if(code == "203"){
			return "拒货"
		}
		if(code == "204"){
			return "客户放弃"
		}
	}
	
	//查询历史转换借款类型
	function transloanType(code){
		if(code == "21"){
			return "信用"
		}
		if(code == "22"){
			return "抵押"
		}
		if(code == "23"){
			return "担保"
		}
	}
	
	//查询历史转换借款类型
	function transloanStatus(code){
  		if(code == ""){
			return "未还款"
		}
  		if(code == "301"){
			return "正常"
		}
		if(code == "302"){
			return "逾期"
		}
		if(code == "303"){
			return "结清"
		}
	}

	function searchNow() {
		$("#showqueryInfo").html("");
		$.ajax({
			async : false,
			url : "/echoApi/query",
			data : {
				"name" : $("#personal").val(),
				"idNo" : $("#idCNo").val()
			},
			dataType : "json",
			success : function(data) {
				if (data.success) {
					$("#queryInfoSucWin").window("open");
					$("#showqueryInfo").html(opertionData(data.obj.data));
				} else {
					$("#queryInfoErrWin").window("open");
					$("#queryInfoErrWin span").html(data.msg);
				}
			}
		});
	}

	function opertionData(dataobj) {
		var showHtml = "<div class='group-title'>基本信息</div>";//嵌套数据变量
		showHtml += "<table class='group-info table-box'>"
		showHtml +="<thead>"
		showHtml +="<td>流水号</td><td>致诚信用分</td><td>违约概率</td>"
		showHtml +="</thead>"
		showHtml +="<tbody>"
		showHtml +="<tr>"
		showHtml +="<td>"+dataobj.flowId+"</td>"
		if(dataobj.zcCreditScore != undefined){
			showHtml +="<td>"+dataobj.zcCreditScore+"</td>"
		}else{
			showHtml +="<td></td>"
		}
		
		if(dataobj.contractBreakRate != undefined){
			showHtml +="<td>"+dataobj.contractBreakRate+"</td>"
		}else{
			showHtml +="<td></td>"
		}
		showHtml +="</tr>"
		showHtml +="</tbody>"
		showHtml += "</table>"

		var queryStatistics = dataobj.queryStatistics;
		
		showHtml += "<div class='group-title'>被查询统计</div>";
		showHtml += "<table class='group-info table-box'>"
			showHtml +="<thead>"
			showHtml +="<td>其他机构查询次数</td><td>其他查询机构数</td><td>本机构查询次数</td>"
			showHtml +="</thead>"
			showHtml +="<tbody>"
			showHtml +="<tr>"
			showHtml +="<td>"+queryStatistics.timesByOtherOrg+"</td>"
			showHtml +="<td>"+queryStatistics.otherOrgCount+"</td>"
			showHtml +="<td>"+queryStatistics.timesByCurrentOrg+"</td>"
			showHtml +="</tr>"
			showHtml +="</tbody>"
			showHtml += "</table>"

		showHtml += "<div class='group-title'>被查询历史</div><table class='group-list  table-box'>" +
					"<thead><tr><th>机构代号</th><th>查询时间</th><th>机构类型</th><th>查询原因</th></thead><tbody>";
		
					var queryHistory = dataobj.queryHistory;
		if(queryHistory != undefined){
			for (var i = 0; i < queryHistory.length; i++) {
				showHtml += "<tr>"
				showHtml += "<td>" + queryHistory[i].orgType + "</td>";
				showHtml += "<td>" + queryHistory[i].time + "</td>";
				showHtml += "<td>" + queryHistory[i].orgName + "</td>";
				showHtml += "<td>" + queryHistory[i].queryReason + "</td>";
				showHtml += "</tr>"
			}
		}

		showHtml += "</tbody></table><div class='group-title'>借款记录历史</div><table class='group-list table-box'>" +
					"<thead><tr><th>机构代号</th><th>借款人姓名</th><th>身份证号</th><th>借款时间</th><th>期数</th>" + 
					"<th>金额</th><th>审批结果码</th><th>还款状态码</th><th>借款类型码</th><th>逾期金额</th><th>逾期情况</th>" + 
					"<th>历史逾期次数</th><th>历史逾期M3+次数</th><th>历史逾期M6+次数</th></thead><tbody>";

		var loanRecords = dataobj.loanRecords;
		if(loanRecords != undefined){
			for (var i = 0; i < loanRecords.length; i++) {
				showHtml += "<tr>"
				showHtml += "<td>" + loanRecords[i].orgName + "</td>";
				showHtml += "<td>" + loanRecords[i].name + "</td>";
				showHtml += "<td>" + loanRecords[i].certNo + "</td>";
				showHtml += "<td>" + loanRecords[i].loanDate + "</td>";
				showHtml += "<td>" + loanRecords[i].periods + "</td>";
				showHtml += "<td>" + loanRecords[i].loanAmount + "</td>";
				showHtml += "<td>" + transApprovalStatus(loanRecords[i].approvalStatusCode) + "</td>";
				showHtml += "<td>" + transloanStatus(loanRecords[i].loanStatusCode) + "</td>";
				showHtml += "<td>" + transloanType(loanRecords[i].loanTypeCode) + "</td>";
				showHtml += "<td>" + loanRecords[i].overdueAmount + "</td>";
				showHtml += "<td>" + loanRecords[i].overdueStatus + "</td>";
				showHtml += "<td>" + loanRecords[i].overdueTotal + "</td>";
				showHtml += "<td>" + loanRecords[i].overdueM3 + "</td>";
				showHtml += "<td>" + loanRecords[i].overdueM6 + "</td>";
				showHtml += "</tr>"
			}
		}

		showHtml += "</tbody></table><div class='group-title'>风险项记录</div><table class='group-list table-box'>" +
					"<thead><tr><th>机构代号</th><th>命中项码</th><th>命中内容</th><th>风险类型码</th><th>风险明细</th><th>风险最近时间</th></thead><tbody>";

		var riskResults = dataobj.riskResults;
		if(riskResults != undefined){
			for (var i = 0; i < riskResults.length; i++) {
				showHtml += "<tr>"
				showHtml += "<td>" + riskResults[i].orgName + "</td>";
				showHtml += "<td>" + riskResults[i].riskItemTypeCode + "</td>";
				showHtml += "<td>" + riskResults[i].riskItemValue + "</td>";
				showHtml += "<td>" + riskResults[i].riskTypeCode + "</td>";
				showHtml += "<td>" + riskResults[i].riskDetail + "</td>";
				showHtml += "<td>" + riskResults[i].riskTime + "</td>";
				showHtml += "</tr>"
			}
		}
		showHtml += "</tbody></table>";
		return showHtml;
	}
	
	function appendMortgagor(){
		parent.$.modalDialog({
	        title : '添加借款人信息',
	        width : 700,
	        height : 500,
	        href : '/echoApi/mortgagorAdd',
	        buttons : [ {
	            text : '确定',
	            handler : function() {
	                parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	                var f = parent.$.modalDialog.handler.find('#mortgagorAddForm');
	                f.submit();
	            }
	        } ]
	    });
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div class="queryButton" data-options="region:'north',border:false" style="margin-bottom: 10px; width: 100%; height: 70px; padding: 10px;">
		<form id="searchForm">
			<div>
				<span class="query_title">姓名</span><input id="personal"
					class="easyui-textbox" name="vehicleType" style="width: 167px">
				<span class="query_title">身份证号</span><input id="idCNo"
					class="easyui-textbox" name="ownerName" style="width: 150px">
			</div>
			<div>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-search'" onclick="searchList();">查询列表</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-search'" onclick="searchNow();">实时查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-upload'" onclick="shareToEcho();">分享到平台</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-clear'" onclick="clearQueryWher();">清空筛选</a>
				<shiro:hasPermission name="/echoApi/mortgagorAdd">
					<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-add'" onclick="appendMortgagor();">添加借款人信息</a>
		        </shiro:hasPermission>
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false"
		style="width: 550px; overflow: hidden;">
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>

	<div id="queryInfoSucWin" class="easyui-window" title="处理结果"
		style="width: 85%; height: 85%;padding: 15px; overflow-y:scroll; "
		data-options="iconCls:'icon-list',modal:true, closed:true, 
		draggable:false, resizable:false,inline:true, collapsible:false, minimizable:false, maximizable:false">
		<div id="showqueryInfo"></div>
	</div>

	<div id="queryHistoryWin" class="easyui-window" title="查询历史"
		style="width: 85%; height: 85%;padding: 15px; overflow-y:scroll; "
		data-options="iconCls:'icon-list',modal:true, closed:true, 
		draggable:false, resizable:false,inline:true, collapsible:false, minimizable:false, maximizable:false">
		<div id="showqueryHistory" ></div>
	</div>

	<div id="queryInfoErrWin" class="easyui-window" title="提示信息"
		style="width: 400px; height: 150px"
		data-options="iconCls:'icon-tip',modal:true, closed:true, 
		draggable:false, resizable:false,inline:true, collapsible:false, minimizable:false, maximizable:false">
		<span></span>
	</div>
	
</body>
</html>

