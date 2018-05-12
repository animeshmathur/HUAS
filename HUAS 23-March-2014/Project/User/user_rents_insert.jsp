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
		
		String rent_title=request.getParameter("rent_title");
		rent_title=rent_title.replace("'","''");
		String cat_id=request.getParameter("cat_id");
		String rent_cost=request.getParameter("rent_cost");
		rent_cost=rent_cost.replace("'","''");
		String rent_contact=request.getParameter("rent_contact");
		try
		{
			Long.parseLong(rent_contact); //Check for digits
			
			String rent_details=request.getParameter("rent_details");
			rent_details=rent_details.replace("'","''");
		
			String rent_id="";
			String q="select rent_id from autogen";
			ResultSet rs=smt.executeQuery(q);
		
			if(rs.next())
			{
				rent_id=rs.getString(1);
			}
			rs.close();
		
			q="insert into user_rents values('"+rent_id+"','"+cat_id+"','"+rent_title+"','"+rent_cost+"','"+rent_contact+"','"+userid+"','"+rent_details+"')";
			out.println(q);
			smt.executeUpdate(q);
			smt.executeUpdate("update autogen set rent_id=rent_id+1");
		
			response.sendRedirect("user_rents.jsp?msg=Rent_Inserted");
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
			response.sendRedirect("user_rents.jsp?msg=Invalid_Contact");
		}
	}
	catch(Exception ex)
	{
		//response.sendRedirect("../index.jsp?invalid_access=1");
		%>
		Error: <%=ex%>
		<%
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




