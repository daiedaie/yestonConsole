
/**
 * 更改任务状态
 * @param id
 * @returns 
 */
function submitStatus(id, obj){
	 $.messager.confirm("操作提示", "您确定要更改任务状态吗？", function (data) { 
         if (data) {  
         	var status=$(obj).find('option:selected').val();
         	if(status != null && status != ""){
         		$.ajax({
         	        type: "post",
         	        url: '/schedule/changeJobStatus',
         	        data: {
         	        	jobId:id,
         	        	status:status
         	            },
         	        dataType: "json",
         	        success: function(data){
         	        	if(data.code==500){
         	        		$.messager.alert('提示', '状态更改失败', data.msg);
         	        	}else{
         	        		$.messager.alert('提示', '状态更改成功', 'info');
             	        	dataGrid.datagrid('reload',{});
         	        	}
         	        	
         	         }
         	    });
         	}else{
         		$.messager.alert('提示', '请选择状态！', 'info');
         	}
             
         }  
         else {  
            
         }  
     }); 
	
	
}

/**
 * 更改单元格显示
 * @param val
 * @param id
 * @param cmd 0-显示为可编辑  1-显示为值
 */
function changeCron(val,id,cmd){
	var displayStr="";
	var displayVal= '<span>'+val+'<span>&nbsp;&nbsp;<input id="changeCron'+id+'" type="button" value="修改" onclick="changeCron(\''+val+'\',\''+id+'\',0)"/>';
	var displaySubmit='<input id="cronExpression'+id+'" style="width: 100px;" name="cronExpression" value=\''+val+'\' type="text" class="easyui-validatebox" data-options="required:true,validType:[\'length[0,255]\']">&nbsp;&nbsp;<input id="changeCron'+id+'" type="button" value="确认" onclick="submitCron(\''+id+'\')"/>&nbsp;<input id="cancelCron'+id+'" type="button" value="取消" onclick="changeCron(\''+val+'\',\''+id+'\',1)"/>';
	if(cmd==0){
		//此时修改单元格显示为 用户修改提交
		displayStr=displaySubmit;
	}else if(cmd==1){
		//此时修改单元格显示为 显示时间值
		displayStr=displayVal;
	}
	$('#cronDiv'+id).html(displayStr);
}

/**
 * 提交时间表达式
 */
function submitCron(id){
	var val=$('#cronExpression'+id).val();
	$.messager.confirm("操作提示", "您确定要提交时间表达式吗？", function (data) { 
        if (data) {  
        	if(val!=null&&val!=""){
        		$.ajax({
        	        type: "post",
        	        url: '/schedule/updateCron',
        	        data: {
        	        	jobId:id,
        	        	cron:val
        	            },
        	        dataType: "json",
        	        success: function(data){
        	        	//重新加载datagrid
        	        	if(data.code==500){
         	        		$.messager.alert('提示', '时间表达式更改失败', data.msg);
         	        	}else{
         	        		$.messager.alert('提示', '时间表达式更改成功', 'info');
         	        	}
        	        	dataGrid.datagrid('reload',{});
        	         }
        	    });
        	}else{
        		$.messager.alert('提示', '时间表达式不可为空！', 'info');
        	}
        }  
        else {  
           
        }  
    }); 
	
}


/**
 * 调用编辑窗口
 * @param id
 */
function editFun(id) {
    if (id == undefined) {
       var rows = dataGrid.datagrid('getSelections');
       if(rows.length == 0){
    	   parent.$.messager.alert('提示', '请选择要编辑的记录', 'info');
    	   return;
       }
       id = rows[0].id;
    } else {
    	dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '修改计划任务',
        width : 550,
        height : 300,
        href : '/schedule/scheduleEdit?jobId=' + id + '',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#scheduleEditForm');
                f.submit();
            }
        } ]
    });
}

/**
 * 加载添加页
 */
function addFun() {
	parent.$.modalDialog({
		title : '添加计划任务',
		width : 600,
		height : 350,
		href : '/schedule/scheduleAdd',
		buttons : [ {
			text : '添加',
			handler : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
				var f = parent.$.modalDialog.handler.find('#scheduleAddForm');
				f.submit();
			}
		} ]
	});
}

