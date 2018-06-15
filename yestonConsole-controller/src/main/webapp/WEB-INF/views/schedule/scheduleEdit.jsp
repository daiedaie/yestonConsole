<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript">
	$(function() {
		var r_dtype = '${resObj.jobStatus}';
		//设置选中
		$('#jobStatus').find("option[value="+r_dtype+"]").attr("selected","ture");
		$('#scheduleEditForm').form({
            url : '/schedule/scheduleEdit',
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
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
	})
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow-x: hidden; padding: 3px;">
		<form id="scheduleEditForm" method="post">
			<table class="grid">
				<tr>
					<td>任务Id</td>
					<td><label>${resObj.jobId}</label>
						<input name="jobId" type="text" value="${resObj.jobId}" style="display: none;">
					</td>
					
					<td>任务名称</td>
					<td><label>${resObj.jobName}</label></td>
				</tr>
				<tr>
					<td>任务分组</td>
					<td><label>${resObj.jobGroup}</label></td>
					<td>创建时间</td>
					<td><label><fmt:formatDate value="${resObj.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></label></td>
				</tr>
				<tr>
					<td>是否同步</td>
					<td><label>${resObj.isConcurrent=='1'?'同步':'异步'}</label></td>
					<td>任务状态</td>
					<td>
						<select name="jobStatus" id="jobStatus" style="width:150px">
							<option value='0'>停止</option>
							<option value='1'>运行</option>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 考虑完善成更利于用户选择的形式 -->
					<td>cron表达式</td>
					<td><input id="cronExpression" name="cronExpression" value='${resObj.cronExpression}' type="text"class="easyui-validatebox" data-options="required:true,validType:['length[0,255]']"></td>
					<td>类路径</td>
					<td><label>${resObj.beanClass}</label></td>
				</tr>
				<tr>
					<td>方法名</td>
					<td><label>${resObj.methodName}</label></td>
					<td>Srping bean Id</td>
					<td><label>${resObj.springId}</label></td>
				</tr>
				<tr>
					<td>描述</td>
					<td><label>${resObj.description}</label></td>
					<td>修改时间</td>
					<td><label><fmt:formatDate value="${resObj.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></label></td>
				</tr>
			</table>
		</form>
	</div>
</div>