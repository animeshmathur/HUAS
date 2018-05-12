<%@page import="java.sql.*"%>
<%
try
{
	String dbnm=request.getParameter("dbnm");
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();
	
	HttpSession ses=request.getSession();
	ses.putValue("dbnm",dbnm);
%>
<html>

<head>
	<title>Database Tables</title>
</head>

<body>
	<table border=1 cellpadding=10>
		<caption><h3>'<%=dbnm%>' Tables</h3></caption>
	<%
	
	//smt.executeUpdate("use "+dbnm);
	String q="show tables";
	String tablenm;
	ResultSet rs=smt.executeQuery(q);
	if(rs.next())
	{
		do
		{
			tablenm=rs.getString(1);
			%>
			<tr>
				<td>
					<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>><%=tablenm%></a>
				</td>
				<td>
					<form action=tableaction.jsp method=post>
						<input type=hidden name=tablenm value=<%=tablenm%>>
						<input type=hidden name=tableaction value=alter>
						<input type=submit value=ALTER>
					</form>
				</td>
			</tr>
			<%
		}while(rs.next());
	}
	else
	{
		%>
		<tr><td><%="No Tables Exist"%></td></tr>
		<%
	}
	%>
	</table>
<br>
<table>
	<tr>
		<td>
			<form action=createtable.jsp method=post>
				<input type=hidden name=step value=1>
				<input type=submit value="Create New Table">
			</form>
		</td>
		<td>
			<form action=addrelationship.jsp method=post>
				<input type=hidden name=step value=sel_tables>
				<input type=submit value="Add Relationship">
			</form>
		</td>
		<td>
			<form action=constraintsandrelationships.jsp method=post>
				<input type=hidden name=step value=show>
				<input type=submit value="Relationships & Constraints">
			</form>
		</td>
	</tr>
	<tr>
		<td>
			<form action=tableaction.jsp method=post>
				<input type=hidden name=tableaction value=truncate>
				<input type=submit value="Truncate Table">
			</form>
		</td>
		<td>
			<form action=tableaction.jsp method=post>
				<input type=hidden name=tableaction value=drop>
				<input type=submit value="Drop Table">
			</form>
		</td>
		<td>
			<form action=execsql.jsp>
				<input type=submit value="Execute SQL Statement">
			</form>
		</td>
	</tr>
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
