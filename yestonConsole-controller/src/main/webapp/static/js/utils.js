function formatDatebox(value) {
	if (value == null || value == '') {
		return '';
	}
	var dt = parseToDate(value);// 关键代码，将那个长字符串的日期值转换成正常的JS日期格式
	return dt.format("yyyy-MM-dd"); // 这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法，在后面的步骤3定义
}
function parseToDate(value) {
	if (value == null || value == '') {
		return undefined;
	}

	var dt;
	if (value instanceof Date) {
		dt = value;
	} else {
		if (!isNaN(value)) {
			dt = new Date(value);
		} else if (value.indexOf('/Date') > -1) {
			value = value.replace(/\/Date(−?\d+)\//, '$1');
			dt = new Date();
			dt.setTime(value);
		} else if (value.indexOf('/') > -1) {
			dt = new Date(Date.parse(value.replace(/-/g, '/')));
		} else {
			dt = new Date(value);
		}
	}
	return dt;
}

// 为Date类型拓展一个format方法，用于格式化日期
Date.prototype.format = function(format) // author: meizz
{
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};