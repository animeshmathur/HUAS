<%@ include file="manufacturer_top.jsp"%>
<%
String permission=ses.getValue("orders_permission").toString();
if(permission.equals("true"))
{
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992");
Statement stmt=cnn.createStatement();
ResultSet rs=stmt.executeQuery("select * from MERCHANT_REGISTER");
if(rs.next())
{
	%>
	<table width="88%" cellpadding="10" style="text-align:center;color:#4D4C4C;font-size:15px;font-weight:bold;">
	<tr><th>Firm</th><th>Address</th><th>Contact No.</th></tr>
	<%
	do
	{
		%>
		<tr><td><span style="color:#0066CC;font-size:16px;"><b><%=rs.getString("firm_name")%></b></span></td><td> <i><%=rs.getString("firm_address")%></i></td><td><i><%=rs.getString("firm_contact")%></i></td></tr>
		<%
	}while(rs.next());
	%>
	</table>
	<%
}
}
%>
<%@ include file="manufacturer_bottom.jsp"%>
