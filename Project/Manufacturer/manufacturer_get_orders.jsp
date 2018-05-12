<%@include file="manufacturer_top.jsp"%>
<%
String orderer=request.getParameter("orderer");
String orderer_nm=request.getParameter("orderernm");
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992").createStatement().executeQuery("select *,concat(day(order_time),\"-\",month(order_time),\"-\",year(order_time)) as order_date from PRODUCT_ORDERS where order_to='"+dbuser+"' and order_from='"+orderer+"'");
if(rs.next())
{
	%>
	<h3>Orders from ' <span style="color:#4d4c4c;"><%=orderer_nm%></span> '</h3>
	<table cellpadding="10" style="font-size:14px;text-align:center;width:88%;background-color:#FFFFFF;">
	<tr><th>Product</th><th>Quantity</th><th>Status</th><th>Ordered On</th><th>Expecting Delivery On</th><th>Change Status</th></tr>
	<%
	do
	{
		%>
		<tr id="order_<%=rs.getString("order_id")%>">
			<td>
				<%
				ResultSet rs1=smt.executeQuery("select product_name from products where product_id='"+rs.getString("product_id")+"'");
				if(rs1.next())
				{
					out.print("<b>"+rs1.getString("product_name")+"</b>");
				}
				rs1.close();
				%>
			</td>
			<td><b><%=rs.getString("product_quantity")%></b></td>
			<td>
				<span id="order_current_status_<%=rs.getString("order_id")%>">
				<%
				if(rs.getString("order_status").equals("Revoked"))
				{
					%>
					<font color="#FF0000"><%=rs.getString("order_status")%></font>
					<%
				}
				else
				{
					%>
					<%=rs.getString("order_status")%>
					<%
				}
				%>
				</span>
			</td>
			<td><%=rs.getString("order_date")%></td>
			<td><%=rs.getString("order_delivery_date")%></td>
			<td id="td_<%=rs.getString("order_id")%>">
				<%
				if(rs.getString("order_status").equals("Revoked"))
				{
					%>
					<button style="color:#FF5555;background-color:#FFFFFF;font-size:13px;padding:2px 5px;" title="Remove Entry" onclick="removeOrder('<%=rs.getString("order_id")%>');">x</button>
					<%
				}
				else if(rs.getString("order_status").equals("Dispatched"))
				{
					%>
					<font color="#006600">Dispatched</font>
					<%
				}
				else if(rs.getString("order_status").equals("Rejected"))
				{
					%>
					<font color="#FF3333">Rejected</font>
					<%
				}
				else
				{
					%>
					<select id="new_order_status_<%=rs.getString("order_id")%>">
						<option value="-1">--- New Status ---</option>
						<option value="In Progress" style="color:#FF6600;" onclick="setOrderStatus('<%=rs.getString("order_id")%>')">In Progress</option>
						<option value="Dispatched" style="color:#336633;" onclick="setOrderStatus('<%=rs.getString("order_id")%>')">Dispatched</option>
						<option value="Rejected" style="color:#FF3333;" onclick="setOrderStatus('<%=rs.getString("order_id")%>')">Reject</option>
					</select>
					<%
				}
				%>
			</td>
		</tr>
		<%
	}while(rs.next());
	%>
	</table>
	<%
}
%>
<%@include file="manufacturer_bottom.jsp"%>
