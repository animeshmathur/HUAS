<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
	String newdbnm=request.getParameter("newdbnm");
	
	String q="create database "+newdbnm;
	smt.executeUpdate(q);
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
