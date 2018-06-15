var dataGrid;
var bankGrid;
var linkmanGrid;
var commonBankGrid;
var cooperateId;
$(function() {
    dataGrid = $('#dataGrid').datagrid({
        url : '/cooperate/dataGrid',
        height : 455,
        title : '合作结构',
        border : false,
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        pageSize : 10,
        pageList : [ 10, 15, 20 ],
        columns : [ [ 
            {width : '200', title : '合作机构公司名称', field : 'name'},
            {width : '40', align : 'center',  title : '地区',  field : 'regionName'},
            {width : '125', align : 'center', title : '创建时间', field : 'createTime'},
            {width : '125', title : '状态', field : 'status', 
            	formatter : function(value, row, index) {
	            	switch (value) {
					case 0:
						return '未启用&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'#\' class="cooperate-start-ok" onclick=\'start("' + row.id + '");\'>启用</a>';
					case 1:
						return '<font color="green">已启用</font>';
					}
            	}},
            {width : '125', align : 'center', title : '上次修改时间', field : 'modiTime'},
            {width : '270', align : 'center', title : '操作', field : 'action', 
	            formatter : function(value, row, index) {
	                var str = '';
	                	str += $.formatString('<a href="javascript:void(0)" class="cooperate-bank-search" data-options="plain:true,iconCls:\'icon-search\'" onclick="showBank(\'{0}\');" >查看银行账户</a>', row.id);
	                	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
	                	str += $.formatString('<a href="javascript:void(0)" class="cooperate-linkman-search" data-options="plain:true,iconCls:\'icon-search\'" onclick="showLinkman(\'{0}\');" >查看联系人信息</a>', row.id);
	                return str;
	            }} 
        ] ],
        onLoadSuccess:function(data){
        	$('.cooperate-start-ok').linkbutton({text:'启用',plain:true,iconCls:'icon-ok',plain:false});
        	$('.cooperate-bank-search').linkbutton({text:'查看银行账户',plain:true,iconCls:'icon-search'});
        	$('.cooperate-linkman-search').linkbutton({text:'查看联系人信息',plain:true,iconCls:'icon-search'});
        },
        toolbar : '#toolbar'
    });
    commonBankGrid = $('#commonBankGrid').datagrid({
		url : '/cooperate/commonBankGrid',
		height : 350,
        striped : true,
        title : '公共银行账户',
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        pageSize : 10,
        pageList : [ 10, 20 ],
        columns : [ [ 
            {width : '80', title : '账户类型', field : 'typeName'},
            {width : '200', align : 'center', title : '账户名称', field : 'bankAccountName'}, 
            {width : '160', title : '账户', field : 'bankAccount'},
            {width : '80', title : '银行', field : 'bank'},
            {width : '240', align : 'center', title : '开户行', field : 'bankName'},
            {width : '125', align : 'center', title : '创建时间',field : 'createTime'},
            {width : '120', title : '状态', field : 'status',
	            formatter : function(value, row, index) {
	            	switch (value) {
					case 0:
						return '未启用&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'#\' class="bank-start-ok" onclick=\'startCommonBank("' + row.id + '");\'>启用</a>';
					case 1:
						return '<font color="green">已启用</font>';
					}
	            }
            },
            {width : '120', align : 'center', title : '操作', field : 'action',
	            formatter : function(value, row, index) {
	                var str = '';
	                str +='<shiro:hasPermission name="/cooperate/editBank">';
	                str += $.formatString('<a href="javascript:void(0)" class="bank-edit" data-options="plain:true,iconCls:\'icon-del\'" onclick="editBank(\'{0}\',\'{1}\',\'true\');" >编辑</a>', row.id,row.status);
	                str +='</shiro:hasPermission>';
	                str += '<shiro:hasPermission name="/cooperate/deleteBank">';
	                str += $.formatString('<a href="javascript:void(0)" class="bank-del" data-options="plain:true,iconCls:\'icon-del\'" onclick="delBank(\'{0}\');" >删除</a>', row.id);
	                str += '</shiro:hasPermission>';
	                return str;
	            }
            },
        ] ],
        onLoadSuccess:function(data){
        	$('.bank-del').linkbutton({text:'删除',plain:true,iconCls:'icon-del'});
            $('.bank-edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
            $('.bank-start-ok').linkbutton({text:'启用',plain:true,iconCls:'icon-ok',plain:false});
        },
        toolbar : '#toolbarCommonBank'
	});
});

function editBank(id,status,isCommon){
	if(status == 1){
		$.messager.alert('提示','账户已启用，不能修改！','info'); 
		return;
	}
	parent.$.modalDialog({
        title : '编辑',
        width : 350,
        height : 245,
        href : '/cooperate/editBankPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
            	if(isCommon){
            		parent.$.modalDialog.openner_dataGrid = commonBankGrid;
            	}else{
            		parent.$.modalDialog.openner_dataGrid = bankGrid;
            	}
                var f = parent.$.modalDialog.handler.find('#bankEditForm');
                f.submit();
            }
        } ]
    });
}

