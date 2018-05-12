<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/users","hucky","password");
	Statement smt=cn.createStatement();
	
%>
<html>

<head>
	<title>Database Users</title>
</head>

<body>
	<%
	String ack=request.getParameter("ack");
	if(ack!=null)
	{
		if(ack.equals("dropuser"))
		{
			%>
			<font color=green>* User Dropped</font>
			<%
		}
	}
	%>
	<table border=1 cellpadding=5>
		<caption><h3><i>USERS</i></h3></caption>
	<%
	String userid;
	String q="select userid,user_db from user_db_reg";
	ResultSet rs=smt.executeQuery(q);
	if(rs.next())
	{
		%>
		<th>User ID</th><th>Database</th><th>Options</th>
		<%
		do
		{
			userid=rs.getString(1);
			%>
			<tr>
				<td>
					<%=userid%>
				</td>
				<td>
					<%=rs.getString(2)%>
				</td>
				<td>
					<form action=dropdbuser.jsp method=post>
						<input type=hidden name=userid value=<%=userid%>>
						<input type=submit value="Drop">
					</form>
				</td>
			</tr>
			<%
		}while(rs.next());
	}
	else
	{
		%>
		<tr><td><font color=red>No Users Exist</font></td></tr>
		<%
	}
	%>
	</table>
</body>

</html>
<%
cn.close();
}
catch(Exception ex)
{
	%>
	<%="Error: "+ex%>
	<%
}
%>
