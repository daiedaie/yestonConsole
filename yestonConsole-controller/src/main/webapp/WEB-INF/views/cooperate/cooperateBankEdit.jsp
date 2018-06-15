<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#bankEditForm').form({
            url : '/cooperate/editBank',
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
                } else {
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
        var bankType = '${bankInfo.type}';
        $('#type').combobox({    
            url:'/cooperate/getBankType',
            panelHeight:'auto',
            required:true,
            valueField:'id',
            editable:false,
            width:250,
            textField:'batName',
            onLoadSuccess : function(){
            	$('#type').combobox('setValue',bankType);
            	if(bankType == 1){
            		$('#type').combobox('readonly');
            	}
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
        <form id="bankEditForm" method="post">
        	<input type="hidden" name="id" value="${bankInfo.id }">
            <table class="grid">
                <tr>
                    <td>账户名称</td>
                    <td><input name="bankAccountName" type="text" class="easyui-textbox" data-options="required:true,width:250" value="${bankInfo.bankAccountName}"></td>
                </tr>
                <tr>
                    <td>银行账号</td>
                    <td><input name="bankAccount" type="text" class="easyui-textbox" data-options="required:true,width:250" value="${bankInfo.bankAccount }"></td>
                </tr>
                <tr>
                    <td>银行</td>
                    <td><input name="bank" type="text" class="easyui-textbox" data-options="required:true,width:250" value="${bankInfo.bank }"></td>
                </tr>
                <tr>
                    <td>开户行</td>
                    <td><input name="bankName" type="text" class="easyui-textbox" data-options="required:true,width:250" value="${bankInfo.bankName }"></td>
                </tr>
                <c:if test="${bankInfo.type != 1}">
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