<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","password");
	Statement smt=cn.createStatement();
	
	String uid=request.getParameter("uid");
	String pwd=request.getParameter("pwd");
	
	String q="select shipper_name from SHIPPER_REGISTER where shipper_id='"+uid+"' and shipper_pwd='"+pwd+"'";
	ResultSet rs=smt.executeQuery(q);
	if(rs.next())
	{
		String firmnm=rs.getString("shipper_name");
		HttpSession ses=request.getSession(true);
		ses.putValue("uid",uid);
		ses.putValue("pwd",pwd);
		ses.putValue("firmnm",firmnm);
		response.sendRedirect("shipper_home.jsp");
	}
	else
	{
		response.sendRedirect("../shipper_login.jsp?err=1");
	}
}
catch(Exception ex)
{
	%>
	<%="Error:"+ex%>
	<%
}
%>

