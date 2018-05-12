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
		
		String item_id=request.getParameter("item_id");
		String query_id=request.getParameter("query_id");
		
		String q="delete from seller_item_queries where query_id='"+query_id+"' and userid='"+userid+"'";
		smt.executeUpdate(q);
		
		response.sendRedirect("user_item_details.jsp?item_id="+item_id);		
	}
	catch(Exception ex)
	{
		//out.println(ex);
		response.sendRedirect("../index.jsp?invalid_access=1");
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


