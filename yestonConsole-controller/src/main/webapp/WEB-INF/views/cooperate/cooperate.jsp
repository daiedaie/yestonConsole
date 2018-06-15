<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp" %>
<meta http-equiv="X-UA-Compatible" content="edge" />
<script type="text/javascript" src="/static/js/cooperate.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="/static/style/css/cooperate.css" />
<title>合作机构管理</title>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"  style="overflow-y: scroll;">
        <table id="dataGrid"></table>
        <table id="commonBankGrid"></table>
    </div>
	    <div id="toolbar" style="display: none;">
	    	<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
	        <form id="searchForm">
	            <table>
	                <tr>
	                    <th>合作机构名称:</th>
	                    <td><input id="supplierName" name="supplierName" class="easyui-textbox" style="width:150px" /></td>
	                    <th>地域:</th>
	                    <td><select id="regionName" name="regionName" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
	                    		<option value="">全部</option>
	                    		<option value="北京">北京</option>
	                    		<option value="青岛">青岛</option>
	                    		<option value="杭州">杭州</option>
	                    		<option value="其他">其他</option>
	                    	</select></td>
	                    <td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
        <shiro:hasPermission name="/cooperate/add">
            <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
        </shiro:hasPermission>
    </div>
    <div id="toolbarLinkman" style="display: none;">
        <shiro:hasPermission name="/cooperate/addLinkman">	
            <a onclick="addLinkmanFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
        </shiro:hasPermission>
    </div>
    <div id="toolbarBank" style="display: none;">
        <shiro:hasPermission name="/cooperate/addBank">	
            <a onclick="addBankFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
        </shiro:hasPermission>
    </div>
    <div id="toolbarCommonBank" style="display: none;">
        <shiro:hasPermission name="/cooperate/addBank">	
            <a onclick="addBankFun('true');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
        </shiro:hasPermission>
    </div>
    <div id="bankWin" class="easyui-window" title="供应商银行账户" data-options="closed:true"
		style="width: 880px; height: 400px; padding: 5px;">
		<table id="bankGrid" data-options="fit:true,border:false"></table>
	</div>
	<div id="linkmanWin" class="easyui-window" title="联系人信息" data-options="closed:true"
		style="width: 860px; height: 400px; padding: 5px;">
		<table id="linkmanGrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>