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
		function checkFields()
		{
			if(document.currentForm.cat_name.value=="")
			{
				alert("Category Name can not be blank!");
				return false;
			}
			return true;
		}
	//-->
	</script>
	</head>
	<body>
	<script>
	document.write("<a href=\""+document.referrer+"\" style=\"font-size:15px;color:#0066CC;\">&lt;&lt; Back</a>");
	</script>
	<center>
	<form action="client_insert_category_submit.jsp" onsubmit="return(checkFields());">
	<h3><i>Add Category of Item</i></h3>
	<table border=0 cellpadding=10 cellspacing=5>
	<tr><td>Category ID:</td><td><input type=text name=cat_id value=<%=catid%> readonly=true></td></tr>
	<tr><td>Category Name<font color=red> * </font>:</td><td><input type=text name=cat_name ></td></tr>
	<tr><td>Category Description:</td><td><textarea name=cat_desc ></textarea></td></tr>
	<tr><td><input type=submit value=Insert></td><td><input type=reset></td></tr>
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



