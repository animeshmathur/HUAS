<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession(true);
	String firmnm=ses.getValue("firmnm").toString();
	ses.putValue("firmnm",firmnm);
	String uid=ses.getValue("uid").toString();
	String pwd=ses.getValue("pwd").toString();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS",uid,pwd);
	Statement smt=cn.createStatement();
%>
