<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","guest_user","iamhuasuser");
	Statement smt=cn.createStatement();
	
	try
	{
		HttpSession ses=request.getSession(true);
		String userid=ses.getValue("userid").toString();
		ses.putValue("userid",userid);
		
		String demand_id=request.getParameter("demand_id");
		
		String q="delete from user_demands where demand_id='"+demand_id+"' and userid='"+userid+"'";
		smt.executeUpdate(q);
		
		response.sendRedirect("user_demand_self_display.jsp?msg=Removed");
		
	}
	catch(Exception ex)
	{
		%>
		<%=ex%>
		<%
		//response.sendRedirect("../index.jsp?invalid_access=1");
	}

	%>
<%
}
catch(Exception ex)
{
	%>
	Error: <%=ex%>
	<%
}
%>


