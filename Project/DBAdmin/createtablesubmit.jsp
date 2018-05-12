<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();
	
	String newtablenm=request.getParameter("newtablenm");
	int no_of_fields=Integer.parseInt(request.getParameter("no_of_fields"));
	String fieldnm[]=new String[no_of_fields];
	String fielddatatype[]=new String[no_of_fields];
	String fieldsize[]=new String[no_of_fields];
	String constraint[]=new String[no_of_fields];
	
%>
<html>

<head>
	<title>Create Table Submit</title>
</head>

<body>
	
<%
	for(int i=0;i<no_of_fields;i++)
	{
		fieldnm[i]=request.getParameter("fieldnm_"+(i+1));
		fielddatatype[i]=request.getParameter("fielddatatype_"+(i+1));
		fieldsize[i]=request.getParameter("fieldsize_"+(i+1));
		constraint[i]=request.getParameter("constraint_"+(i+1));
	}
	
	String q="create table "+newtablenm+"(";
	String pk="none";
	int pkcount=0;
	for(int i=0;i<no_of_fields;i++)
	{
		if(!(fieldsize[i].equals("None")||fieldsize[i].equals(" ")))
		{
			q=q+fieldnm[i]+" "+fielddatatype[i]+"("+fieldsize[i]+")";
		}
		else
		{
			q=q+fieldnm[i]+" "+fielddatatype[i];
		}
		
		if(constraint[i].equals("notnull"))
		{
			q=q+" not null";
		}
		else if(constraint[i].equals("primarykey"))
		{
			if(pkcount==0)
			{
				pk=",primary key ("+fieldnm[i];
				pkcount++;
			}
			else
			{
				pk=pk+","+fieldnm[i];
			}
		}
		
		if(i!=no_of_fields-1)
		{
			q=q+",";
		}
		else
		{
			if(!pk.equals("none"))
			{
				pk=pk+")";
				q=q+pk;
			}
		}
		
		
	}
	q=q+")";
	
	smt.executeUpdate(q);
	
%>
Table Created Successfully.... <a href=databasetables.jsp?dbnm=<%=dbnm%>>Continue</a>
<!%=q%>
	
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
