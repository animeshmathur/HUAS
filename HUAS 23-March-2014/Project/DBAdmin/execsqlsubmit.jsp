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
	
	String sqlsmt=ses.getValue("sqlstatement").toString();
	
	
%>
<html>
<head>
	<title>SQL</title>
</head>

<body>
	
	<%
	if(sqlsmt.substring(0,6).equals("select")||sqlsmt.substring(0,6).equals("SELECT"))
	{
		response.sendRedirect("execsql.jsp?err=1");
	}
	else
	{
		smt.executeUpdate(sqlsmt);
		response.sendRedirect("execsql.jsp?ack=1");
	}
	%>

</body>

</html>
<%
cn.close();
}
catch(Exception ex)
{
	if(ex.equals("java.sql.SQLException: Can not issue SELECT via executeUpdate()."))
	{
		response.sendRedirect("execsql.jsp?err=1");
	}
	else
	{
		%>
		Error: <%=ex%>
		<%
	}
}
%>

