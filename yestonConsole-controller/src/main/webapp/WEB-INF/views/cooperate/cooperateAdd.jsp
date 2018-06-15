<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#cooperateAddForm').form({
            url : '/cooperate/add',
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
        $('#deptId').combobox({    
            url:'/cooperate/deptList',    
            valueField:'id',    
            textField:'name',
            panelHeight : 'auto',
            editable:false,
            onSelect : function(record){
            	$("#name").val(record.name);
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
        <form id="cooperateAddForm" method="post">
        	<input name="name" type="hidden" id="name">
            <table class="grid">
                <tr>
                    <td>合作机构名称</td>
                    <td><input id="deptId" class="easyui-combobox" name="deptId" style="width:150px"></td>
                </tr>
                <tr>
                    <td>地域</td>
                    <td>
                    	<select id="regionName" name="regionName" data-options="panelHeight:'auto'" style="width:150px" class="easyui-combobox">
                    		<option value="北京">北京</option>
                    		<option value="青岛">青岛</option>
                    		<option value="杭州">杭州</option>
                    		<option value="其他">其他</option>
                    	</select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>