<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet" type="text/css" href="/static/style/css/echoapi.css" />
<script type="text/javascript">
    $(function() {
        $('#mortgagorAddForm').form({
            url : '/echoApi/appendMortgagor',
            onSubmit : function() {
                progressLoad();
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
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;overflow-y:scroll;" >
        <form id="mortgagorAddForm" method="post">
        	<span class='mort_title'>借款记录</span>
        	<ul class="mort_data">
        		<li><span class="mort_data_title">姓名</span><input class="easyui-textbox" name="name" style="width:150px"><p></p></li>
        		<li><span class="mort_data_title">身份证号</span><input class="easyui-textbox" name="certNo" style="width:150px"><p></p></li>
        		<li>
        			<span class="mort_data_title">借款时间</span><input class="easyui-textbox" name="loanDate" style="width:150px">
        			<p>通过的，取合同时间;未通过或审核中的，取申请时间。时间格式YYYYMM,YYYYMMDD</p>
        		</li>
        		<li>
        			<span class="mort_data_title">期数</span><input class="easyui-textbox" name="periods" style="width:150px">
        			<p>通过的，取合同期数;未通过或审核中的，取申请期数，范围1~120</p>
        		</li>
        		<li>
        			<span class="mort_data_title">错款金额</span>
        			<select name="loanAmount" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="(0, 1000]">(0, 1000]</option>
                  		<option value="(1000, 5000]">(1000, 5000]</option>
                  		<option value="(5000, 10000]">(5000, 10000]</option>
                  		<option value="(10000, 20000]">(10000, 20000]</option>
                  		<option value="(20000, 50000]">(20000, 50000]</option>
                  		<option value="(50000, 100000]">(50000, 100000]</option>
                  		<option value="(100000, +)">(100000, +)</option>
	                </select>
        			<p>通过的，取合同金额；未通过的或审核中的，取申请金额</p>
        		</li>
        		<li>
        			<span class="mort_data_title">审批结果码</span>
        			<select name="approvalStatusCode" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="201">审核中</option>
                  		<option value="202">批贷已放款</option>
                  		<option value="203">拒货</option>
                  		<option value="204">客户放弃</option>
	                </select>
        			<p>指一笔借款的审批结果。批贷已放款,指通过审核且完成放款的;拒贷,指未能通过审核的;审核中,指处理审核过程中,尚未做出最终决策的,审核通过单尚未放款亦属于审核中;客户放弃,指客户在审核阶段放弃办理业务 </p>
        		</li>
        		<li>
        			<span class="mort_data_title">还款状态码</span>
        			<select name="loanStatusCode" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="">未还款</option>
                  		<option value="301">正常</option>
                  		<option value="302">逾期</option>
                  		<option value="303">结清</option>
	                </select>
        			<p>指一笔借款同当前状态;若历史出现过逾期，当前还款正常，则还款状态取“正常”</p>
        		</li>
        		<li>
        			<span class="mort_data_title">借款类型码</span>
					<select name="loanTypeCode" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="21">信用</option>
                  		<option value="22">抵押</option>
                  		<option value="23">担保</option>
	                </select>
        			<p>指一笔借款所属的业型</p>
        		</li>
        		<li>
        			<span class="mort_data_title">逾期金额</span>
        			<select name="overdueAmount" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="">无</option>
                  		<option value="(0, 1000]">(0, 1000]</option>
                  		<option value="(1000, 5000]">(1000, 5000]</option>
                  		<option value="(5000, 10000]">(5000, 10000]</option>
                  		<option value="(10000, 20000]">(10000, 20000]</option>
                  		<option value="(20000, 50000]">(20000, 50000]</option>
                  		<option value="(50000, 100000]">(50000, 100000]</option>
                  		<option value="(100000, +)">(100000, +)</option>
	                </select>
        			<p>指一笔借款中,达到还款期限,尚未偿还的总金额</p>
        		</li>
        		<li>
        			<span class="mort_data_title">逾期情况值</span>
        			<select name="overdueStatus" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="">没有逾期</option>
                  		<option value="M1">当前逾期1期</option>
                  		<option value="M2">当前逾期2期</option>
                  		<option value="M3">当前逾期3期</option>
                  		<option value="M3+">当前逾期3期以上的，不包含3期</option>
                  		<option value="M4">当前逾期4期</option>
                  		<option value="M5">当前逾期5期</option>
                  		<option value="M6">当前逾期6期</option>
                  		<option value="M6+">当前逾期6期以上的，不包含6期</option>
	                </select>
        			<p>指一笔借款当前逾期的程度</p>
        		</li>
        		<li><span class="mort_data_title">逾期总次数</span><input class="easyui-textbox" name="overdueTotal" style="width:150px">
        		<p>指一笔借款记录中，历史发生过逾期的次数之和(包括当前的逾期);无逾期时可不填写，不应填写0</p></li>
        		<li><span class="mort_data_title">逾期M3+次数</span><input class="easyui-textbox" name="overdueM3" style="width:150px">
        		<p>指一笔借款记录中，历史发生逾期且大于M3次数之和(包括当前的逾期，且>M6的也计入)，即出现过几次M3以上的逾期；无逾期时可不填写，不应填写0</p></li>
        		<li><span class="mort_data_title">逾期M6+次数</span><input class="easyui-textbox" name="overdueM6" style="width:150px">
        		<p>指一笔借款记录中，历史发生逾期且大于M6次数之和(包括当前的逾期)，即出现过几次M6以上的逾期；无逾期是可不填写，不应填写0</p></li>
        	</ul>
        	<span class='mort_title'>风险项记录</span>
        	<ul class="mort_data">
        		<li>
        			<span class="mort_data_title">命中项码</span>
        			<select name="riskItemTypeCode" data-options="panelHeight:'auto',editable:false" style="width:150px" class="easyui-combobox">
                  		<option value="101010">101010</option>
	                </select>
        			<p>如证件号码(当前命中项公包括证件号码)</p>
        		</li>
        		<li><span class="mort_data_title">命中内容</span><input class="easyui-textbox" name="riskItemValue" style="width:150px">
        		<p>身份证号的具体值</p></li>
        		<li><span class="mort_data_title">风险明细</span><input class="easyui-textbox" name="riskDetail" style="width:150px">
        		<p>合作机构提供的借款人的风险类别</p></li>
        		<li><span class="mort_data_title">最近时间</span><input class="easyui-textbox" name="riskTime" style="width:150px">
        		<p>指风险记录最近一次发现的时间</p></li>
        	</ul>
        </form>
    </div>
    
    <a href="http://www.lingmoney.cn/product/list/0_0_0_0_0_1.html"></a>
</div>