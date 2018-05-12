<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","guest_user","iamhuasuser");
	Statement smt=cn.createStatement();

	HttpSession ses=request.getSession(false);
	String userid=ses.getValue("userid").toString();
	ses.putValue("userid",userid);
	
	String my_name="Guest";
	Cookie cookies[]=request.getCookies();
	if(cookies!=null)
	{
		my_name=cookies[0].getValue();
	}
%>
<!Doctype html>
