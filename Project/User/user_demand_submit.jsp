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
		
		String demand_title=request.getParameter("demand_title");
		String demand_desc=request.getParameter("demand_desc");
		
		demand_title=demand_title.replace("'","''");
		demand_desc=demand_desc.replace("'","''");
		
		String demand_id="";
		String q="select demand_id from autogen";
		ResultSet rs=smt.executeQuery(q);
		
		if(rs.next())
		{
			demand_id=rs.getString(1);
		}
		rs.close();
		
		q="select * from user_demands where demand_title='"+demand_title+"' and userid='"+userid+"'";
		rs=smt.executeQuery(q);
		if(rs.next())
		{
			response.sendRedirect("user_demand_self_display.jsp?msg=repeated_demand");
		}
		else
		{
			rs.close();
			q="insert into user_demands values('"+demand_id+"','"+demand_title+"','"+demand_desc+"','"+userid+"')";
			//out.println(q);
			smt.executeUpdate(q);
			smt.executeUpdate("update autogen set demand_id=demand_id+1");
			response.sendRedirect("user_demand_self_display.jsp?msg=Done");
		}
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


