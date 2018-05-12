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
	
	String tablenm=request.getParameter("tablenm");
	String tableaction=request.getParameter("tableaction");
%>
<html>

<head>
	<title>Table Action</title>
</head>

<body>
	
<%
	if(tableaction.equals("truncate"))
	{
		String q="truncate table "+tablenm;
		smt.executeUpdate(q);
		%>
		Table Truncated... <a href=databasetables.jsp?dbnm=<%=dbnm%>>Continue</a>
		<%
	}
	else if(tableaction.equals("drop"))
	{
		String q="drop table "+tablenm;
		smt.executeUpdate(q);
		%>
		Table Dropped... <a href=databasetables.jsp?dbnm=<%=dbnm%>>Continue</a>
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
