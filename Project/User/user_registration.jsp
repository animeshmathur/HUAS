	<html>
	<head>
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="style.css" type="text/css" media="all">
	<script type="text/javascript">
	function checkFields()
	{
		if(document.userlogin.email.value=="")
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
	<title>
	HUAS : Registration
	</title>
	<style>
	.reg_input
	{
		width:300px;
		padding:5px 10px;
	}
	#reg_area
	{
		padding:50px;
		position:absolute;
		top:0px;
		left:15%;
		width:700px;
		background-color:#FFFFFF;
		font-size:13px;
		color:#0066CC;
		border:#0066CC double 8px;
		border-radius:20px;
	}
	</style>
	</head>
	<body style="background-color:#0066CC;">
	<div id="reg_area">
			<center>
			<img src="images/HUAS.png"  width="300px">
			<h3><font color="#0066CC">Registration</font></h3>
			<form action="user_registration_submit.jsp" name=RegForm onsubmit="return(checkRegForm());">
			<table cellpadding="10" style="width:100%;text-align:center;color:#0066CC;font-weight:bold;">
			<tr><td>Email <font color="red">*</font> :</td><td><input class="reg_input" type="email" name="emailid"></td></tr>
			<tr><td>Password <font color="red">*</font> :</td><td><input class="reg_input" type="password" name="pwd"></td></tr>
			<tr><td>Re-enter Password <font color=red>*</font> :</td><td><input class="reg_input" type="password" name="rpwd"></td></tr>
			<tr><td>Name <font color="red">*</font> :</td><td><input class="reg_input" type="text" name="user_name"></td></tr>
			<tr><td>Address <font color="red">*</font> :</td><td><textarea class="reg_input" wrap="hard" name="user_address" rows="3" cols="40"></textarea></td></tr>
			<tr><td>PIN Code / Zip Code <font color="red">*</font> :</td><td><input class="reg_input" type="text" name="user_pincode"></td></tr>
			<tr>
				<td>City <font color="red">*</font> :</td>
				<td>
					<select class="reg_input" name="user_city" style="text-align:center;color:#0066CC;">
						<option value="-1">---- select ----</option>
						<option value="Gwalior">Gwalior</option>
						<option value="Datia">Datia</option>
						<option value="Dabra">Dabra</option>
						<option value="Bhopal">Bhopal</option>
						<option value="Indore">Indore</option>
						<option value="Jabalpur">Jabalpur</option>
					</select>
				</td>
			</tr>
			<tr><td>Contact Number <font color="red">*</font> :</td><td><input class="reg_input" type="tel" name="user_contact"></td></tr>
			</table>
			<br>
			<table cellpadding="10" style="width:88%">
			<tr><td><input style="background-color:#0066CC;color:#FFFFFF;font-weight:bold;padding:5px 50px;" type="submit" value="Submit"></td><td><input style="color:#0066CC;font-weight:bold;padding:5px 50px" type="reset"></td></tr>
			</table>
			</form>
			</center>
		</div>
	</body>
	</html>
