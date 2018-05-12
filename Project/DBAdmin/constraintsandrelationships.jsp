<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	
	String step=request.getParameter("step");
%>
<html>

<head>
	<title>Constraints</title>
</head>

<body>
	
	<%
		if(step.equals("show"))
		{
			Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/information_schema","hucky","password");
			Statement smt=cn.createStatement();
			
			String ack=request.getParameter("ack");
			
			if(ack!=null)
			{
				if(ack.equals("dpk"))
				{
					%>
					<font color=green>* Primary Key Dropped</font>
					<%
				}
				else if(ack.equals("dfk"))
				{
					%>
					<font color=green>* Relationship Dropped</font>
					<%
				}
				else if(ack.equals("0"))
				{
					%>
					<font color=red>* Unseccessful To Drop</font>
					<%
				}
			}
			
			String q="select constraint_name,table_name,column_name,referenced_table_name,referenced_column_name from key_column_usage where table_schema='"+dbnm+"'";
			ResultSet rs=smt.executeQuery(q);
			String cnm;
			String tablenm;
			if(rs.next())
			{
				%>
				<table cellpadding=5 border=1>
					<caption><h3><i>Relationships & Constraints</i></h3></caption>
					<th>Constraint_Name</th>
					<th>Table_Name</th>
					<th>Column_Name</th>
					<th>Referenced_Table_Name</th>
					<th>Referenced_Column_Name</th>
					<th>Options</th>
					<%
					do
					{
						cnm=rs.getString(1);
						tablenm=rs.getString(2);
						%>
						<tr>
							<td><%=cnm%></td>
							<td><%=tablenm%></td>
							<td><%=rs.getString(3)%></td>
							<td><%=rs.getString(4)%></td>
							<td><%=rs.getString(5)%></td>
							<td><form action=constraintsandrelationships.jsp method=post>
									<input type=hidden name=step value=dropconstraint>
									<input type=hidden name=constraintnm value=<%=cnm%>>
									<input type=hidden name=tablenm value=<%=tablenm%>>
									<input type=submit value=DROP>
								</form>
							</td>
						</tr>
						<%
					}while(rs.next());
				}
				cn.close();
			}
	
	else if(step.equals("dropconstraint"))
	{
		Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
		Statement smt=cn.createStatement();
		
		String constraintnm=request.getParameter("constraintnm");
		String tablenm=request.getParameter("tablenm");
		
		if(constraintnm.substring(0,2).equals("fk"))
		{
			String q="alter table "+tablenm+" DROP FOREIGN KEY "+constraintnm;
			smt.executeUpdate(q);
			response.sendRedirect("constraintsandrelationships.jsp?step=show&ack=dfk");
		}
		else if(constraintnm.equals("PRIMARY"))
		{
			String q="alter table "+tablenm+" DROP PRIMARY KEY";
			smt.executeUpdate(q);
			response.sendRedirect("constraintsandrelationships.jsp?step=show&ack=dpk");
		}
		else
		{
			response.sendRedirect("constraintsandrelationships.jsp?step=show&ack=0");
		}
	}
	
	%>
	

</body>

</html>
<%

}
catch(Exception ex)
{
	%>
	<%="Error: "+ex%>
	<%
}
%>
