<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","guest_user","iamhuasuser");
	Statement smt=cn.createStatement();
	
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	String user_name=request.getParameter("user_name");
	String user_address=request.getParameter("user_address");
	String user_pincode=request.getParameter("user_pincode");
	String user_city=request.getParameter("user_city");
	String user_contact=request.getParameter("user_contact");
	String user_email=request.getParameter("user_email");
	
	String q="insert into user_register values('"+userid+"','"+pwd+"','"+user_name+"','"+user_address+"','"+user_pincode+"','"+user_city+"','"+user_contact+"','"+user_email+"')";
	smt.executeUpdate(q);
	cn.close();
	response.sendRedirect("userchecklogin.jsp?userid="+userid+"&pwd="+pwd);
}
catch(Exception ex)
{
	%>
	Error: <%=ex%>
	<%
}
%>

