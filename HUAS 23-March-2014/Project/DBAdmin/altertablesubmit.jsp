<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	String tablenm=ses.getValue("tablenm").toString();
	ses.putValue("tablenm",tablenm);
	String fieldaction=ses.getValue("fieldaction").toString();
	
	String fieldnm=request.getParameter("fieldnm");
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();
	
%>
<html>

<head>
	<title>Alter Table Submit</title>
</head>

<body>
	
	<%
	if(fieldnm.equals("null"))
	{
		response.sendRedirect("altertable.jsp?fieldaction="+fieldaction+"&errno=1");
	}
	
	if(fieldaction.equals("modifyfield"))
	{
		String fielddatatype=request.getParameter("fielddatatype");
		String fieldsize=request.getParameter("fieldsize");
		if(fielddatatype.equals("null"))
		{
			response.sendRedirect("altertable.jsp?fieldaction="+fieldaction+"&errno=1");
		}
		String q;
		if(!(fieldsize.equals("None")||fieldsize.equals(" ")))
		{
			q="alter table "+tablenm+" modify "+fieldnm+" "+fielddatatype+"("+fieldsize+")";
		}
		else
		{
			q="alter table "+tablenm+" modify "+fieldnm+" "+fielddatatype;
		}
		smt.executeUpdate(q);
		%>
		Table Altered Successfully ...<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>>Continue</a>
		<%
		
	}
	else if(fieldaction.equals("primarykey"))
	{
		String pk_op=request.getParameter("pk_op");
		if(pk_op.equals("ADDPK"))
		{
			String q="ALTER TABLE "+tablenm+" ADD PRIMARY KEY ("+fieldnm+")";
			smt.executeUpdate(q);
			%>
				Table Altered Successfully ...<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>>Continue</a>
			<%
		}
		else if(pk_op.equals("DROPPK"))
		{
			String q="ALTER TABLE "+tablenm+" DROP PRIMARY KEY";
			smt.executeUpdate(q);
			%>
				Table Altered Successfully ...<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>>Continue</a>
			<%
		} 
	}
	else if(fieldaction.equals("constraint"))
	{
	}
	else if(fieldaction.equals("addfield"))
	{
		String fielddatatype=request.getParameter("fielddatatype");
		String fieldsize=request.getParameter("fieldsize");
		if(fielddatatype.equals("null"))
		{
			response.sendRedirect("altertable.jsp?fieldaction="+fieldaction+"&errno=1");
		}
		String q;
		if(!fieldsize.equals("None")||!fieldsize.equals(" "))
		{
			q="alter table "+tablenm+" add("+fieldnm+" "+fielddatatype+"("+fieldsize+"))";
		}
		else
		{
			q="alter table "+tablenm+" add("+fieldnm+" "+fielddatatype+")";
		}
		smt.executeUpdate(q);
		%>
		Table Altered Successfully ...<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>>Continue</a>
		<%
		
	}
	else if(fieldaction.equals("dropfield"))
	{
		String q="alter table "+tablenm+" drop column "+fieldnm;
		smt.executeUpdate(q);
		%>
		Table Altered Successfully ...<a href=tableaction.jsp?tableaction=desc&tablenm=<%=tablenm%>>Continue</a>
		<%
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
