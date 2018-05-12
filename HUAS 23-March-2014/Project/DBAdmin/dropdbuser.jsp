
<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
	String userid=request.getParameter("userid");
%>
<html>

<head>
	<title>Drop User</title>
</head>

<body>
	
<%
String q1="REVOKE ALL PRIVILEGES, GRANT OPTION FROM '"+userid+"'@'localhost'";
smt.executeUpdate(q1);
String q2="drop user '"+userid+"'@'localhost'";
smt.executeUpdate(q2);
String q3="delete from users.user_db_reg where userid='"+userid+"'";
smt.executeUpdate(q3);
cn.close();
response.sendRedirect("dbusers.jsp?ack=dropuser");
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