function start(id){
	$.post('/cooperate/start',{id : id},function(){
		dataGrid.datagrid('load', {});
	});
}

function searchFun() {
    dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
}
function cleanFun() {
	$('.easyui-textbox').textbox('setText','');
    $(".easyui-combobox").combobox('setValue','');
    dataGrid.datagrid('load', {});
}

function addFun() {
    parent.$.modalDialog({
        title : '添加合作机构',
        width : 350,
        height : 150,
        href : '/cooperate/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#cooperateAddForm');
                f.submit();
            }
        } ]
    });
}

function showLinkman(id){
	cooperateId = id;
	$('#linkmanWin').window('open');
	linkmanGrid = $('#linkmanGrid').datagrid({
		url : '/cooperate/linkmanGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        queryParams : {
			cooperateId : id
		},
        pageSize : 10,
        pageList : [ 10, 20, 30 ],
        columns : [ [ 
            {width : '60', align : 'center', title : '联系人', field : 'linkman'},
            {width : '120', align : 'center', title : '固定电话', field : 'fixedTelphone'},
            {width : '120', align : 'center', title : '手机号', field : 'mobilePhone'},
            {width : '120', align : 'center', title : '传真', field : 'faxPhone'},
            {width : '120', align : 'center', title : '地址', field : 'address'},
            {width : '120', align : 'center', title : '邮箱', field : 'email'},
            {width : '120', align : 'center', title : '添加时间', field : 'createTime'},
            {width : '120', align : 'center', title : '修改时间', field : 'modiTime'},
            {field : 'action', align : 'center', title : '操作', width : '120',
	            formatter : function(value, row, index) {
	                var str = '';
	                str += '<shiro:hasPermission name="/cooperate/editLinkman">';
	                str += $.formatString('<a href="javascript:void(0)" class="cooperate-edit" data-options="plain:true,iconCls:\'icon-edit\'" onclick="editLinkmanFun(\'{0}\');" >编辑</a>', row.id);
	                str += '</shiro:hasPermission>';
	                str += '<shiro:hasPermission name="/cooperate/deleteLinkman">';
	                str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
	                str += $.formatString('<a href="javascript:void(0)" class="cooperate-del" data-options="plain:true,iconCls:\'icon-del\'" onclick="delLinkmanFun(\'{0}\');" >删除</a>', row.id);
	                str += '</shiro:hasPermission>';
	                return str;
	            }
            } 
        ] ],
        onLoadSuccess:function(data){
            $('.cooperate-edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
            $('.cooperate-del').linkbutton({text:'删除',plain:true,iconCls:'icon-del'});
        },
        toolbar : '#toolbarLinkman'
	});
}

function addLinkmanFun(){
	parent.$.modalDialog({
        title : '添加',
        width : 255,
        height : 285,
        href : '/cooperate/addLinkmanPage?cooperateId=' + cooperateId,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = linkmanGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#linkmanAddForm');
                f.submit();
            }
        } ]
    });
}

