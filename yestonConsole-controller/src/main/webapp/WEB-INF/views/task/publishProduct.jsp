<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#publishProductForm').form({
            url : '/personalTask/publishProduct',
            onSubmit : function() {
                progressLoad();
                if("${carLoan.productId}" != ''){
                	progressClose();
                	parent.$.messager.alert('错误', '已发布产品，不能重复发布', 'error');
                	return false;
                }
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
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
        <form id="publishProductForm" method="post">
        	<input name="businessType" type="hidden" value="${carLoan.businessType}">
        	<input name="carLoanId" type="hidden" value="${carLoan.id}">
            <table class="grid">
                <tr>
                    <td>产品名称</td>
                    <td><input class="easyui-textbox" name="productName" style="width:150px"></td>
                </tr>
                <tr>
                    <td>募集规模</td>
                    <td><input class="easyui-textbox" name="raiseMoney" style="width:150px" value="${carLoan.loanAmount}"></td>
                </tr>
                <tr>
                    <td>固定收益率</td>
                    <td><input class="easyui-textbox" name="fixedYield" style="width:150px" value="${carLoan.rate}"></td>
                </tr>
                <tr>
                    <td>产品固定天数</td>
                    <td><input class="easyui-textbox" name="fixedDays" style="width:150px" value="${carLoan.loanTerm}"></td>
                </tr>
            </table>
        </form>
    </div>
</div>