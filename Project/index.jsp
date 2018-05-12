<%
HttpSession ses=request.getSession(true);
ses.putValue("userid","huas_guest"); 
%>
<!Doctype html>
<html>
<head>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="Guest/style.css" type="text/css" media="all">
<script src="include/jquery.js"></script>
<script type="text/javascript">
function checkFields()
{
	if(document.userlogin.emailid.value=="")
	{
		alert("Please enter Email ID!");
		return false;
	}
	if(document.userlogin.pwd.value=="")
	{
		alert("Please enter Password!");
		return false;
	}
	return true;
}

$('document').ready(
function()
{
	$('.home_item').hide();
	showHomeItem();
}
); 

var i=1;
function showHomeItem()
{
	if(i>4){i=1;}
	$('#home_'+i).css("visibility","visible");
	$('#home_'+i).fadeIn(1000,
	function()
	{
		hideHomeItem();
	});
}

function hideHomeItem()
{
	$('#home_'+i).fadeOut(6000,
	function()
	{
		i++;
		showHomeItem();
	});
}

function checkRegForm()
{
		if(document.RegForm.emailid.value=="")
		{
			alert("Please enter Email ID!");
			document.RegForm.emailid.focus();
			return false;
		}
		if(document.RegForm.pwd.value=="")
		{
			alert("Please enter Password!");
			document.RegForm.pwd.focus();
			return false;
		}
		if(document.RegForm.user_name.value=="")
		{
			alert("Please enter Name!");
			document.RegForm.user_name.focus();
			return false;
		}
		if(document.RegForm.user_address.value=="")
		{
			alert("Please enter Address!");
			document.RegForm.user_address.focus();
			return false;
		}
		if(document.RegForm.user_pincode.value=="")
		{
			alert("Please enter Pin/Zip Code!");
			document.RegForm.user_pincode.focus();
			return false;
		}
		if(document.RegForm.user_city.value=="-1")
		{
			alert("Please select the city!");
			document.RegForm.user_city.focus();
			return false;
		}
                if(document.RegForm.user_contact.value==""||!parseInt(document.RegForm.user_contact.value))
		{
			alert("Please enter contact number!");
			document.RegForm.user_contact.focus();
			return false;
		}
		if(document.RegForm.pwd.value!=document.RegForm.rpwd.value)
		{
			alert("Passwords fields do not match!");
			document.RegForm.rpwd.focus();
			return false;
		}
		return true;
}
</script>
<title>HUAS : Welcome</title>
<style>
#header_area
{
	width:100%;
	height:155px;
	background-color:#FFFFFF;
	font-size:13px;
	color:#0066CC;
	border-bottom:#0066CC groove thin;
}
.home_item
{
	color:#4d4c4c;
	padding:25px 5px;
	width:98%;
	font-weight:bold;
	font-size:14px;
	border-radius:25px;
	text-align:center;
	visibility:hidden;
}
.reg_input
{
        text-align:center;
        font-weight:bold;
        color:#0066CC;
        font-size:14px;
	width:340px;
	padding:5px 10px;
        border:#AAAAAA groove thin;
        border-radius:7px;
}
#reg_area
{
        width:43%;
        position:absolute;
        right:0px;
	background-color:#FFFFFF;
	font-size:13px;
	color:#0066CC;
	border-left:#0066CC outset thin;
}
</style>
</head>
<body style="background:#FFFFFF;">
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
<div id="header_area">
    <center>
		<img src="images/HUAS.png" width="300px" style="float:left;"><br><br>
			<form action="User/userchecklogin.jsp" name="userlogin" onsubmit="return(checkFields());" method="post">
			<table cellpadding="10" style="color:#FFFFFF;font-size:13px;text-align:center;background-color:#0066CC;border-radius:15px;padding:5px 20px;">
			<tr><td><b><span style="font-size:15px;">LOGIN</span></b></td><td><input type="email" name="emailid" placeholder="Email ID" style="padding:5px 10px;text-align:center;"></td><td><input type="password" name="pwd" placeholder="Password" style="padding:5px 10px;text-align:center;"></td><td><input type="submit" value="Login" style="padding:5px 20px;color:#0066CC;font-weight:bold;"></td></tr>
			</table>
			<br>
			<a href="User/user_registration.jsp"><font color="#0066CC"></font></a><br><br>
			</form>
    </center>
</div>
<div id="guest_area" style="width:55%;float:left;">
<center>
<br>
<span style="padding:10px;border-bottom:#0066cc thin groove;">
<br><a href="Guest/e-marts.jsp"><b><span style="font-size:20px"><img src="Guest/images/cart.bmp">&nbsp;&nbsp;&nbsp;&nbsp;GO SHOPPING @ E-Marts - &gt;</span></b></a>
</span>
<br><br><br><br>
	<div class="home_item" id="home_1">
		<img src="Guest/images/cart.bmp">
		<h3>E-Marts</h3>
		Experience all new way of shopping.
	</div>
	<div class="home_item" id="home_2">
		<img src="Guest/images/buyer.jpeg">
		<h3>Sales</h3>
		Buy or sell a second hand item as per your need.
	</div>
	<div class="home_item" id="home_3">
		<img src="Guest/images/wish.jpeg">
		<h3>Demands</h3>
		Place your demand and look for those who can fullfill them.
	</div>
	<div class="home_item" id="home_4">
		<img src="Guest/images/rents.jpg">
		<h3>Rents</h3>
		Get or provide any item or service for rent.
	</div>
</center>
</div>
<div id="reg_area">
<center>
    <font color="#0066CC" style="font-size:15px;"><b>Not Registered <span style="color:#FF3333;font-size:20px;">?</span></b><br><br>Register here and unleash the <b>World of Services</b>!</font><br>
	<form action="User/user_registration_submit.jsp" name=RegForm onsubmit="return(checkRegForm());">
	<table cellpadding="5" style="width:88%;text-align:center;color:#FFFFFF;font-weight:bold;">
           <tr><td><input class="reg_input" type="email" name="emailid" placeholder="Your Email"></td></tr>
            <tr><td><input class="reg_input" type="password" name="pwd" placeholder="Password"></td></tr>
            <tr><td><input class="reg_input" type="password" name="rpwd" placeholder="Re-enter Password"></td></tr>
            <tr><td><input class="reg_input" type="text" name="user_name" placeholder="Full Name"></td></tr>
            <tr><td><textarea class="reg_input" wrap="hard" name="user_address" rows="2" cols="40" placeholder="Address" style="resize:none;"></textarea></td></tr>
            <tr><td><input class="reg_input" type="text" name="user_pincode" placeholder="Pincode"></td></tr>
            <tr>
		<td>
			<select class="reg_input" name="user_city" style="text-align:center;color:#0066CC;width:365px;font-weight:normal;">
				<option value="-1">---- Choose your city ----</option>
				<option value="Gwalior">Gwalior</option>
				<option value="Datia">Datia</option>
				<option value="Dabra">Dabra</option>
				<option value="Bhopal">Bhopal</option>
				<option value="Indore">Indore</option>
				<option value="Jabalpur">Jabalpur</option>
			</select>
		</td>
            </tr>
            <tr><td><input class="reg_input" type="tel" name="user_contact" placeholder="Contact Number"></td></tr>
        </table>
            <br>
        <table style="width:88%">
            <tr><td><input style="color:#0066CC;font-weight:bold;padding:5px 50px;" type="submit" value="Register"></td></tr>
        </table>
	</form>
</center>
</div>
</body>
</html>
