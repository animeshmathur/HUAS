<%@ include file="include_top.jsp"%>
<center>
<h3>Change Account Password</h3>
<table cellpadding="10p">
<tr><td><b>Enter your current password:</b></td><td><input type="password" id="current_password"></td>
<tr><td><button style="color:#ffffff;background-color:#0066cc;" onclick="if($('#current_password').val()!=''){loadBox('user_account_change_password_2.jsp','curr_pass='+$('#current_password').val());}else{alert('Kindly enter your current password!');};">Continue</button></td><td></td></tr>
</table>
</center>
<%@ include file="include_bottom.jsp"%>
