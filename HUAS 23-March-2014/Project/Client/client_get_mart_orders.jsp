<%@ include file="client_top.jsp"%>
<h3>Orders from E-Mart</h3>
<script>
function viewOrderDetails(orderid)
{
	openBox("extra_outer_box","extra_inner_box","client_mart_get_order_details.jsp","orderid="+orderid);
}

function setMartOrderStatus(new_status,orderid)
{
	if(confirm("Change order status to '"+new_status+"' ?"))
	{
		closeBox("extra_outer_box","extra_inner_box");
		$.post("client_mart_set_order_status.jsp","new_status="+new_status+"&orderid="+orderid,
		function(data,status)
		{
			$("#status_of_"+orderid).html("<b>"+new_status+"</b>");
		}
		);
	}
}
</script>
<%
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
Statement stmt=cnn.createStatement();
String mart_id="";
ResultSet rs=stmt.executeQuery("select mart_id from MART_REGISTER where mart_userid='"+dbuser+"'");
if(rs.next())
{
	mart_id=rs.getString("mart_id");
}
rs.close();
rs=stmt.executeQuery("select order_id,order_from,concat(day(order_time),\"-\",month(order_time),\"-\",year(order_time),\" at \",time(order_time)) as order_date,order_status from MART_ORDERS where order_to_mart_id='"+mart_id+"' order by order_time");
if(rs.next())
{
	int count=1;
	%>
	<table cellpadding="10px" style="width:88%;background-color:#FFFFFF;font-size:13px;text-align:center;border:#4d4c4c thick groove;">
	<tr><th>S.No.</th><th>From</th><th>Date</th><th>Status</th><th>Orders</th></tr>
	<%
	Statement stmt2=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","hucky","13071992").createStatement();
	ResultSet rs1=null;
	do
	{
		rs1=stmt2.executeQuery("select user_name,concat(user_address,\", \",user_city,\" - \",user_pincode) as user_add,user_contact from user_register where userid='"+rs.getString("order_from")+"'");
		if(rs1.next())
		{
			%>
			<tr>
				<td><%=count%>.</td>
				<td style="text-align:left;">
					<b><%=rs1.getString("user_name")%></b><br>
					<i><%=rs1.getString("user_add")%></i><br>
					Contact: <i><%=rs1.getString("user_contact")%></i>
				</td>
				<td><%=rs.getString("order_date")%></td>
				<td id="status_of_<%=rs.getString("order_id")%>"><b><%=rs.getString("order_status")%></b></td>
				<td><button onclick="viewOrderDetails('<%=rs.getString("order_id")%>')">View</button></td>
			</tr>
			<%
			rs1.close();
		}
		count++;
	}while(rs.next());
	%>
	</table>
	<%
}
cnn.close();
%>
<div id="extra_outer_box" style="background-color:#FFFFFF;height:80%;width:60%;border:#4d4c4c solid 3px;border-radius:5px;position:fixed;top:10%;left:15%;visibility:hidden;border-radius:10px;">
	<button style="color:#FF6600;float:right;font-size:13px;border:0;padding:5px;" onclick="closeBox('extra_outer_box','extra_inner_box');" title="Close">x</button>
	<div id="extra_inner_box" style="width:100%;height:92%;overflow-y:scroll;"><center><br><br><img src="images/loading.gif"><br><br><h3>Loading...</h3></center></div>
</div>
<%@ include file="client_bottom.jsp"%>
