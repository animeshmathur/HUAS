<%@ include file="include_top.jsp"%>
<script>
function changePassword()
{
	if($("#new_password").val()==$("#confirm_new_password").val())
	{
		loadBox('user_account_change_password_submit.jsp','new_ac_pwd='+$("#new_password").val());
	}
	else
	{
		alert("Passwords do not match!");
	}
}
</script>
<center>
<%
if(smt.executeQuery("select user_pwd from user_register where userid='"+userid+"' and user_pwd='"+request.getParameter("curr_pass")+"'").next())
{
	%>
	<h3>Change Your Password</h3>
	<table cellpadding="10" style="border:thin solid #4d4c4c;">
	<tr><td>Enter New Password:</td><td><input type="password" id="new_password"></td></tr>
	<tr><td>Re-enter New Password:</td><td><input type="password" id="confirm_new_password"></td></tr>
	<tr><td><button onclick="changePassword();" style="color:#FFFFFF;background-color:#0066CC;border-radius:0px;">Change!</button></td><td></td></tr>
	</table>
	<%
}
else
{
	%>
	<b><font color="#FF3333">Sorry! Your password did not match.</font></b>
	<%
}
%>
</center>
<%@ include file="include_bottom.jsp"%>
