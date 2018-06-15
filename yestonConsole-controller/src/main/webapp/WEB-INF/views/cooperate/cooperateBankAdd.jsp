<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#cooperateBankAddForm').form({
            url : '/cooperate/addBank',
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
        $('#type').combobox({    
            url:'/cooperate/getBankType',
            panelHeight:'auto',
            required:true,
            valueField:'id',
            editable:false,
            width:250,
            textField:'batName'   
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
        <form id="cooperateBankAddForm" method="post">
        	<input type="hidden" name="cooperateId" value="${cooperate.id}">
            <table class="grid">
                <tr>
                    <td>账户名称</td>
                    <td><input name="bankAccountName" type="text" class="easyui-textbox" data-options="required:true,width:250" value="${cooperate.name}"></td>
                </tr>
                <tr>
                    <td>银行账号</td>
                    <td><input name="bankAccount" type="text" class="easyui-textbox" data-options="required:true,width:250" value=""></td>
                </tr>
                <tr>
                    <td>银行</td>
                    <td><input name="bank" type="text" class="easyui-textbox" data-options="required:true,width:250" value=""></td>
                </tr>
                <tr>
                    <td>开户行</td>
                    <td><input name="bankName" type="text" class="easyui-textbox" data-options="required:true,width:250" value=""></td>
                </tr>
                <c:if test="${cooperate == null}">
                	<tr>
                    	<td>类型</td>
                   		<td>
                   			<input id="type" name="type" value="">
                   		</td>
                	</tr>
                </c:if>
            </table>
        </form>
    </div>
</div>