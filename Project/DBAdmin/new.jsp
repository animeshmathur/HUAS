<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
%>
<html>

<head>
	<title>Create Database</title>
</head>

<body>
	

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
