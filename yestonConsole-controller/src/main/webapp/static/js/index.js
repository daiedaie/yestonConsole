var index_layout;
var index_tabs;
var layout_west_tree;

$(function() {
	index_layout = $('#index_layout').layout({
		fit : true
	});
	index_tabs = $('#index_tabs').tabs(
			{
				fit : true,
				border : false,
				tools : [
						{
							iconCls : 'icon-home',
							handler : function() {
								index_tabs.tabs('select', 0);
							}
						},
						{
							iconCls : 'icon-refresh',
							handler : function() {
								var index = index_tabs.tabs('getTabIndex',
										index_tabs.tabs('getSelected'));
								index_tabs.tabs('getTab', index).panel('open')
										.panel('refresh');
							}
						},
						{
							iconCls : 'icon-del',
							handler : function() {
								var index = index_tabs.tabs('getTabIndex',
										index_tabs.tabs('getSelected'));
								var tab = index_tabs.tabs('getTab', index);
								if (tab.panel('options').closable) {
									index_tabs.tabs('close', index);
								}
							}
						} ]
			});
	
	generateNav();
});

function addTab(title, href, icon) {
	var tt = $('#index_tabs');
	icon = icon || 'menu_icon_service';
	if (tt.tabs('exists', title)) {
		tt.tabs('select', title);
		var currTab = tt.tabs('getTab', title);
		tt.tabs('update', {
			tab : currTab,
			options : {
				content : content,
				closable : true
			}
		});
	} else {
		if (href) {
			var content = '<iframe frameborder="0" src="' + href
					+ '" style="border:0;width:100%;height:99.5%;"></iframe>';
		} else {
			var content = '未实现';
		}
		tt.tabs('add', {
			title : title,
			content : content,
			closable : true,
			iconCls : icon
		});
	}
}

function logout() {
	$.messager.confirm('提示', '确定要退出?', function(r) {
		if (r) {
			progressLoad();
			$.post('/logout', function(result) {
				if (result.success) {
					progressClose();
					window.location.href = '/';
				}
			}, 'json');
		}
	});
}

function editUserPwd() {
	parent.$.modalDialog({
		title : '修改密码',
		width : 300,
		height : 250,
		href : '/user/editPwdPage',
		buttons : [ {
			text : '确定',
			handler : function() {
				var f = parent.$.modalDialog.handler.find('#editUserPwdForm');
				f.submit();
			}
		} ]
	});
}