<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp" %>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>流程定义管理</title>
<script type="text/javascript" src="/static/js/jquery.ajaxfileupload.js"></script>
    <script type="text/javascript">
    var dataGrid;
    $(function() {
        dataGrid = $('#dataGrid').datagrid({
            url : '/process/dataGrid',
            border : false,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            pageSize : 10,
            pageList : [ 10, 20, 30 ],
            columns : [ [ {
                width : '365',
                align : 'center',
                title : 'id',
                field : 'id'
            }, {
                width : '175',
                align : 'center',
                title : '流程名称',
                field : 'name',
            },{
                width : '175',
                align : 'center',
                title : '流程key',
                field : 'key',
            },{
                width : '175',
                align : 'center',
                title : '流程版本',
                field : 'version',
            },{
                width : '175',
                align : 'center',
                title : '部署id',
                field : 'deploymentId',
            },{
                width : '120',
                align : 'center',
                title : '资源名称',
                field : 'resourceFile',
            }, {
                width : '175',
                align : 'center',
                title : '图片资源名称',
                field : 'resourceImg'
            }, {
                field : 'action',
                align : 'center',
                title : '操作',
                width : 180,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/process/delete">
                            str += $.formatString('<a href="javascript:void(0)" class="process-edit" onclick="delFun(\'{0}\');" >删除</a>', row.deploymentId);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/process/viewImg">
                        	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                        	str += $.formatString('<a href="/process/viewImg?id={0}&imgName={1}" target="_blank" class="process-viewImg" >查看流程图</a>', row.deploymentId,row.resourceImg);
                    	</shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.process-edit').linkbutton({text:'删除',plain:true,iconCls:'icon-del'});
                $('.process-viewImg').linkbutton({text:'查看流程图',plain:true,iconCls:'icon-search'});
            },
            toolbar : '#toolbar'
        });
    });
    function addFun() {
    	 parent.$.modalDialog({
             title : '添加',
             width : 300,
             height : 105,
             href : '/process/deployPage',
             buttons : [ {
                 text : '部署',
                 handler : function() {
                     parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                     var f = parent.$.modalDialog.handler.find('#deployForm');
                     f.submit();
                 }
             } ]
         });
    }
    
    function delFun(id){
    	parent.$.messager.confirm('询问', '真的要删除吗？', function(b) {
    		if(b){
    			progressLoad();
    			$.post('/process/deleteProcess',{deploymentId : id},function(){
    				dataGrid.datagrid('load', {});
    				progressClose();
    	    	});
    		}
    	});
    }
    
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
    <div id="center" data-options="region:'center',border:false"  style="width:550px;overflow: hidden; ">
        <table id="dataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div id="toolbar" style="display: none;">
        <shiro:hasPermission name="/cooperate/add">
            <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">部署流程</a>
        </shiro:hasPermission>
    </div>
</body>
</html>