function delLinkmanFun(id){
	parent.$.messager.confirm('询问', '真的要删除吗？', function(b) {
		if(b){
			$.post('/cooperate/deleteLinkman',{id : id},function(){
	    		linkmanGrid.datagrid('load', {cooperateId : cooperateId});
	    	});
		}
	});
}

function editLinkmanFun(id){
	if (id == undefined) {
        var rows = linkmanGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
    	linkmanGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 255,
        height : 285,
        href : '/cooperate/editLinkmanPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = linkmanGrid;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#linkmanEditForm');
                f.submit();
            }
        } ]
    });
}

function showBank(id){
	cooperateId = id;
	$('#bankWin').window('open');
	bankGrid = $('#bankGrid').datagrid({
		url : '/cooperate/bankGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        queryParams : {
			cooperateId : id
		},
        pageSize : 10,
        pageList : [ 10, 20, 30 ],
        columns : [ [ {
            width : '120',
            align : 'center',
            title : '账户名称',
            field : 'bankAccountName'
        }, {
            width : '120',
            align : 'center',
            title : '账户',
            field : 'bankAccount'
        },{
            width : '80',
            align : 'center',
            title : '银行',
            field : 'bank'
        }, {
            width : '120',
            align : 'center',
            title : '开户行',
            field : 'bankName',
        }, {
            width : '150',
            align : 'center',
            title : '创建时间',
            field : 'createTime',
        },{
            width : '120',
            title : '状态',
            field : 'status',
            formatter : function(value, row, index) {
            	switch (value) {
				case 0:
					return '未启用&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'#\' class="bank-start-ok" onclick=\'startBank("' + row.id + '");\'>启用</a>';
				case 1:
					return '<font color="green">已启用</font>';
				}
            }
        }, {
            field : 'action',
            align : 'center',
            title : '操作',
            width : 120,
            formatter : function(value, row, index) {
                var str = '';
                str +='<shiro:hasPermission name="/cooperate/editBank">';
                str += $.formatString('<a href="javascript:void(0)" class="bank-edit" data-options="plain:true,iconCls:\'icon-del\'" onclick="editBank(\'{0}\',\'{1}\');" >编辑</a>', row.id,row.status);
                str +='</shiro:hasPermission>';
                str +='<shiro:hasPermission name="/cooperate/deleteBank">';
                str += $.formatString('<a href="javascript:void(0)" class="bank-del" data-options="plain:true,iconCls:\'icon-del\'" onclick="delBank(\'{0}\');" >删除</a>', row.id);
                str +='</shiro:hasPermission>';
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.bank-del').linkbutton({text:'删除',plain:true,iconCls:'icon-del'});
            $('.bank-edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
            $('.bank-start-ok').linkbutton({text:'启用',plain:true,iconCls:'icon-ok',plain:false});
        },
        toolbar : '#toolbarBank'
	});
}

function delBank(id){
	parent.$.messager.confirm('询问', '真的要删除吗？', function(b) {
		if(b){
			$.post('/cooperate/deleteBank',{id : id},function(){
				commonBankGrid.datagrid('reload');
	    		bankGrid.datagrid('load', {cooperateId : cooperateId});
	    	});
		}
	});
}

function addBankFun(isCommon){
	if(isCommon){
		parent.$.modalDialog({
            title : '添加',
            width : 350,
            height : 245,
            href : '/cooperate/addBankPage',
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = commonBankGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#cooperateBankAddForm');
                    f.submit();
                }
            } ]
        });
	} else {
		parent.$.modalDialog({
            title : '添加',
            width : 350,
            height : 210,
            href : '/cooperate/addBankPage?cooperateId=' + cooperateId,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = bankGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#cooperateBankAddForm');
                    f.submit();
                }
            } ]
        });
	}
	
}
function startBank(id){
	$.post('/cooperate/startBank',{id : id},function(){
		bankGrid.datagrid('load', {cooperateId : cooperateId});
	});
}

function startCommonBank(id){
	$.post('/cooperate/startBank',{id : id},function(){
		commonBankGrid.datagrid('load', {});
	});
}