<%@ include file="../include_top.jsp"%>
<center>
<h3>&bull; Order Summary &bull;</h3>
<table cellpadding="10px" style="color:#4d4c4c;width:80%;text-align:center;border:#4d4c4c 2px solid;font-size:13px;">
	<tr style="color:#FFFFFF;background-color:#4d4c4c;"><th>S.No.</th><th>Item</th><th>Qty.</th><th>Cost (Rs.)</th></tr>
<%
float total_cost=0;
int item_count=0;
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
ResultSet rs=cnn.createStatement().executeQuery("select * from MART_ORDERS where order_id='"+request.getParameter("orderid")+"'");
if(rs.next())
{
	String item_id[]=rs.getString("order_items").split(",");
	String item_qty[]=rs.getString("order_quantities").split(",");
	String item_price[]=rs.getString("order_prices").split(",");
	String item_name[];
	String mart_db="";
	ResultSet rs1=cnn.createStatement().executeQuery("select mart_db from MART_REGISTER");
	if(rs1.next())
	{
		mart_db=rs1.getString("mart_db");
	}
	rs1.close();
	Connection cnn2=DriverManager.getConnection("jdbc:mysql://localhost/"+mart_db,"hucky","13071992");
	for(int i=0;i<item_id.length;i++)
	{
		item_count++;
		rs1=cnn2.createStatement().executeQuery("select * from item_reg where item_id='"+item_id[i]+"'");
		if(rs1.next())
		{
			float cost=Integer.parseInt(item_price[i])*Integer.parseInt(item_qty[i]);
			%>
			<tr style="color:#4d4c4c;color:#0066cc;font-weight:bold;"><td><%=item_count%>.</td><td><%=rs1.getString("item_name")%></td><td><%=item_qty[i]%></td><td><%=cost%></td></tr>
			<%
			total_cost+=cost;
		}
	}
}
rs.close();
%>
	<tr><td><b>Total</b></td><td></td><td></td><td><b><%=total_cost%></b></td></tr>
</table>
</center>
<%@ include file="../include_bottom.jsp"%>