/**
 * 查询
 */
function searchFun() {
	dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
}
/**
 * 清空
 */
function cleanFun() {
	$('#searchForm input').val('');
	dataGrid.datagrid('load', {});
}

function executeNow() {
	var row = $("#scheduleDataGrid").datagrid("getSelected");
	$.messager.confirm('提示', '确定要执行吗?', function(flag) {
		if(flag) {
			$.ajax({
				url:'/schedule/executeJobNow',
				data:{'jobId':row.jobId},
				type:'post',
				success:function(data) {
					$.messager.alert('提示', data.msg, 'info');
				}
			});
		}
	});
}

function pauseJob() {
	var row = $("#scheduleDataGrid").datagrid("getSelected");
	$.messager.confirm('提示', '确定要暂停吗?', function(flag) {
		if(flag) {
			$.ajax({
				url:'/schedule/pauseJob',
				data:{'jobId':row.jobId},
				type:'post',
				success:function(data) {
					if(data.code == 200) {
						$.messager.alert('提示', data.msg, 'info');
						$("#scheduleDataGrid").datagrid('reload');
					} else {
						$.messager.alert('提示', data.msg, 'info');
					}
				}
			});
		}
	});
}

function resumeJob() {
	var row = $("#scheduleDataGrid").datagrid("getSelected");
	$.messager.confirm('提示', '确定要恢复吗?', function(flag) {
		if(flag) {
			$.ajax({
				url:'/schedule/resumeJob',
				data:{'jobId':row.jobId},
				type:'post',
				success:function(data) {
					$.messager.alert("提示", data.msg);
					if(data.code == 200) {
						$.messager.alert('提示', data.msg, 'info');
						$("#scheduleDataGrid").datagrid('reload');
					} else {
						$.messager.alert('提示', data.msg, 'info');
					}
				}
			});
		}
	});
}

function editSchedule() {
	var row = $("#scheduleDataGrid").datagrid("getSelected");
	if (row != null) {
		$("#scheduleEditForm").form("load", row);
		$("#editScheduleDialog").dialog("open");
	} else {
		$.messager.alert("提示", "请先选择一条数据", "info");
	}
}

function editConfirm() {
	$.ajax({
		url : "/schedule/editSchedule",
		type : "post",
		data : $("#scheduleEditForm").serialize(),
		success : function (data) {
			$.messager.alert("提示", data.msg);
			if (data.code == 200) {
				$("#scheduleDataGrid").datagrid('reload');
				$("#scheduleEditForm").form("clear");
				$("#editScheduleDialog").dialog("close");
			}
		}
	});
}

function editCancel() {
	$("#scheduleEditForm").form("clear");
	$("#editScheduleDialog").dialog("close");
}

function removeSchedule() {
	var row = $("#scheduleDataGrid").datagrid("getSelected");
	if (row != null) {
		$.messager.confirm('提示', '确定要删除吗?', function(flag) {
			if(flag) {
				$.ajax({
					url : '/schedule/removeSchedule',
					type : 'post',
					data : {"jobId" : row.jobId},
					success : function (data) {
						if (data.code == 200) {
							$("#scheduleDataGrid").datagrid('reload');
						}
					}
				});
			}
		});
	} else {
		$.messager.alert("提示", "请先选择一条数据", "info");
	}
}

//格式化时间信息  
function formatTime(value, rows) {    
    var date = new Date(value);  
    var y = date.getFullYear();    
    var m = date.getMonth() + 1;    
    m = m < 10 ? ('0' + m) : m;    
    var d = date.getDate();    
    d = d < 10 ? ('0' + d) : d;    
    var h = date.getHours();  
    h = h < 10 ? ('0' + h) : h;  
    var minute = date.getMinutes();  
    var second = date.getSeconds();  
    minute = minute < 10 ? ('0' + minute) : minute;    
    second = second < 10 ? ('0' + second) : second;   
    return y + '/' + m + '/' + d+' '+h+':'+minute+':'+second;    
};  
