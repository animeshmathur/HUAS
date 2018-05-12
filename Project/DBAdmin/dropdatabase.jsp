<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	String dbnm=request.getParameter("dbnm");
	smt.executeUpdate("drop database "+dbnm);
	cn.close();
	response.sendRedirect("showdatabases.jsp");
}
catch(Exception ex)
{
	%>
	<%="Error: "+ex%>
	<%
}
%>
