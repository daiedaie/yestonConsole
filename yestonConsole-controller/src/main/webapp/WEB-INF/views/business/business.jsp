<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/commons/basejs.jsp" %>
<title>车贷信息管理</title>
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="stylesheet" type="text/css" href="/static/style/css/business.css" />
<style type="text/css">
.panel-header, .my-easyui-panel{
    border:1px solid #95B8E7;
}
.panel-header{
   border-bottom:0;
   background:#95B8E7;
}
.panel-title{color:#fff;}

</style>
<script type="text/javascript" src="/static/zoomify.js"></script>
<script type="text/javascript">
    var dataGrid;
    $(function() {
        dataGrid = $('#dataGrid').datagrid({
            url : '/business/dataGrid',
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            pageSize : 10,
            pageList : [ 10, 20, 30 ],
            columns : [ [ {
                width : '60',
                align : 'center',
                title : '车牌号',
                field : 'plateNumber'
            }, {
                width : '60',
                align : 'center',
                title : '车主姓名',
                field : 'ownerName',
            }, {
                width : '100',
                align : 'center',
                title : '车辆型号',
                field : 'vehicleType',
            }, {
                width : '100',
                align : 'center',
                title : '借款金额',
                field : 'loanAmount',
                formatter : function(value, row, index) {
                	return value + " 元";
                }
            }, {
                width : '60',
                align : 'center',
                title : '借款期限',
                field : 'loanTerm',
                formatter : function(value, row, index) {
                	return value + " 天";
                }
            },{
                width : '65',
                align : 'center',
                title : '利率',
                field : 'rate',
                formatter : function(value, row, index) {
                	return value + "%";
                }
            },{
                width : '60',
                align : 'center',
                title : '申请人',
                field : 'userName',
            },{
                width : '150',
                align : 'center',
                title : '供应商',
                field : 'cooperateName',
            },{
                width : '50',
                align : 'center',
                title : '地域',
                field : 'regionName',
            }, {
                width : '100',
                align : 'center',
                title : '预计还款金额',
                field : 'estRepAmount',
                formatter : function(value, row, index) {
                	return value + " 元";
                }
            }, {
                width : '100',
                align : 'center',
                title : '实际还款金额',
                field : 'actRepAmount',
                formatter : function(value, row, index) {
                	return value + " 元";
                }
            }, {
                width : '120',
                align : 'center',
                title : '发起时间',
                field : 'startTime',
            }, {
                width : '80',
                title : '产品',
                align : 'center',
                field : 'productId',
                formatter : function(value, row, index) {
                	if(value != null){
                		return $.formatString('<a href="javascript:void(0)" class="business-search" onclick="showProduct(\'{0}\',\'{1}\');" >查看</a>', value,row.businessType);
                	}else{
                		return '未发布产品';
                	}
                }
            }, {
                width : '120',
                title : '状态',
                align : 'center',
                field : 'status',
            }, {
                field : 'action',
                align : 'center',
                title : '操作',
                width : 285,
                formatter : function(value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/business/dataDetail">
                        str += $.formatString('<a href="javascript:void(0)" class="business-search" onclick="carLoanDetail(\'{0}\');" >查看</a>', row.id);
                    </shiro:hasPermission>
                    if(row.status == '初始录入' || row.status == '已驳回'){
                    	<shiro:hasPermission name="/business/edit">
                    		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                       		str += $.formatString('<a href="javascript:void(0)" class="business-edit" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
                   		</shiro:hasPermission>
                    }
                    if(row.status != '初始录入' && row.status != '已完成'){
                    	<shiro:hasPermission name="/personalTask/currentImg">
                    		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    		str += $.formatString('<a href="javascript:void(0)" onclick="showProcessImg(\'{0}\');" class="personalTask-viewImg" >查看流程图</a>', row.id);
                		</shiro:hasPermission>
                    }
                    if(row.status == '初始录入'){
                    	<shiro:hasPermission name="/business/start">
               				str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
               				str += $.formatString('<a href="javascript:void(0)" class="business-startProcess" onclick="startProcess(\'{0}\');" >发起</a>', row.id);
           				</shiro:hasPermission>
                    }else{
                    	<shiro:hasPermission name="/business/hisComment">
                    		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    		str += $.formatString('<a href="javascript:void(0)" class="business-his" onclick="hisComment(\'{0}\');" >历史审批</a>', row.id);
               			</shiro:hasPermission>
                    }
               		if(row.status == '保证金退还完成'){
               			<shiro:hasPermission name="/business/complete">
                    		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    		str += $.formatString('<a href="javascript:void(0)" class="business-ok" onclick="complete(\'{0}\');" >完成</a>', row.id);
               			</shiro:hasPermission>
               		}
                    return str;
                }
            } ] ],
            onLoadSuccess:function(data){
                $('.business-edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
                $('.business-startProcess').linkbutton({text:'发起',plain:true,iconCls:'icon-ok'});
                $('.business-search').linkbutton({text:'查看',plain:true,iconCls:'icon-search'});
                $('.personalTask-viewImg').linkbutton({text:'查看流程图',plain:true,iconCls:'icon-search'});
                $('.business-his').linkbutton({text:'历史审批',plain:true,iconCls:'icon-search'});
                $('.business-ok').linkbutton({text:'完成',plain:true,iconCls:'icon-ok'});
            },
            toolbar : '#toolbar'
        });
        $('#plateNumber').combobox({    
            url:'/static/json/province.json', 
            method:'get',
            valueField:'name',    
      	    textField:'name',
      	    editable:false 
      	});
        $('#status').combobox({    
            url:'/business/statusList',    
            valueField:'id',    
            textField:'name',
            editable:false 
        });
        
        $('#deptId').combotree({    
            url:'/business/deptList',    
            panelHeight: 'auto',
            onChange :function(){
            	$('#userId').combobox("disable");
            },
            onSelect : function(node) {  
                //返回树对象  
                var tree = $(this).tree;  
                //选中的节点是否为叶子节点,如果不是叶子节点,清除选中  
                var isLeaf = tree('isLeaf', node.target);  
                if (!isLeaf) {  
                    //清除选中  
                    $('#deptId').combotree('clear');  
                }  
            }  
        });
          
        $('#userId').combobox({    
            url:'/business/userList',    
            valueField:'id',    
            textField:'name',
           	panelHeight : 'auto',
           	editable:false,
			onSelect : function(record){
				$('#deptId').combobox("disable");
            }
        });
    });
    
    function showProcessImg(id){
    	$.ajax({
			async: false,
            url:"/business/getTaskId",
            data:{"carLoanId" : id},
        	dataType: "json",
            success:function(data){
            	window.open("/personalTask/currentImg?taskId=" + data);
            }        
         });
    }
    
    function showProduct(id,businessType){
    	parent.$.modalDialog({
            title : '产品信息',
            width : 800,
            height : 500,
            href : '/business/showProductPage?id=' + id + '&businessType=' + businessType,
            buttons : [ {
                text : '关闭',
                handler : function() {
                    dataGrid.datagrid("reload");
                    parent.$.modalDialog.handler.dialog('close');
                }
            } ]
        });
    }
    
    function hisComment(id){
    	$('#commentWin').window('open');
    	$('#commentGrid').datagrid({
 				url : '/business/hisComment',
 				fit : true,
 				striped : true,
 				rownumbers : true,
 				singleSelect : true,
 				queryParams : {
 					carLoanId : id
 				},
 				columns : [ [
 						{
 							width : '300',
 							title : '审批信息',
 							field : 'message'
 						},
 						{
 							width : '60',
 							title : '凭证',
 							align : 'center',
 							field : 'voucher',
 							formatter : function(value, row, index) {
 								if(value != null){
	 								return $.formatString('<a href="javascript:void(0)" onclick="showVoucher(\'{0}\');" >查看</a>', value);
 								}
 							}
 						},
 						{
 							width : '60',
 							title : '审批人',
 							align : 'center',
 							field : 'userName'
 						},
 						{
 							width : '150',
 							title : '审批时间',
 							align : 'center',
 							field : 'time'
 						}] ]
 		});
    }
    
    function showVoucher(urls){
    	$('#voucherWin').empty();
    	$('#voucherWin').window('open');
    	var urlArray = urls.split(",");
    	if(urlArray.length == 1){
    		$("#voucherWin").append("<img src='" + urlArray[0] + "' width='100px'>");
    	}else{
    		for(var i in urlArray){
				$("#voucherWin").append("<img src='" + urlArray[i] + "' width='100px'>");
			}
    	}
    	$("img").zoomify();
    }
    
    function complete(id){
    	$.messager.confirm('确认','确认完成订单吗？',function(r){    
		    if (r){    
		    	$.post("/business/complete",{carLoanId : id},function(result){
		    		if(result.success){
		    			$.messager.alert('提示','操作成功','info');    
		    		}else{
		    			$.messager.alert('错误','服务器出错','error');    
		    		}
		    		dataGrid.datagrid("reload");
		    	},'json');
		    }    
		});
    }
    
    function carLoanDetail(id){
    	parent.$.modalDialog({
            title : '贷款详细信息',
            width : 800,
            height : 500,
            href : '/business/carLoanDetailPage?id=' + id,
            buttons : [ {
                text : '关闭',
                handler : function() {
                    dataGrid.datagrid("reload");
                    parent.$.modalDialog.handler.dialog('close');
                }
            } ]
        });
    }
    
    function startProcess(carLoanId){
    	$.messager.confirm('确认','确认发起流程',function(r){    
		    if (r){    
		    	$.post('/business/startApply',{carLoanId:carLoanId},function(msg){
		    		if(msg.success){
		    			$.messager.alert("提示", "发起成功，请及时办理个人任务", "info",function(){
		    				$.get('/personalTask/loadTask',{},function(result){
		    					if(result > 0){
		    						parent.$("#msg").html(result);
		    					}else{
		    						parent.$("#msg").html(0);
		    					}
		    				},'json');
		    				// 转到任务管理页面
		    				var tt = parent.$("#index_tabs");
		    				if (tt.tabs('exists', '个人任务管理')) {
		    					tt.tabs('close', '个人任务管理');
		    				}
	    					var content = '<iframe frameborder="0" src="/personalTask/manager" style="border:0;width:100%;height:99.5%;"></iframe>';
	    					tt.tabs('add', {
	    						title : '个人任务管理',
	    						content : content,
	    						closable : true,
	    						iconCls : 'icon-folder'
	    					});
		    			});
		    		}else{
		    			$.messager.alert("错误", "服务器出错，请联系管理员", "error");
		    		}
		    		dataGrid.datagrid("reload");
		    	},'json');
		    }    
		}); 
    }
    
    function editFun(id){
    	parent.$.modalDialog({
            title : '编辑',
            width : 800,
            height : 500,
            href : '/business/editFunPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#businessEditForm');
                    f.submit();
                }
            } ]
        });
    }

    function searchFun() {
    	var plateNumber = $("#plateNumber").combobox('getText');
    	var plateNumber2 = $("#plateNumber2").textbox('getText');
    	$("input[name='plateNumber']").val(plateNumber + plateNumber2);
        dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
    }
    function cleanFun() {
    	$('.easyui-textbox').textbox('setText','');
    	$('.easyui-numberbox').numberbox('setValue','');
    	$('.easyui-datetimebox').datetimebox('setValue','');
        $(".easyui-combobox").combobox('setValue','');
        $(".easyui-combotree").combotree('setValue','');
        $('#userId').combobox("enable");
        $('#deptId').combotree("enable");
        dataGrid.datagrid('load', {});
    }
    
    function addFun() {
    	$.get("/business/checkUser",{},function(msg){
    		if(msg == false){
    			$.messager.alert("提示", "当前用户所在部门尚未关联供应商", "info");
    			return;
    		}else{
    			parent.$.modalDialog({
    	            title : '申请贷款',
    	            width : 800,
    	            height : 427,
    	            href : '/business/addPage',
    	            buttons : [ {
    	                text : '确定',
    	                handler : function() {
    	                    parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
    	                    var f = parent.$.modalDialog.handler.find('#businessAddForm');
    	                    f.submit();
    	                }
    	            } ]
    	        });
    		}
    	},"json");
    }
    
 	// 下载资料
    function downloadFile(){
    	var rows = dataGrid.datagrid("getSelections");
    	if (rows.length == 0) {
   		    $.messager.alert("提示", "请选择一条贷款记录", "error");
   		    return;
   		}
    	window.open('/business/downloadFile?carLoanId=' + rows[0].id);
    }
    
    function upload(){
   		var rows = dataGrid.datagrid("getSelections");
   		if (rows.length == 0) {
   		    $.messager.alert("提示", "请选择一条贷款记录", "error");
   		    return;
   		}
   		if(rows[0].status != '初始录入' && rows[0].status != '已驳回'){
   			$.messager.alert("提示", "当前申请已发起，不能重新上传资料", "error");
   		    return;
   		}
		parent.$.modalDialog({
            title : '上传资料',
            width : 750,
            height : 550,
            resizable : true,
            href : '/business/uploadPage?carLoanId=' + rows[0].id + '&v=' + new Date().getTime()
        });
    }
    
    function changeDate(){
    	var loanTimeStart = $("#loanTimeStart").datetimebox('getValue');
    	var loanTimeEnd = $("#loanTimeEnd").datetimebox('getValue');
    	var loanTimeStartDate = new Date(loanTimeStart);
    	var loanTimeEnd = new Date(loanTimeEnd);
		if(loanTimeStart != '' && loanTimeEnd != '' && loanTimeStartDate > loanTimeEnd){
			$.messager.alert('错误','查询条件矛盾',"error",function(){
				$('.easyui-datetimebox').datetimebox('setValue','');
			});
		}    	
    }
    
    function changeLoanAmount(){
    	var loanAmountMin = $("#loanAmountMin").textbox('getText');
    	var loanAmountMax = $("#loanAmountMax").textbox('getText');
    	if(loanAmountMin != '' && loanAmountMax != '' && Number(loanAmountMin) > Number(loanAmountMax)){
			$.messager.alert('错误','查询条件矛盾',"error",function(){
				$('#loanAmountMin').textbox('setText','');
				$('#loanAmountMax').textbox('setText','');
			});
		} 
    }
    
    function changeLoanTern(){
    	var loanTernMin = $("#loanTernMin").textbox('getText');
    	var loanTernMax = $("#loanTernMax").textbox('getText');
    	if(loanTernMin != '' && loanTernMax != '' && Number(loanTernMin) > Number(loanTernMax)){
			$.messager.alert('错误','查询条件矛盾',"error",function(){
				$('#loanTernMin').textbox('setText','');
				$('#loanTernMax').textbox('setText','');
			});
		} 
    }
    
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
<!--  data-options="region:'north',border:false" style="height: 120px; overflow: hidden;background-color: #fff" -->
	<div class="easyui-panel my-easyui-panel" title="条件查询" data-options="region:'north',border:false" style="margin-bottom:10px;width:100%;height:130px;padding:10px;">
        <form id="searchForm">
        	<div>
        		<span class="query_title">车牌号:</span>
        		<input id="plateNumber" name="plateNumber" class="easyui-combobox" style="width:55px"/>
                <input id="plateNumber2" class="easyui-textbox" style="width:95px"> 
                
                <span class="query_title">车辆型号:</span><input id="vehicleType" class="easyui-textbox" name="vehicleType" style="width:167px">
                
                <span class="query_title">审核状态:</span><input id="status" name="status" class="easyui-combobox" style="width:163px">
            	<span class="query_title">供应商:</span><input id="deptId" class="easyui-combotree" name="deptId" style="width:162px;">
            </div>
            <div>
            	<span class="query_title">申请人:</span><input id="userId" name="userId" class="easyui-combobox" style="width:155px">
            	<span class="query_title">车主/企业名称:</span><input id="ownerName" class="easyui-textbox" name="ownerName" style="width:150px">
            
                <span class="query_title">借款金额:</span>
                <input id="loanAmountMin" name="loanAmountMin" data-options="onChange:changeLoanAmount" class="easyui-numberbox" style="width:73px"> --
                <input id="loanAmountMax" name="loanAmountMax" data-options="onChange:changeLoanAmount" class="easyui-numberbox" style="width:73px"> 元
                
                <span class="query_title">借款期限:</span>
                <input id="loanTernMin" name="loanTernMin" data-options="onChange:changeLoanTern" class="easyui-numberbox" style="width:65px"> --
                <input id="loanTernMax" name="loanTernMax" data-options="onChange:changeLoanTern" class="easyui-numberbox" style="width:65px"> 天
            </div>
            <div>
	            <span class="query_title">申请时间:</span>
	            <input id="loanTimeStart" class="easyui-datetimebox" name="startTime" data-options="onChange:changeDate,showSeconds:false,editable:false" style="width:152px"/> --
                <input id="loanTimeEnd" class="easyui-datetimebox" name="endTime" data-options="onChange:changeDate,showSeconds:false,editable:false" style="width:152px"/>
                <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchFun();">查询</a>
    	        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cleanFun();">清空</a>
            </div>
        </form>
    </div>
    <div data-options="region:'center',border:false"  style="width:550px;overflow: hidden; ">
        <table id="dataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div id="toolbar" style="display: none;">
        <shiro:hasPermission name="/business/add">
            <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">申请贷款</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="/business/upload">
            <a onclick="upload();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-upload'">上传资料</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="/business/downloadFile">
            <a onclick="downloadFile();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-download'">下载资料</a>
        </shiro:hasPermission>
    </div>
    <div id="commentWin" class="easyui-window" title="历史审批" data-options="closed:true"
		style="width: 620px; height: 300px; padding: 5px;">
		<table id="commentGrid"></table>
	</div>
	<div id="voucherWin" class="easyui-window" title="凭证信息" data-options="closed:true"
		style="width: 520px; height: 400px; padding: 5px;">
	</div>
</body>
</html>