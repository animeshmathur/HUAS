<html>
<head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="style.css" type="text/css" media="all">
<script type="text/javascript">
<!--
function checkFields()
{
	if(document.currentForm.uid.value=="")
	{
		alert("Please enter your User ID!");
		return false;
	}
	if(document.currentForm.pwd.value=="")
	{
		alert("Please enter your Password!");
		return false;
	}
	return true;
}
//-->
</script>
<title>HUAS</title>
<style>
a
{
	color:#0066CC;
}
td
{
	text-align:center;
}
</style>
</head>
<body>
<div id="container">	
	<div id="top" style="background-image:url('../images/HUAS.png');background-size:100% 100%;">
		<img src="./images/HUAS.png" height=100% width=20%>
	</div>
	<div id="mid">
		<div id="content" style="width:100%;">
			<ul><li><a href="index.jsp" style="color:#0066CC;font-size:15px">HOME</a></li></ul>
			<center>
			<%
			String err=request.getParameter("err");
			if(err!=null)
			{
				%>
				<font color=red>* Invalid Login</font>
				<br>
				<%
			}
			%>
			<br>
			<form action="Manufacturer/manufacturerchecklogin.jsp" name="currentForm" method="post" onsubmit="return(checkFields())" style="background-color:#E5E5E5;border:#0066CC solid 3px;width:40%;border-radius:20px;">
			<h3 style="color:#0066CC;font-size:20px;">::<i>&nbsp;Manufacturer Login&nbsp;</i>::</h3>
			<table cellpadding=5>
			<tr><td><input type=text name=uid placeholder="User ID" size=30 style="height:30px;"></td></tr>
			<tr><td><input type=password name=pwd placeholder="Password" size=30 style="height:30px;"></td></tr>
			<tr><td><input type=submit value="LOGIN" style="background-color:#0066CC;color:#FFFFFF;height:30px;width:100px;"></td></tr>
			</table>
			<br>
			</form>
			</center>
		</div>		
	</div>
	<div id="bottom" style="background-color:#FFFFFF;color:#0066CC">
		<center>
		<br><br>
			<span style="font-size:14px">&copy; <i><b>HUAS.com</b></i></span><br>
			<span style="font-size:12px;"><a href="#"><u>About</u></a>&nbsp;|&nbsp;<a href="#"><u>Contact Us</u></a>&nbsp;|&nbsp;<a href="#"><u>Feedback</u></a></span>
		</center>
	</div>
</div>
</body>
</html>
