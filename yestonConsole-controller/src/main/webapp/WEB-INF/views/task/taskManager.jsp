<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp" %>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>个人任务管理</title>
<script type="text/javascript" src="/static/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript">
    var dataGrid;
    $(function() {
        dataGrid = $('#dataGrid').datagrid({
            url : '/personalTask/dataGrid',
            title : '任务列表',
            border : false,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            pageSize : 10,
            pageList : [ 10, 20, 30 ],
            columns : [ [ {
                width : '230',
                align : 'center',
                title : '业务id',
                field : 'ytCarLoanId'
            }, {
                width : '175',
                align : 'center',
                title : '任务名称',
                field : 'taskName',
            },{
                width : '175',
                align : 'center',
                title : '所属用户',
                field : 'userName',
            },{
                width : '175',
                align : 'center',
                title : '创建时间',
                field : 'createTime',
            },{
                field : 'action',
                align : 'center',
                title : '操作',
                width : 300,
                formatter : function(value, row, index) {
                    var str = '';
                    	if(row.taskName == '是否发布产品'){
                    		<shiro:hasPermission name="/personalTask/publishProduct">
                            	str += $.formatString('<a href="javascript:void(0)" class="personalTask-publishProduct" onclick="publishProduct(\'{0}\');" ></a>', row.taskId);
                            	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                       		</shiro:hasPermission>
                    	}
                        <shiro:hasPermission name="/personalTask/transactTask">
                            str += $.formatString('<a href="javascript:void(0)" class="personalTask-edit" onclick="transactTask(\'{0}\',\'{1}\');" ></a>', row.taskId,row.taskName);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/personalTask/currentImg">
                        	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                        	str += $.formatString('<a href="/personalTask/currentImg?taskId={0}" target="_blank" class="personalTask-viewImg" ></a>', row.taskId);
                    	</shiro:hasPermission>
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.personalTask-edit').linkbutton({text:'办理任务',plain:true,iconCls:'icon-ok'});
                $('.personalTask-viewImg').linkbutton({text:'查看流程图',plain:true,iconCls:'icon-search'});
                $('.personalTask-publishProduct').linkbutton({text:'发布产品',plain:true,iconCls:'icon-world_add'});
            }
        });
    });
    
    function publishProduct(id){
    	parent.$.modalDialog({
            title : '发布产品',
            width : 350,
            height : 220,
            href : '/personalTask/publishProductPage?taskId=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#publishProductForm');
                    f.submit();
                }
            } ]
        });
    }
    function transactTask(id,taskName) {
    	 parent.$.modalDialog({
             title : taskName,
             width : 800,
             height : 500,
             href : '/personalTask/taskPage?taskId='+id
             /* buttons : [ {
                 text : '关闭',
                 handler : function() {
                	 parent.$.modalDialog.openner_dataGrid = dataGrid;
                     dataGrid.datagrid("reload");
                     parent.$.modalDialog.handler.dialog('close');
                 }
             } ] */
         });
    	 parent.$.modalDialog.openner_dataGrid = dataGrid;
    }
    
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
    <div id="center" data-options="region:'center',border:false"  style="width:550px;overflow: hidden; ">
        <table id="dataGrid" data-options="fit:true,border:false"></table>
    </div>
</body>
</html>