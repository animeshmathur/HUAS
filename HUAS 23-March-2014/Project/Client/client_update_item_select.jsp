<%@page import="java.sql.*"%>
<%
try
{
	HttpSession ses=request.getSession(true);
	String dbuser=ses.getValue("dbuser").toString();
	ses.putValue("dbuser",dbuser);
	String dbpwd=ses.getValue("dbpwd").toString();
	ses.putValue("dbpwd",dbpwd);
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	String firmnm=ses.getValue("firmnm").toString();
	ses.putValue("firmnm",firmnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,dbuser,dbpwd);
	Statement smt=cn.createStatement();
	
	%>
	<html>
	<head>
		<link rel="stylesheet" href="style.css" type="text/css" media="all">
	<title><%=firmnm%>::STOCK</title>
	<script type="text/javascript">
	<!--
	function checkField()
	{
		if(document.currentForm.item_id.value=="-1")
		{
			alert("Please select an item!");
			return false;
		}
		return true;
	}
	//--->
	</script>
	</head>
	<body>
	<script>
	document.write("<a href=\""+document.referrer+"\" style=\"font-size:15px;color:#0066CC;\">&lt;&lt; Back</a>");
	</script>
	<center>
	<form action=client_update_item_info.jsp name="currentForm" onsubmit="return(checkField());"> 
	<h3><i>:: Please select an item ::</i></h3>
	<table cellpadding=10>
	<tr>
		<td>
			<select name=item_id>
				<option value=-1>--select--</option>
				<%
				String q="select * from item_reg";
				ResultSet rs=smt.executeQuery(q);
				if(rs.next())
				{
					do
					{
						%>
						<option value=<%=rs.getString("item_id")%>><%=rs.getString("item_name")%></option>
						<%
					}while(rs.next());
				}
				%>
			</select>
		</td>
		<td>
		<input type="submit" value="Next >>">
		</td>
	</tr>
	</table>
	</form>
	</center>
	</body>
	</html>
	<%
}
catch(Exception ex)
{
	%>
	<%="Error:"+ex%>
	<%
}
%>


