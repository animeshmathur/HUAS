<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	String firsttable=ses.getValue("firsttable").toString();
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();
	
	String firstfield=request.getParameter("firstfield");
	String secondfield=request.getParameter("secondfield");
	String relation_action=request.getParameter("relation_action");
	
%>
<html>

<head>
	<title>Relationship</title>
</head>

<body>
	
	<%
	int chk=0;
	if(relation_action.equals("add"))
	{
		String secondtable=ses.getValue("secondtable").toString();
		String q="ALTER TABLE "+firsttable+" ADD CONSTRAINT fk_"+firsttable+" FOREIGN KEY("+firstfield+") REFERENCES "+secondtable+"("+secondfield+") ON DELETE CASCADE ON UPDATE CASCADE";
		chk=smt.executeUpdate(q);
	}
	else if(relation_action.equals("drop"))
	{
		String q="ALTER TABLE "+firsttable+" DROP FOREIGN KEY fk_"+firsttable;
		chk=smt.executeUpdate(q); 
	}
	
	if(chk!=0)
	{
		if(relation_action.equals("add"))
		{
			%>
			Relationship Established! <a href=tableaction.jsp?tableaction=desc&tablenm=<%=firsttable%>>Continue</a>
			<%
		}
		else if(relation_action.equals("drop"))
		{
			%>
			Relationship Dropped! <a href=tableaction.jsp?tableaction=desc&tablenm=<%=firsttable%>>Continue</a>
			<%
		}
	}
	else if(chk==0)
	{
		%><%=chk%>
			Unsuccessful Operation... <a href=addrelationship.jsp?step=sel_tables>Try Again</a>!
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
	Unsuccessful Operation... <a href=addrelationship.jsp?step=sel_tables>Try Again</a>!
	<%
}
%>
