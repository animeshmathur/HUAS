<%@ include file="manufacturer_top.jsp"%>
<%
ses.putValue("orders_permission","true");
%>
<html>
<head>
<%@ include file="manufacturer_head.jsp"%>	
<style>
#orders_left
{
	width:16%;
	border-right:#4d4c4c groove thin;
	float:left;
}
#orders_right
{
	width:82%;
	float:left;
}
.left_buttons
{
	background-color:#4d4c4c;
	height:50px;
	width:80%;
	border:solid #4D4C4C thin;
	color:#FFFFFF;
	font-weight:bold;
	font-size:14px;
}
</style>
<script>
function exploreMerchants()
{
	$("#explore_merchants_block").css("visibility","visible");
	$("#merchants_list").load("manufacturer_explore_merchants.jsp");
}
function closeBox(outerid,innerid)
{
	$("#"+outerid).css("visibility","hidden");
	$("#"+innerid).html("<br><br><img src=\"images/loading.gif\"><br><br><h3>Loading...</h3>");
}
function setOrderStatus(order)
{
	//alert(order);
	new_status=document.getElementById('new_order_status_'+order).value;
	if(new_status=="In Progress"||new_status=="Dispatched"||new_status=="Rejected"&&new_status!="-1")
	{
		if(confirm("Confirm... ?"))
		{
			$.post("manufacturer_change_order_status_submit.jsp","order="+order+"&new_status="+new_status);
			$("#order_current_status_"+order).html(new_status);
			if(new_status=="Dispatched")
			$("#td_"+order).html("<font color=\"#006600\">Dispatched</font>");
			else if(new_status=="Rejected")
			$("#td_"+order).html("<font color=\"#FF3333\">Rejected</font>");
			alert("Order status has been changed!");
		}
		else
		{
			new_status="-1";
		}
	}
	return false;
}

function removeOrder(order)
{
	if(confirm("Removing order entry... Continue?"))
	{
		$.post("manufacturer_delete_order.jsp","order="+order);
		$("#order_"+order).fadeOut();
		$("#order_"+order).remove();
	}
}

function getOrders(orderer,orderernm)
{
	//$("#orders_list").html("<br><br><img src=\"images/loading.gif\"><br><br><b>Loading...</b>");
	$("#orders_box").css("visibility","visible");
	$("#orders_list").load("manufacturer_get_orders.jsp","orderer="+orderer+"&orderernm="+orderernm);
}
</script>
</head>
<body>
<%@ include file="manufacturer_header.jsp"%>
<center>
<h2>Orders</h2>
<div id="orders_left">
<button id="explore_merchants_button" class="left_buttons" onclick="exploreMerchants();">
<i>Explore Merchants</i>
</button>
</div>
<div id="orders_right">
<%
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992").createStatement().executeQuery("select order_from from PRODUCT_ORDERS where order_to='"+dbuser+"' group by order_from");
if(rs.next())
{
	%>
	<table cellpadding="10" style="font-size:14px;text-align:center;width:88%;border:thick groove #4d4c4c;background-color:#FFFFFF;">
	<tr><th>Merchant</th><th></th></tr>
	<%
	do
	{
		ResultSet rs1=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992").createStatement().executeQuery("select firm_name,firm_address,firm_contact from MERCHANT_REGISTER where userid='"+rs.getString("order_from")+"'");
		if(rs1.next())
		{
		%>
		<tr>
			<td>
			<span style="color:#c40e0e;"><b><%=rs1.getString("firm_name")%></b></span><br><span style="font-size:13px;"><i><%=rs1.getString("firm_address")%><br>Contact: <%=rs1.getString("firm_contact")%></i></span>
			</td>
			<td>
				<button onclick="getOrders('<%=rs.getString("order_from")%>','<%=rs1.getString("firm_name")%>')">View Orders</button>
			</td>
		</tr>
		<%
		}
		rs1.close();
	}while(rs.next());
}
%>
</div>
<div id="explore_merchants_block" style="padding:10px;width:60%;height:460px;position:fixed;top:100px;left:16%;border:double #AAAAAA thick;border-radius:20px;background-color:#FFFFFF;visibility:hidden;">
<button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:#E5E5E5 solid thin;" onclick="closeBox('explore_merchants_block','merchants_list');" title="Close">x</button>
<h4>:: Merchants ::</h4>
<div id="merchants_list" style="width:100%;height:380px;overflow-y:scroll;">
<img src="images/loading.gif"><br><br><h3>Loading...</h3>
</div>
</div>
<div id="orders_box" style="padding:10px;width:88%;height:460px;position:fixed;top:100px;left:50px;border:double #AAAAAA thick;border-radius:20px;background-color:#FFFFFF;visibility:hidden;">
<button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:#E5E5E5 solid thin;" onclick="closeBox('orders_box','orders_list');" title="Close">x</button><br><br>
<div id="orders_list" style="width:100%;height:400px;overflow-y:scroll;"><br><br><img src="images/loading.gif"><br><br><b>Loading...</b></div>
</div>
</center>
<%@ include file="manufacturer_footer.jsp"%>
</body>
</html>
<%@ include file="manufacturer_bottom.jsp"%>
