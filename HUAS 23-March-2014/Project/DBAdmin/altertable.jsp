
<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=ses.getValue("dbnm").toString();
	String tablenm=ses.getValue("tablenm").toString();
	ses.putValue("dbnm",dbnm);
	ses.putValue("tablenm",tablenm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","password");
	Statement smt=cn.createStatement();

	String fieldaction=request.getParameter("fieldaction");
	ses.putValue("fieldaction",fieldaction);

	String errno=request.getParameter("errno");
%>
<html>

<head>
	<title>Alter Table</title>
</head>

<body>
	
<%

if(fieldaction.equals("modifyfield"))
{
	if(errno!=null)
	{
		if(errno.equals("1"))
		{
			%>
				<font color=red>* Select Field and DataType</font>
			<%
		}
	}
	%>
	<form action=altertablesubmit.jsp>
	<table border=1>
		<caption><b><i>Modify Field</i></b></caption>
		<tr>
			<td>
				Field:  
			</td>
			<td>
				<select name=fieldnm>
					<option value=null>--Select Field--</option>
					<%
					String q="desc "+tablenm;
					String fieldnm;
					ResultSet rs=smt.executeQuery(q);
					if(rs.next())
					{
						do
						{
							fieldnm=rs.getString(1);
							%>
							<option value=<%=fieldnm%>><%=fieldnm%></option>
							<%
						}while(rs.next());
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				DataType:
			</td>
			<td>
				<select name=fielddatatype>
				<option value=null>--Select DataType--</option>
				<option value=char>CHAR</option>
				<option value=varchar>VARCHAR</option>
				<option value=date>DATE</option>
				<option value=datetime>DATETIME</option>
				<option value=int>INT</option>
				<option value=float>FLOAT</option>
				<option value=text>TEXT</option>
				<option value=blob>BLOB</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				Size:
			</td>
			<td>
				<input type=int name=fieldsize value="None">
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=Modify>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
	</table>
	</form>
	<%
}
else if(fieldaction.equals("primarykey"))
{
	if(errno!=null)
	{
		if(errno.equals("1"))
		{
			%>
				<font color=red>* Please Select the Field</font>
			<%
		}
	}
	%>
	<form action=altertablesubmit.jsp>
		<input type=hidden name=pk_op value=ADDPK>	
	<table border=1>
		<caption>Primary Key</caption>
		<tr>
			<td>
				Select Field for Primary Key: 
			</td>
			<td>
				<select name=fieldnm>
					<option value=null>--Select Field--</option>
					<%
					String q="desc "+tablenm;
					String fieldnm;
					ResultSet rs=smt.executeQuery(q);
					if(rs.next())
					{
						do
						{
							fieldnm=rs.getString(1);
							%>
							<option value=<%=fieldnm%>><%=fieldnm%></option>
							<%
						}while(rs.next());
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=DONE>
			</td>
			<td>
				<input type=reset>
			</td>
			
		</tr>
	</table>
	</form>
	
	<form action=altertablesubmit.jsp>
	<input type=hidden name=pk_op value=DROPPK>	
	<input type=hidden name=fieldnm value=none>	
	<input type=submit value="Drop Existing Primary Key">
	</form>
	<%
}
else if(fieldaction.equals("addfield"))
{
	if(errno!=null)
	{
		if(errno.equals("1"))
		{
			%>
				<font color=red>* Field & DataType can not be blank</font>
			<%
		}
	}
	%>
	<form action=altertablesubmit.jsp>
	<table border=1>
		<caption><b><i>ADD NEW FIELD</i></b></caption>
		<tr>
			<td>
			New Field Name: 
			</td>
			<td>
			<input type=text name=fieldnm>
			</td>
		</tr>
		<tr>
			<td>
				DataType:
			</td>
			<td>
				<select name=fielddatatype>
				<option value=null>--Select DataType--</option>
				<option value=char>CHAR</option>
				<option value=varchar>VARCHAR</option>
				<option value=date>DATE</option>
				<option value=datetime>DATETIME</option>
				<option value=int>INT</option>
				<option value=float>FLOAT</option>
				<option value=text>TEXT</option>
				<option value=blob>BLOB</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				Size:
			</td>
			<td>
				<input type=int name=fieldsize value="None">
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=ADD>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
	</table>
	</form>
	<%
}
else if(fieldaction.equals("dropfield"))
{
	if(errno!=null)
	{
		if(errno.equals("1"))
		{
			%>
				<font color=red>* Select Field</font>
			<%
		}
	}
	%>
	<form action=altertablesubmit.jsp>
	<table border=1>
		<caption><b><i>Drop Field</i></b></caption>
		<tr>
			<td>
				Field:  
			</td>
			<td>
				<select name=fieldnm>
					<option value=null>--Select Field--</option>
					<%
					String q="desc "+tablenm;
					String fieldnm;
					ResultSet rs=smt.executeQuery(q);
					if(rs.next())
					{
						do
						{
							fieldnm=rs.getString(1);
							%>
							<option value=<%=fieldnm%>><%=fieldnm%></option>
							<%
						}while(rs.next());
					}
					%>
					
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=DROP>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
	</table>
	</form>
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
