<%@ include file="include_top.jsp"%>
<html>
<head>
<%@ include file="head.jsp"%>
<script>
function viewOrder(orderid)
{
	openBox('extra_outer_box','extra_inner_box','E-Mart/mart_view_order.jsp','orderid='+orderid);
	return false;
}
</script>
<style>
#carts_area
{
	width:100%;
}
.mart_name
{
	color:#0066CC;
	font-weight:bold;
}
</style>
</head>
<body>
<%@ include file="include_header.jsp"%>
<center>
<div id="carts_area">
	<h3><span class="orange_color">::</span> My Carts <span class="orange_color">::</span></h3>
		<%
		Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
		ResultSet rs=cnn.createStatement().executeQuery("select *,concat(day(order_time),\"-\",month(order_time),\"-\",year(order_time),\" at \",time(order_time)) as order_at from MART_ORDERS where MART_ORDERS.order_from='"+userid+"'");
		if(rs.next())
		{
			%>
			<table cellpadding="10" style="color:#4d4c4c;width:98%;font-size:13px;border:#0066CC solid thin;font-weight:bold;">
			<tr style="background-color:#0066CC;color:#FFFFFF;"><th>Cart of Mart</th><th>Carted On</th><th>Cart Status</th><th>View Cart</th></tr>
			<%
			do
			{
				ResultSet rs1=cnn.createStatement().executeQuery("select mart_name from MART_REGISTER where mart_id='"+rs.getString("order_to_mart_id")+"'");
				if(rs1.next())
				{
					%>
					<tr><td><span class="mart_name"><%=rs1.getString("mart_name")%></span></td><td><%=rs.getString("order_at")%></td><td><span style="color:#006600"><%=rs.getString("order_status")%></span></td><td><a href="#" onclick="return(viewOrder('<%=rs.getString("order_id")%>'))"><img src="images/cart.bmp" height="30px" title="Click here to view"></a></td></tr>
					<%
				}
			}while(rs.next());
			%>
			</table>
			<%
		}
		else
		{
			%>
			<span style="color:#FF3333;">------  * No carts available *  -------</span>
			<%
		}
		%>
		<br><br>
			<b><a href="e-marts.jsp" style="font-size:20px;color:#0066CC;">Go shopping @ E-Marts -&gt;</a></b>
</div>
</center>
<%@ include file="include_footer.jsp"%>		
</body>
</html>
<%@ include file="include_bottom.jsp"%>

