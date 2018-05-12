<%@ include file="client_top.jsp"%>
<%
String keyword=request.getParameter("keyword");
String searchby=request.getParameter("searchby");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992");
Statement stmt=cnn.createStatement();
%>
<script>
function createOrder(order_to_user,order_to_db,order_to_firm)
{
	closeSearchManufacturerBox();
	$("#orders_area").html("<center><br><br><img src=\"images/loading.gif\"><br><br>Loading...</center>");
	$("#orders_area").load("client_get_order_form.jsp","order_to_user="+order_to_user+"&order_to_db="+order_to_db+"&order_to_firm="+order_to_firm);
	return false;
}
</script>
<table cellpadding="5" style="width:100%;font-size:12px;text-align:center;">
<%
if(searchby.equals("Product"))
{
	%>
	<caption><br><b>Manufacturers of product ' <font color="#c40e0e"><%=keyword%></font> '</b><br><br></caption>
	<%
	ResultSet rs=stmt.executeQuery("select userid,user_db,firm_name,firm_address,firm_contact from MANUFACTURER_REGISTER");
	int count=0;
	if(rs.next())
	{
		do
		{
			cnn.createStatement().execute("use "+rs.getString("user_db"));
			if(cnn.createStatement().executeQuery("select product_name from products where product_name like '%"+keyword+"%'").next())
			{
				count++;
				if(count==1)
				{
					%>
					<tr><th>Name</th><th>Address</th><th>Contact</th><th></th></tr>
					<%
				}
				%>
				<tr><td><b><%=rs.getString("firm_name")%></b></td><td><%=rs.getString("firm_address")%></td><td><%=rs.getString("firm_contact")%></td><td><a href="#" onclick="return(createOrder('<%=rs.getString("userid")%>','<%=rs.getString("user_db")%>','<%=rs.getString("firm_name")%>'));" style="color:#0066CC;">Order</a></td></tr>
				<%
			}
		}while(rs.next());
	}
}
else if(searchby.equals("Name"))
{
	%>
	<caption><br><b>Manufacturers like ' <font color="#c40e0e"><%=keyword%></font> '</b><br><br></caption>
	<%
	ResultSet rs=stmt.executeQuery("select userid,user_db,firm_name,firm_address,firm_contact from MANUFACTURER_REGISTER where firm_name like '%"+keyword+"%'");
	int count=0;
	if(rs.next())
	{
		do
		{
			count++;
			if(count==1)
			{
				%>
				<tr><th>Name</th><th>Address</th><th>Contact</th><th></th></tr>
				<%
			}
			%>
			<tr><td><b><%=rs.getString("firm_name")%></b></td><td><%=rs.getString("firm_address")%></td><td><%=rs.getString("firm_contact")%></td><td><a href="#" onclick="return(createOrder('<%=rs.getString("userid")%>','<%=rs.getString("user_db")%>','<%=rs.getString("firm_name")%>'));" style="color:#0066CC;">Order</a></td></tr>
			<%
		}while(rs.next());
	}
}
%>
</table>
<%
stmt.close();
cnn.close();
%>
<%@ include file="client_bottom.jsp"%>
