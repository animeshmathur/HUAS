<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992");
	Statement smt=cn.createStatement();
	
	String uid=request.getParameter("uid");
	String pwd=request.getParameter("pwd");
	
	String q="select * from MANUFACTURER_REGISTER where userid='"+uid+"' and user_pwd='"+pwd+"'";
	ResultSet rs=smt.executeQuery(q);
	if(rs.next())
	{
		String dbuser=rs.getString(1);
		String dbpwd=rs.getString(2);
		String dbnm=rs.getString(3);
		String firmnm=rs.getString(4);
		HttpSession ses=request.getSession(true);
		ses.putValue("dbuser",dbuser);
		ses.putValue("dbpwd",dbpwd);
		ses.putValue("dbnm",dbnm);
		ses.putValue("firmnm",firmnm);
		response.sendRedirect("manufacturer_home.jsp");
	}
	else
	{
		response.sendRedirect("../manufacturer_login.jsp?err=1");
	}
}
catch(Exception ex)
{
	%>
	<%="Error:"+ex%>
	<%
}
%>
