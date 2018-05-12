<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();
	
	String tableaction=request.getParameter("tableaction");
%>
<html>

<head>
	<title>Table Action</title>
</head>

<body>
	<%
	if(tableaction.equals("desc"))
	{
		String tablenm=request.getParameter("tablenm");
		ses.putValue("tablenm",tablenm);
		%>
			<table border=1 cellpadding=5>
			<caption><h3>'<%=tablenm%>' Description</h3></caption>
			<%
			ResultSet rs=smt.executeQuery("desc "+tablenm);
			String field_name;
			if(rs.next())
			{
				%>
				<th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th><th>Extra</th>
				<%
				do
				{
					field_name=rs.getString(1);
					%>
					<tr>
						<td><%=field_name%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<td><%=rs.getString(6)%></td>
						
						
					</tr>
					<%
				}while(rs.next());
			}
			%>
			</table>
			<br>
				<table>
					<tr>
						<form action=altertable.jsp>
						<input type=hidden name=fieldaction value=addfield>
						<td><input type=submit value="ADD FIELD"></td>
						</form>
					</tr>
					<tr>
						<td>
							<form action=altertable.jsp>
							<input type=hidden name=fieldaction value=modifyfield>
							<input type=submit value="MODIFY FIELD">
							</form>
						</td>
					</tr>
					<tr>
						<td>
							<form action=altertable.jsp>
							<input type=hidden name=fieldaction value=dropfield>
							<input type=submit value="DROP FIELD">
							</form>
						</td>
					</tr>
				</table>
		<%
	}
	else if(tableaction.equals("alter"))
	{
		String tablenm=request.getParameter("tablenm");
		ses.putValue("tablenm",tablenm);
		%>
		<table border=1 cellpadding=5>
			<caption><h3>Alter '<%=tablenm%>'</h3></caption>
			<tr>
				<td>
					<form action=altertable.jsp>
						<input type=hidden name=fieldaction value=modifyfield>
						<input type=submit value="Modify Field">
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<form action=altertable.jsp>
						<input type=hidden name=fieldaction value=primarykey>
						<input type=submit value="Add/Remove Primary Key">
					</form>
				</td>
			</tr>
		</table>
		<%
	}
	else if(tableaction.equals("truncate"))
	{
		%>
		<form action=tableactionsubmit.jsp method=post>
			<input type=hidden name=tableaction value=truncate>
		<table cellpadding=5>
			<caption><h3>Truncate Table</h3></caption>
				<tr>
					<td>
						Select Table:
					</td>
					<td>
						<select name=tablenm>
							<option>--Select Table--</option>
							<%
								String q="show tables";
								String tablenm;
								ResultSet rs=smt.executeQuery(q);
								if(rs.next())
								{
									do
									{
										tablenm=rs.getString(1);
										%>
											<option value=<%=tablenm%>><%=tablenm%></option>
										<%
									}while(rs.next());
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type=submit value=TRUNCATE>
					</td>
					<td>
						<input type=reset>
					</td>
				</tr>
		</table>
		</form>
		<%
	}
	else if(tableaction.equals("drop"))
	{
	%>
		<form action=tableactionsubmit.jsp method=post>
			<input type=hidden name=tableaction value=drop>
		<table cellpadding=5>
			<caption><h3>Drop Table</h3></caption>
				<tr>
					<td>
						Select Table:
					</td>
					<td>
						<select name=tablenm>
							<option>--Select Table--</option>
							<%
								String q="show tables";
								String tablenm;
								ResultSet rs=smt.executeQuery(q);
								if(rs.next())
								{
									do
									{
										tablenm=rs.getString(1);
										%>
											<option value=<%=tablenm%>><%=tablenm%></option>
										<%
									}while(rs.next());
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type=submit value=DROP>
					</td>
					<td>
						<input type=reset>
					</td>
				</tr>
		</table>
		</form>
	<%
	}
	%>

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
