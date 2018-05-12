<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession(true);
	String dbuser=ses.getValue("dbuser").toString();
	ses.putValue("dbuser",dbuser);
	String dbpwd=ses.getValue("dbpwd").toString();
	ses.putValue("dbpwd",dbpwd);
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	String firmnm=ses.getValue("firmnm").toString();
	ses.putValue("firmnm",firmnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,dbuser,dbpwd);
	Statement smt=cn.createStatement();
%>
