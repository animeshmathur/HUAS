<%@include file="shipper_top.jsp"%>
<html>
<head>
<%@include file="shipper_head.jsp"%>
<script>
function acceptShippingRequest(from,to,requester)
{
	$("#td_"+from+"_"+to).html("<img src=\"images/loading.gif\" style=\"height:30px;width:30px;\">");
	$.post("shipper_accept_shipping_request.jsp","order_from="+from+"&order_to="+to+"&requester="+requester,
	function(data,status)
	{
		if(data==1)
		{
			$("#td_"+from+"_"+to).html("<img src=\"images/tick.jpg\" style=\"height:30px;width:30px;\">");
		}
		else
		{
			alert("Sorry! This demand has been expired.");
			$("#td_"+from+"_"+to).html("<font color=\"#FF3333\">Invalid!</font>");
		}
	}
	);
}
</script>
</head>
<body>
<%@include file="shipper_header.jsp"%>
<center>
<h3><span class="heading">Shipping Demands</span></h3>
<%
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_SHIPPINGS","hucky","password").createStatement().executeQuery("select *,concat(shipping_request_to,\"_\",shipping_request_from) as shipping_between from SHIPPING_REQUESTS where shipping_request_status='Awaiting for Shipper'");
if(rs.next())
{
	int count=0;
		do
		{
			if(count==0)
			{
				%>
				<table cellpadding="5" style="width:80%;text-align:center;background-color:#FFFFFF;border:thin solid #4d4c4c;#">
				<th>Shipping From</th><th>Shipping To</th><th>Tender Action</th>
				<%
			}
			ResultSet rs1=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","password").createStatement().executeQuery("select firm_name,firm_address from MANUFACTURER_REGISTER where userid='"+rs.getString("shipping_request_from")+"'");
			ResultSet rs2=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","password").createStatement().executeQuery("select firm_name,firm_address from MERCHANT_REGISTER where userid='"+rs.getString("shipping_request_to")+"'");
			if(rs1.next()&&rs2.next())
			{
				%>
				<tr>
					<td>
						<b><%=rs1.getString("firm_name")%></b><br><i><%=rs1.getString("firm_address")%></i>
					</td>
					<td>
						<b><%=rs2.getString("firm_name")%></b><br><i><%=rs2.getString("firm_address")%></i>
					</td>
					<td id="td_<%=rs.getString("shipping_between")%>">
					<%
					if(!DriverManager.getConnection("jdbc:mysql://localhost/HUAS_SHIPPINGS","hucky","password").createStatement().executeQuery("select * from SHIPPER_ACKNOWLEDGEMENTS where shipping_request_from='"+rs.getString("shipping_request_from")+"' and shipping_request_to='"+rs.getString("shipping_request_to")+"' and request_ack_by='"+uid+"'").next())
					{
						%>
						<button onclick="acceptShippingRequest('<%=rs.getString("shipping_request_to")%>','<%=rs.getString("shipping_request_from")%>','Manufacturer')"><b>Accept</b></button>
						<%
					}
					else
					{
						%>
						<span style="color:#AAAAAA;">&bull; Awaiting for Assignment &bull;</span>
						<%
					}
					%>
					</td>
				</tr>
				<%
			}
			rs1.close();
			rs2.close();
			count++;
		}while(rs.next());
		%>
	</table>
	<%
	if(count==0)
	{
		%>
		<span style="color:#FF3333;"> * No shipping demands available. Please try again later. * </span>
		<%
	}
}
else
{
	%>
	<span style="color:#FF3333;"> * No shipping demands available. Please try again later. * </span>
	<%
}
%>
</center>
<%@include file="shipper_footer.jsp"%>
</body>
</html>
<%@include file="shipper_bottom.jsp"%>
