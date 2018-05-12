<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
%>
<html>

<head>
	<title>Show Databases</title>
</head>

<body>
	Connection Established! :)
	<%
	String ack=request.getParameter("ack");
	if(ack!=null)
	{
		if(ack.equals("adduser"))
		{
			%>
			<font color=green>* User Added Successfully</font>
			<%
		}
	}
	%>
<table border=1 cellpadding=10 cellspacing=5>
<caption><h2>DATABASES</h2></caption>
	<%	
	String q="show databases";
	ResultSet rs=smt.executeQuery(q);
	String dbnm;
	if(rs.next())
	{
		do
		{
			dbnm=rs.getString(1);
			if(dbnm.equals("information_schema")||dbnm.equals("performance_schema")||dbnm.equals("mysql")||dbnm.equals("test"))
			{}
			else
			{
				%>
				<tr>
					<td>
						<a href=databasetables.jsp?dbnm=<%=dbnm%>><%=dbnm%></a>
					</td>
					<td>
						<form action=adddbuser.jsp method=post>
						<input type=hidden name=dbnm value=<%=dbnm%>>
						<input type=submit value="Add User">
						</form>
					</td>
				</tr>
				<%
			}
		}while(rs.next());
	}
	%>
</table>
<br>
<form action=createdatabase.jsp method=post>
	<input type=submit value="Create New Database">
</form>
<br>
<form action=dbusers.jsp method=post>
	<input type=submit value="Show Users">
</form>
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
