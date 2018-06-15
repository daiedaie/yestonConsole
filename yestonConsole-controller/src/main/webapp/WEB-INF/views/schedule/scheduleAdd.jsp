<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$.fn.validatebox.defaults.rules.length.message = '输入内容长度必须介于{0}和{1}之间';
	//提交表单
	$('#scheduleAddForm').form({
		url : '/schedule/scheduleAdd',
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
			if (result.code==200) {
				parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
				parent.$.modalDialog.handler.dialog('close');
			} else {
				parent.$.messager.alert('提示', result.msg, 'warning');
			}
		}
	});
	
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow-x: hidden; padding: 3px;">
		<form id="scheduleAddForm" method="post">
			<table class="grid">
				<tr>
					<td>任务名称</td>
					<td><input id="jobName" name="jobName" class="easyui-textbox" data-options="required:true,validType:['length[0,255]']"></td>
					<td>任务分组</td>
					<td><input id="jobGroup" name="jobGroup" class="easyui-textbox" data-options="required:true,validType:['length[0,255]']"></td>
				</tr>
				<tr>
					<!-- 考虑完善成更利于用户选择的形式 -->
					<td>cron表达式</td>
					<td><input id="cronExpression" name="cronExpression" type="text" class="easyui-textbox" data-options="required:true,validType:['length[0,255]']"></td>
					<td>任务状态</td>
					<td>
						<select name="jobStatus" id="jobStatus" class="easyui-combobox" style="width:140px">
							<option value='0'>停止</option>
							<option value='1'>运行</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>是否同步</td>
					<td>
						<select name="isConcurrent" id="isConcurrent" class="easyui-combobox" style="width:140px">
							<option value='0'>同步</option>
							<option value='1'>异步</option>
						</select>
					</td>
					
					<td>SpringId</td>
					<td><input name="springId" type="text" value="taskService" placeholder="请输入Spring bean id" class="easyui-textbox"><br/>注：spring id和类路径同时填写时优先使用spring id</td>
				</tr>
				<tr>
					<td>类路径</td>
					<td>
						<input name="beanClass" value="com.mrbt.insurance.webset.service.impl.TaskServiceImpl" type="text" placeholder="请输入任务方法的类路径" class="easyui-textbox"  data-options="required:true">
					</td>
					
					<td>方法名</td>
					<td><input name="methodName" type="text" placeholder="请输入方法名" class="easyui-textbox"  data-options="required:true"></td>
				</tr>
				<tr>
					<td>描述</td>
					<td colspan="3">
					<textarea id="description" name="description" class="easyui-textbox" data-options="multiline:true"  style="width:90%;height:100px;"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>