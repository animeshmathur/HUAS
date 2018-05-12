<!Doctype html>
<html>
<head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="style.css" type="text/css" media="all">
<script src="include/jquery.js"></script>
<script type="text/javascript">
function checkFields()
{
	if(document.userlogin.userid.value=="")
	{
		alert("Please enter User ID!");
		return false;
	}
	if(document.userlogin.pwd.value=="")
	{
		alert("Please enter Password!");
		return false;
	}
	return true;
}
</script>
<title>HUAS : Welcome</title>
<style>
#login_area
{
	position:absolute;
	top:10%;
	left:35%;
	width:350px;
	height:500px;
	background-color:#FFFFFF;
	font-size:13px;
	color:#0066CC;
	border:#0066CC double 10px;
	border-radius:20px;
}
</style>
</head>
<body style="background:#0066CC;">
	<%
	if(request.getParameter("msg")!=null)
	{
		String msg=request.getParameter("msg");
		if(msg.equals("Invalid_Login"))
		{
			%>
			<script type="text/javascript">
			<!--
			alert("Invalid User ID or Password!");
			//-->
			</script>
			<%
		}
	}
	%>
<center>
<h2 style="color:#FFFFFF;"><marquee>Welcome to HUAS!</marquee></h2>
<div id="login_area">
		<img src="images/HUAS.png"  width="300px">
			<h3><i>Login</i></h3>
			<form action="User/userchecklogin.jsp" name=userlogin onsubmit="return(checkFields());" method="post">
			<table cellpadding="10" style="color:#FFFFFF;font-size:13px;text-align:center;">
			<tr><td><input type="text" id="unm" name="userid" placeholder="User ID" style="padding:5px 10px;text-align:center;"></td></tr>
			<tr><td><input type="password" name="pwd" placeholder="Password" style="padding:5px 10px;text-align:center;"></td></tr>
			<tr><td><input type="submit" value="Login" style="padding:5px 20px;color:#0066CC;font-weight:bold;"></td></tr>
			</table>
			<br>
			<br>
			<a href="User/user_registration.jsp"><font color="#0066CC">Not Registered? <i><u><b>Register Now!</b></u></i></font></a><br><br>
			</form>
</div>
</center>
</body>
</html>
