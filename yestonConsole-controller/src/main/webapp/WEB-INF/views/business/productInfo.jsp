<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	loadData();
    });
    function loadData(){
    	$.post("/business/getProductInfo",{id:"${id}",businessType:"${businessType}"},function(result){
    		$("#productName").html(result.productInfo.productName);
    		$("#productCode").html(result.productInfo.productCode);
    		$("#fixedDays").html(result.productInfo.fixedDays + '天');
    		
    		$("#fixedYield").html((Number(result.productInfo.fixedYield) * 100).toFixed(2) + "%");
    		$("#raiseMoney").html((Number(result.productInfo.raiseMoney)).toFixed(2) + '元');
    		
    		$("#reachMoney").html(result.productInfo.reachMoney + '元');
    		for(var i in result.trad){
    			var buyTime = Number(result.trad[i].buyTime.year) + 1900 + "-" + 
    			(Number(result.trad[i].buyTime.month) + 1) + "-" + 
    			result.trad[i].buyTime.date + " " + 
    			result.trad[i].buyTime.hours + ":" + 
    			result.trad[i].buyTime.minutes;
    			$("#data").append("<tr class='tt'><td>" + result.trad[i].tradingId + "</td>" +
    				"<td>" + result.trad[i].productName + "</td>" +
    				"<td>" + result.trad[i].usersId + "</td>" +
    				"<td>" + result.trad[i].usersName + "</td>" +
    				"<td>" + result.trad[i].usersTelephone + "</td>" +
    				"<td>" + result.trad[i].financialMoney + "</td>" +
    				"<td>" + buyTime + "</td>");
    		}
    	},'json');
    }
    function reload(){
    	$(".tt").empty();
    	loadData();
    }
</script>
<style>
.centerInfo{
	text-align:left;
	line-height:40px;
	font-weight:bold
}
</style>
<div class="easyui-layout" data-options="fit:true,border:false,overflow-y: scroll" >
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
    <a href="#" class="easyui-linkbutton" onclick="reload()" data-options="iconCls:'icon-reload','plain':true">刷新</a>  
         <table class="grid">
             <tr>
                 <td width="90px">产品名称</td>
                 <td id="productName" width="200px"></td>
                 <td >产品代码</td>
                 <td id="productCode" ></td>
                 <td >产品固定天数</td>
                 <td id="fixedDays"></td>
             </tr>
             <tr >
                 <td>固定收益率</td>
                 <td id="fixedYield"></td>
                 <td>募集规模</td>
                 <td id="raiseMoney"></td>
                 <td>已募集的金额</td>
                 <td id="reachMoney" ></td>
             </tr>
         </table>
         <div class="centerInfo">购买人的记录</div>
         <table id="data" class="grid">
         	<tr>
         		<td>交易Id</td>
         		<td>产品名称</td>
         		<td>用户Id</td>
         		<td>用户姓名</td>
         		<td>用户手机号</td>
         		<td>理财金额</td>
         		<td>购买时间</td>
         	</tr>
         </table>
    </div>
</div>