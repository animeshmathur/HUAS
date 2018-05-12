
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
	
	String step=request.getParameter("step");
	
%>
<html>

<head>
	<title>Add Relationship</title>
</head>

<body>
<%
if(step.equals("sel_tables"))
{
%>
	<form action=addrelationship.jsp>
		<input type=hidden name=step value=sel_fields>
	<table border=1 cellpadding=5>
		<caption><b><i>CHOOSE TABLES</i></b></caption>
		<tr>
			<td>
				Source Table:  
			</td>
			<td>
				<select name=firsttable>
					<option value=null>--Select Table--</option>
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
			Destination Table:
			</td>
			<td>
				<select name=secondtable>
					<option value=null>--Select Table--</option>
					<%
					rs.close();
					rs=smt.executeQuery(q);
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
				<input type=submit value=Continue>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
	</table>
	</form>
<%
}
else if(step.equals("sel_fields"))
{
	String firsttable=request.getParameter("firsttable");
	String secondtable=request.getParameter("secondtable");
	ses.putValue("firsttable",firsttable);
	ses.putValue("secondtable",secondtable);
%>
	<form action=addrelationshipsubmit.jsp>
		<input type=hidden name=relation_action value=add>
	<table border=0 cellpadding=5>
		<caption>CHOOSE FIELDS</caption>
		<tr>
			<td>
				Source Field:
			</td>
			<td>
				<select name=firstfield>
					<option value=null>--Select Field of Source Table--</option>
					<%
					String q="desc "+firsttable;
					String fieldnm;
					ResultSet rs=smt.executeQuery(q);
					if(rs.next())
					{
						do
						{
							fieldnm=rs.getString(1);
							%>
							<option value=<%=fieldnm%>><%=fieldnm%></option>
							<%
						}while(rs.next());
					}
					%>
				</select>
			</td>
			<td>
				--References-->
			</td>
			<td>
			Destination Field:
			</td>
			<td>
				<select name=secondfield>
					<option value=null>--Select Field of Destination Table--</option>
					<%
					q="desc "+secondtable;
					rs.close();
					rs=smt.executeQuery(q);
					if(rs.next())
					{
						do
						{
							fieldnm=rs.getString(1);
							%>
							<option value=<%=fieldnm%>><%=fieldnm%></option>
							<%
						}while(rs.next());
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=Done>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
	</table>
	</form>
<%
}
else
{
	%>
	Wrong Entry!!!!
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
