<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","guest_user","iamhuasuser");
	Statement smt=cn.createStatement();
	
	String emailid=request.getParameter("emailid");
	String pwd=request.getParameter("pwd");
	
	ResultSet rs=smt.executeQuery("select * from user_register where user_email='"+emailid+"' and user_pwd='"+pwd+"'");
	if(rs.next())
	{
		HttpSession ses=request.getSession(true);
		ses.putValue("userid",rs.getString("userid"));
		
		Cookie user_name_cookie=new Cookie("user_name",rs.getString("user_name"));
		user_name_cookie.setMaxAge(60*60*24);
		response.addCookie(user_name_cookie);
		
		response.sendRedirect("user_home.jsp");
	}
	else
	{
		response.sendRedirect("../index.jsp?msg=Invalid_Login");
	}
	cn.close();
}
catch(Exception ex)
{
	%>
	Error: <%=ex%>
	<%
}
%>


