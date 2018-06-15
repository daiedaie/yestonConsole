<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#linkmanEditForm').form({
            url : '/cooperate/editLinkman',
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
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="linkmanEditForm" method="post">
        	<input type="hidden" name="id" value="${linkman.id }">
            <table class="grid">
                <tr>
                    <td>联系人</td>
                    <td><input name="linkman" type="text" class="easyui-textbox" data-options="required:true" value="${linkman.linkman}"></td>
                </tr>
                <tr>
                    <td>固定电话</td>
                    <td><input name="fixedTelphone" type="text" class="easyui-textbox" value="${linkman.fixedTelphone}"></td>
                </tr>
                <tr>
                    <td>手机号</td>
                    <td><input name="mobilePhone" type="text" class="easyui-textbox" value="${linkman.mobilePhone}"></td>
                </tr>
                <tr>
                    <td>传真</td>
                    <td><input name="faxPhone" type="text" class="easyui-textbox" value="${linkman.faxPhone}"></td>
                </tr>
                <tr>
                    <td>地址</td>
                    <td><input name="address" type="text" class="easyui-textbox" value="${linkman.address}"></td>
                </tr>
                <tr>
                    <td>邮箱</td>
                    <td><input name="email" type="text" class="easyui-textbox" value="${linkman.email}"></td>
                </tr>
            </table>
        </form>
    </div>
</div>