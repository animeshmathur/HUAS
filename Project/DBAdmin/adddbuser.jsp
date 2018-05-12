<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession();
	String dbnm=request.getParameter("dbnm");
	ses.putValue("dbnm",dbnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/","hucky","password");
	Statement smt=cn.createStatement();
	
%>
<html>

<head>
	<title>Add Database User</title>
</head>

<body>
<%
String err=request.getParameter("err");
if(err!=null)
{
	if(err.equals("blnk"))
	{
	%>
	<font color=red>* Please Fill The Important Fields</font>
	<%
	}
	else if(err.equals("pwd"))
	{
		%>
		<font color=red>* Passwords did not match</font>
		<%
	}
}
%>
	
	<form action=adddbusersubmit.jsp method=post>
	<table cellpadding=5>
		<caption><h3><i>ADD DATABASE USER</i></h3></caption>
		<tr>
			<td>
				Firm: 
			</td>
			<td>
				<input type=text name="firmnm">
			</td>
		</tr>
		<tr>
			<td>
				Firm Address:
			</td>
			<td>
				<textarea name="firm_address"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				Firm Contact No.: 
			</td>
			<td>
				<input type=text name="firm_contact">
			</td>
		</tr>
		<tr>
			<td>
				User ID:
			</td>
			<td>
				<input type=text name=userid>
			</td>
		</tr>
		<tr>
			<td>
				Password:
			</td>
			<td>
				<input type=password name=userpwd>
			</td>
		</tr>
		<tr>
			<td>
				Re-enter Password:
			</td>
			<td>
				<input type=password name=ruserpwd>
			</td>
		</tr>
		<tr>
			<td>
				User Type:
			</td>
			<td>
				<select name="user_type">
					<option value="merchant">Merchant</option>
					<option value="manufacturer">Manufacturer</option>
					<option value="shipper">Shipper</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				Select Privilages:
			</td>
			<td>
				<input type=checkbox name=p1 value=select checked=true>Select <i>(recommended)</i><br>
				<input type=checkbox name=p2 value=insert>Insert<br>
				<input type=checkbox name=p3 value=update>Update<br>
				<input type=checkbox name=p4 value=delete>Delete<br>
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
