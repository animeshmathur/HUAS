<%@ include file="../include_top.jsp"%>
<%
String mart_id=ses.getValue("mart_id").toString();
String mart_db=ses.getValue("mart_db").toString();
String selected_item_id[]=request.getParameter("selected_items").split(",");
String selected_item_qty[]=request.getParameter("selected_items_qty").split(",");
String selected_item_cost[]=request.getParameter("selected_items_cost").split(",");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/"+mart_db,"hucky","13071992");
Statement stmt=cnn.createStatement();
double total_cost=0;
int item_count=0;
%>
<center>
<h3>&bull; Order Summary &bull;</h3>
<table cellpadding="10px" style="color:#4d4c4c;width:80%;text-align:center;border:#4d4c4c 2px solid;">
	<tr style="color:#FFFFFF;background-color:#4d4c4c;"><th>S.No.</th><th>Item</th><th>Qty.</th><th>Cost (Rs.)</th></tr>
<%
double cost=0;
ResultSet rs=null;
for(int i=0;i<selected_item_id.length;i++)
{
	rs=stmt.executeQuery("select * from item_reg where item_id='"+selected_item_id[i]+"'");
	if(rs.next())
	{
		item_count++;
		cost=Float.parseFloat(selected_item_cost[i])*Integer.parseInt(selected_item_qty[i]);
		%>
		<tr style="color:#4d4c4c;color:#0066cc;font-weight:bold;"><td><%=item_count%>.</td><td><%=rs.getString("item_name")%></td><td><%=selected_item_qty[i]%></td><td><%=cost%></td></tr>
		<%
		total_cost+=cost;
	}
	//out.println(selected_item_id[i]);
}
cnn.close();
%>
	<tr><td><b>Total</b></td><td></td><td></td><td><b><%=total_cost%></b></td></tr>
</table>
<br>
<table cellpadding="10">
	<tr>
	<td><button onClick="placeOrder('<%=request.getParameter("selected_items_cost")%>');" style="width:160px;color:#FFFFFF;background-color:#FF6600;border:#4d4c4c groove thin;padding:5px 10px;"><b>Place Order</b></button></td>
	<td><button onclick="closeBox('extra_outer_box','extra_inner_box')" style="width:160px;color:#FFFFFF;background-color:#FF2222;border:#4d4c4c groove thin;padding:5px 10px;"><b>Cancel</b></button></td>
</center>
<%@ include file="../include_bottom.jsp"%>

