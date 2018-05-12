
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
	
	String step=request.getParameter("step");
	
%>
<html>

<head>
	<title>Create Table</title>
</head>

<body>
	
	<%
	if(step.equals("1"))
	{
		String err=request.getParameter("err");
		if(err!=null)
		{
			%>
			<font color=red>* Specified Table Name Not Allowed</font>
			<%
		}
		%>
		<form action=createtable.jsp>
			<input type=hidden name=step value=2>
		<table border=0 cellpadding=5>
		<caption><h3><i>ADD TABLE</i></h3></caption>
		<tr>
			<td>
				New Table Name: 
			</td>
			<td>
				<input type=text name=newtablenm>
			</td>
		</tr>
		<tr>
			<td>
				No. of fields required:
			</td>
			<td>
				<select name=no_of_fields>
					<%
					for(int i=1;i<=10;i++)
					{
						%>
						<option value=<%=i%>><%=i%></option>
						<%
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input type=submit value=Continue>
			</td>
			<td>
				<input type=reset>
			</td>
		</tr>
		</table>
		</form>
		<%
	}
	else if(step.equals("2"))
	{
		String newtablenm=request.getParameter("newtablenm");
		String no_of_fields=request.getParameter("no_of_fields");
		
		if(newtablenm.equals(""))
		{
			response.sendRedirect("createtable.jsp?step=1&err=1");
		}
		
		int nof=Integer.parseInt(no_of_fields);
		%>
		<form action=createtablesubmit.jsp>
			<input type=hidden name=no_of_fields value=<%=no_of_fields%>>
		<table cellspacing=10>
			<caption><h3><i>ADD TABLE</i></h3></caption>
			<tr>
				<td>New Table Name:</td>
				<td><input type=text name=newtablenm value="<%=newtablenm%>" readonly=true></td>
			</tr>
		</table>
		
		NOTE: <font color=green>Use multiple Primary Keys for Composite Key</font> 
		<br>
			<%
			for(int i=1;i<=nof;i++)
			{
				%>
				<br>
				<table>
					<caption>Field #<%=i%></caption>
					<tr>
						<td>
							Field Name: 
						</td>
						<td>
							<input type=text name=fieldnm_<%=i%>>
						</td>
					</tr>
					<tr>
						<td>
							DataType:
						</td>
						<td>
							<select name=fielddatatype_<%=i%>>
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
							<input type=int name=fieldsize_<%=i%> value="None">
						</td>
					</tr>
					<tr>
						<td>
							Constraints:
						</td>
						<td>
							<input type=radio name=constraint_<%=i%> value=notnull>Not Null
							<input type=radio name=constraint_<%=i%> value=primarykey>Primary Key
							<input type=radio name=constraint_<%=i%> value=none>Specify Later
						</td>
					</tr>
				</table>
				<%
			}
			%>
		
		<table>
			<tr>
				<td>
					<input type=submit value=CREATE>
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
