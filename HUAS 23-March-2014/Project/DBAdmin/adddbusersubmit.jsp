<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
	String userid=request.getParameter("userid");
	String userpwd=request.getParameter("userpwd");
	String ruserpwd=request.getParameter("ruserpwd");
	String firmnm=request.getParameter("firmnm");
	String firm_address=request.getParameter("firm_address");
	String firm_contact=request.getParameter("firm_contact");
	String user_type=request.getParameter("user_type");
	String p[]=new String[4];
	
%>
<html>

<head>
	<title>Add Database User</title>
</head>

<body>
	<%
	for(int i=0;i<=3;i++)
	{
		p[i]=request.getParameter("p"+(i+1));
	}
	
	if(userid.equals("")||userpwd.equals(""))
	{
		response.sendRedirect("adddbuser.jsp?dbnm="+dbnm+"&err=blnk");
	}
	
	
	if(userpwd.equals(ruserpwd))
	{
		String q="create user '"+userid+"'@'localhost' identified by '"+userpwd+"'";
		smt.executeUpdate(q);
		if(user_type.equals("manufacturer"))
		{
			q="insert into HUAS_CLIENTS.MANUFACTURER_REGISTER values('"+userid+"','"+userpwd+"','"+dbnm+"','"+firmnm+"','"+firm_address+"','"+firm_contact+"')";
			smt.executeUpdate(q);
		}
		else if(user_type.equals("merchant"))
		{
			q="insert into HUAS_CLIENTS.MERCHANT_REGISTER values('"+userid+"','"+userpwd+"','"+dbnm+"','"+firmnm+"','"+firm_address+"','"+firm_contact+"')";
			smt.executeUpdate(q);	
		}
		else if(user_type.equals("shipper"))
		{
			q="insert into HUAS_CLIENTS.SHIPPER_REGISTER values('"+userid+"','"+userpwd+"','"+firmnm+"','"+firm_address+"','"+firm_contact+"')";
			smt.executeUpdate(q);
		}
		for(int i=0;i<4;i++)
		{
			if(p[i]!=null)
			{
				q="grant "+p[i]+" on "+dbnm+".* to '"+userid+"'@'localhost'"; 
				smt.executeUpdate(q);
			}
		}
		smt.close();
		response.sendRedirect("showdatabases.jsp?ack=adduser");
	}
	else
	{
		response.sendRedirect("adddbuser.jsp?dbnm="+dbnm+"&err=pwd");
	}
	%>

</body>

</html>
<%
cn.close();
}
catch(Exception ex)
{
	%>
	<%="Error: "+ex%>
	<%
}
%>

