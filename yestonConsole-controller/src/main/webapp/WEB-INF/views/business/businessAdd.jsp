<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet" type="text/css" href="/static/style/css/business.css" />
<style type="text/css" >
.center_title {
    border-bottom-color:#2679B5;
    color: #2679B5;
}
.center_title span {
    border-left-color: #2679B5;
}
.validatebox-invalid{
    background: #fff;
}
</style>
<script type="text/javascript">
    $(function() {
        $('#businessAddForm').form({
            url : '/business/add',
            onSubmit : function() {
                progressLoad();
            	var plateNumber = $("#plateNumber").combobox("getText");
            	var plateNumber2 = $("#plateNumber2").textbox("getText");
            	$("input[name='plateNumber']").val(plateNumber + plateNumber2);
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
      	$('#plateNumber').combobox({    
            url:'/static/json/province.json', 
            method:'get',
            valueField:'name',
            required:true,
      	    textField:'name',
      	    editable:false
      	});
    });
    function count(){
    	var loanAmount = $('#loanAmount').textbox('getText');
    	if(loanAmount != '' && !verifyNumber(loanAmount)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#loanAmount").textbox('setText','');
    		return;
    	}
		var loanTerm = $('#loanTerm').textbox('getText');
		if(loanTerm != '' && !verifyNumber(loanTerm)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#loanTerm").textbox('setText','');
    		return;
    	}
		var rate = $('#rate').textbox('getText');
		if(rate != '' && !verifyNumber(rate)){
    		$.messager.alert('错误','请输入数字！',"error");
    		$("#rate").textbox('setText','');
    		return;
    	}
		var value = Number(loanAmount) + Number((loanAmount * rate / 100 / 365 * loanTerm).toFixed(2));
		$('#estRepAmount').textbox('setText',value); 
		$('input[name=\'estRepAmount\']').val(value);
		$('#actRepAmount').textbox('setText',value);                
		$('input[name=\'actRepAmount\']').val(value);
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;overflow-y: scroll;" >
        <form id="businessAddForm" method="post">
        	<div class="center_title"><span>车辆基本信息</span></div>
            <table class="grid">
                <tr>
                    <td>车牌号</td>
                    <td>
                    	<input id="plateNumber" name="plateNumber" style="width:40px"/>
                    	<input id="plateNumber2" class="easyui-textbox" data-options="required:true" style="width:107px"> 
                    </td>
                    <td style="width:100px">车辆型号</td>
                    <td><input name="vehicleType" class="easyui-textbox" data-options="required:true" style="width:150px"></td>
                </tr>
                <tr>
                    <td>是否运营</td>
                    <td>
                    	<select name="whetherOperation" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="0">否</option>
                    		<option value="1">是</option>
                    	</select>
                    </td>
                    <td>车辆年限</td>
                    <td><input name="vehicleLife" class="easyui-numberbox" data-options="required:true" style="width:148px">&nbsp;&nbsp;个月</td>
                </tr>
                <tr>
                	<td>车辆所属</td>
                    <td>
                    	<select name="vehicleOwnership" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="1">个人</option>
                    		<option value="2">公司</option>
                    	</select>
                    </td>
                    <td style="width:100px">车主姓名/企业名称</td>
                    <td><input name="ownerName" class="easyui-textbox" data-options="required:true" style="width:150px"></td>
                </tr>
                <tr>
                    <td>行驶公里数</td>
                    <td colspan="3"><input name="kilometers" class="easyui-numberbox" data-options="required:true" style="width:148px">&nbsp;&nbsp;公里</td>
                </tr>
            </table>
            <div class="center_title"><span>借款信息</span></div>
            <table class="grid">
            	<tr>
                    <td style="width:100px">借款金额</td>
                    <td><input id="loanAmount" name="loanAmount" class="easyui-textbox" data-options="onChange:count,required:true" style="width:148px">&nbsp;&nbsp;元</td>
                    <td style="width:100px">借款期限</td>
                    <td><input id="loanTerm" name="loanTerm" class="easyui-textbox" data-options="onChange:count,required:true" style="width:148px">&nbsp;&nbsp;天</td>
                </tr>
                <tr>
               		<td>利率</td>
                    <td><input id="rate" class="easyui-textbox" name="rate" style="width:148px" data-options="onChange:count,required:true">&nbsp;&nbsp;%</td>
                     <td>抵押方式</td>
                    <td>
                    	<select name="singleDoubleCharge" class="easyui-combobox" data-options="panelHeight:'auto',editable:false" style="width:150px">
                    		<option value="1">单押</option>
                    		<option value="2">双押</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>是否一抵押</td>
                    <td>
                    	<select name="dollarsNumber" class="easyui-combobox" style="width:150px" data-options="
                    			panelHeight:'auto',editable:false,
                    			onSelect: function(record){
                    				if(record.value == 1){
                    					$('#oneDollarsName').textbox('disable');
                    				} else {
										$('#oneDollarsName').textbox('enable');
                    				}
                    			}" >
                    		<option value="1">一抵押</option>
                    		<option value="2">二抵押</option>
                    	</select>
                    </td>
                    <td>上一抵押人</td>
                    <td><input id="oneDollarsName" name="oneDollarsName" class="easyui-textbox" data-options="disabled:'true'" style="width:150px"></td>
                </tr>
                <tr>
               		<td>预计还款金额</td>
                    <td><input id="estRepAmount" name="estRepAmount" class="easyui-textbox" data-options="readonly:'true'" style="width:148px">&nbsp;&nbsp;元</td>
                    <td>实际还款金额</td>
                    <td><input id="actRepAmount" name="actRepAmount" class="easyui-textbox" data-options="readonly:'true'" style="width:148px">&nbsp;&nbsp;元</td>
                </tr>
            </table>
        </form>
    </div>
</div>