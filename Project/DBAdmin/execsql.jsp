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
	
	String sqlstatement=request.getParameter("sqlsmt");
	String err=request.getParameter("err");
	String ack=request.getParameter("ack");
	
%>
<html>

<head>
	<title>SQL</title>
</head>

<body>
	<%
	if(sqlstatement!=null)
	{
		ses.putValue("sqlstatement",sqlstatement);
		response.sendRedirect("execsqlsubmit.jsp");
	}
	
	
	if(err!=null)
	{
		if(err.equals("0"))
		{	
			%>
			<font color=red>* Enter a valid SQL Statement</font>
			<%
		}
		else if(err.equals("1"))
		{
			%>
			<font color=red>* Select Statement Not Allowed</font>
			<%
		}
	}
	
	if(ack!=null)
	{
		if(ack.equals("1"))
		{
			%>
			<font color=green>* Execution Completed.</font>
			<%
		}
	}
	%>
	<form action=execsql.jsp method=post>
	<table cellpadding=5>
		<caption><h3><i>Execute SQL</i></h3></caption>
		<tr>
			<td>
				Enter Statement (<i>without semicolon(;)</i>) :
			</td>
			<td>
				<input type=text name=sqlsmt> 
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=Execute>
			</td>
		</tr>
	</table>
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

