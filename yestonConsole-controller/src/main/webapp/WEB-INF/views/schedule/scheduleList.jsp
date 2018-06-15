<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>定时任务管理</title>
<%@ include file="/commons/basejs.jsp"%>
<meta http-equiv="X-UA-Compatible" content="edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/static/js/schedule.js" charset="utf-8"></script>
<script type="text/javascript">
var dataGrid;
$(function(){
	//初始化表格
	dataGrid = $('#scheduleDataGrid').datagrid({
		url : '/schedule/scheduleList',
		fit : true,
		fitColumns: true,
		height : 500,
        striped : true,
        pagination : true,
        singleSelect : true,
		pageSize : 20,
		pageList : [ 10, 20, 30, 40, 50 ],
		columns : [ [ 
		    { title : 'ID', field : 'jobId', width : '40' },
		    { title : '任务名', field : 'jobName', width : '100' },
		    { title : '组', field : 'jobGroup', width : '100' },
		    { title : '状态', field : 'jobStatus', width : '60' ,formatter:function(value,row){
		    	var str = '';            	
		    	if(value == '0'){
		    		str+=$.formatString('<select onchange="submitStatus(\'{0}\',this)" name="jobStatus" id="jobStatus" style="width:50px"> <option value="0" selected="selected">停止</option> <option value="1">运行</option> <option value="2" >暂停</option> </select>',row.jobId);
		    	}
		    	if(value == '1'){
		    		str+=$.formatString('<select onchange="submitStatus(\'{0}\',this)" name="jobStatus" id="jobStatus" style="width:50px"> <option value="0">停止</option> <option value="1" selected="selected">运行</option> <option value="2" >暂停</option> </select>',row.jobId);
		    	}
		    	if(value == '2'){
		    		str+=$.formatString('<select onchange="submitStatus(\'{0}\',this)" name="jobStatus" id="jobStatus" style="width:50px"> <option value="0">停止</option> <option value="1" >运行</option> <option value="2" selected="selected">暂停</option> </select>',row.jobId);
		    	}
		    	return str; 
		    }},
		    { title : 'cron表达式', field : 'cronExpression', width : '170',formatter:function(value,row){
		    	var id=row.jobId;
		    	var str = '<div id="cronDiv'+id+'"><span>'+value+'<span>&nbsp;&nbsp;<input id="changeCron'+id+'" type="button" value="修改" onclick="changeCron(\''+value+'\',\''+id+'\',0)"/></div>';
		    	return str; 
		    } },
		    { title : '是否同步', field : 'isConcurrent', width : '60' ,formatter:function(value){
		    	if(value == '1'){
		    		return "异步";
		    	}else{
		    		return "同步";
		    	}
		    }},
		    { title : '类路径', field : 'beanClass', width : '400' },
		    { title : 'Spring ID', field : 'springId', width : '100' },
		    { title : '方法名', field : 'methodName', width : '100' },
		    { title : '描述', field : 'description', width : '280' },	
		    { title : '创建时间', field : 'createTime', width : '120', formatter:formatTime },	
		    { title : '修改时间', field : 'updateTime', width : '120', formatter:formatTime }
		] ],
		onLoadSuccess:function(data){
            $('.role-easyui-linkbutton-edit').linkbutton({text:'修改',plain:true,iconCls:'icon-edit'});
        },
		toolbar : '#toolbar'
	});
	$('#scheduleDataGrid').find('a').attr('class','easyui-linkbutton');
});

</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false"
		style="height: auto; overflow: hidden; background-color: #fff">
		<form id="searchForm">
			<table>
				<tr>
					<th>ID:</th>
					<td><input name="jobId" style="width:150px"  class="easyui-textbox" placeholder="请输入任务id" /></td>
					<th>任务状态:</th>
					<td>
	                    <select name="jobStatus" style="width:150px"  class="easyui-combobox">
	                   		<option value="">全部</option>
	 						<option value="0">停止</option>
	 						<option value="1">启动</option>     
	 						<option value="2">暂停</option>     
	 						<option value="3">删除</option>     
	                    </select>
	                </td>
					
					<th>任务名:</th>
					<td><input class="easyui-textbox" style="width:150px"  name="jobName" placeholder="请输入任务名" /></td>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-search',plain:true"
							onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-cancel',plain:true"
							onclick="cleanFun();">清空</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="toolbar" style="display: none;">
       <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
       <a onclick="editSchedule();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'">编辑</a>
       <a onclick="removeSchedule();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'">删除</a>
       <a onclick="executeNow();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-ok'">立即执行</a>
       <a onclick="resumeJob();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-ok'">恢复任务</a>
    </div>
	<div data-options="region:'center',border:true,title:'任务列表'">
		<table id="scheduleDataGrid" data-options="fit:true,border:false"></table>
	</div>
    <div id="win" class="easyui-window" style="width:400px;height:200px;" data-options="modal:true, closed : true">
    	<span id="showDetails"></span>
	</div>
	
	<div id="editScheduleDialog" class="easyui-dialog" title="编辑" style="width:560px;height:250px;"   
        data-options="iconCls:'icon-edit',resizable:true,modal:true,closed:true">
		<form id="scheduleEditForm" method="post">
			<input name="jobId" type="hidden">
			<table class="grid">
				<tr>
					<td>任务名称</td>
					<td><input name="jobName" class="easyui-textbox"></td>
					
					<td>任务分组</td>
					<td><input name="jobGroup" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>是否同步</td>
					<td>
						<select name="isConcurrent" class="easyui-combobox" style="width:100%;">   
						   	<option value="0">同步</option>
	 						<option value="1">异步</option>
						</select>  
					</td>
					<td>任务状态</td>
					<td>
						<select name="jobStatus" class="easyui-combobox" style="width:100%;">
							<option value="0">停止</option>
	 						<option value="1">启动</option>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 考虑完善成更利于用户选择的形式 -->
					<td>cron表达式</td>
					<td><input name="cronExpression" class="easyui-textbox"></td>
					<td>类路径</td>
					<td><input name="beanClass" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>方法名</td>
					<td><input name="methodName" class="easyui-textbox"></td>
					<td>Srping bean Id</td>
					<td><input name="springId" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>描述</td>
					<td colspan="3"><input name="description" class="easyui-textbox" style="width:100%;"></td>
				</tr>
				<tr>
					<td colspan="3"></td>
					<td style="text-align:right;">
						<a class="easyui-linkbutton" onclick="editConfirm();">确定</a>&nbsp;&nbsp;&nbsp;
						<a class="easyui-linkbutton" onclick="editCancel();">取消</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>

