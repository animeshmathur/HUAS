<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
	HttpSession ses=request.getSession();
%>
<html>

<head>
	<title>Create Database</title>
</head>

<body>
	<form action=createdatabasesubmit.jsp>
<table>
	<caption><h3>Create Database</h3></caption>
	<tr><td>New Database Name: </td><td><input type=text name=newdbnm></td></tr> <!newdbnm is new DB name>
	<tr><td><input type=submit value=Create></td><td></td></tr>
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
