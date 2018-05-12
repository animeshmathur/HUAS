<%@ include file="include_top.jsp"%>
<html>
<head>
<%@ include file="head.jsp"%>
</head>
<style>
.details_table
{
	width:100%;
	font-size:13px;
	color:#0066cc;
	text-align:center;
	background-color:#ffffdd;
	font-weight:bold;
	font-style:italic;
}
.edit_text
{
	width:300px;
	padding:2px 10px;
}
</style>
<script>
$(document).ready(
function()
{
	$("#account_details_edit").hide();	
}
);
function editDetails()
{
	$("#account_details").slideUp("slow");
	$("#account_details_edit").css("visibility","visible");
	$("#account_details_edit").fadeIn("slow");
}
function updateDetails()
{
    if(!($("#new_name").val()==""||$("#new_address").val()==""||$("#new_pincode").val()==""||$("#new_city").val()=="-1"||(!parseInt($("#new_contact").val()))))
    {
	var qs=$("#edit_details_form").serialize();
	//alert(qs);
	$.post("user_update_account_details.jsp",qs);
	//alert($("#new_address").val());
	$("#my_name").html($("#new_name").val());
	$("#my_address").html($("#new_address").val());
	$("#my_pincode").html($("#new_pincode").val());
	$("#my_city").html($("#new_city").val());
	$("#my_contact").html($("#new_contact").val());
	$("#account_details_edit").fadeOut("slow",function(){$("#account_details").slideDown(function(){alert("Account details updated!");});});
    }
    else
    {
        alert("Kindly provide all details properly!");
        return false;
    }
}
</script>
<body>
<%@ include file="include_header.jsp"%>
<center>
<%
ResultSet rs=smt.executeQuery("select * from user_register where userid='"+userid+"'");
if(rs.next())
{
	%>
	<div id="account_details" style="border:#0066cc groove 5px;padding:10px 5px;">
	<h3>My Account</h3>
	<table border="1" class="details_table" cellpadding="10">
	<tr><th>Name :</th><td id="my_name"><%=rs.getString("user_name")%></td></tr>
	<tr><th>Address :</th><td id="my_address"><%=rs.getString("user_address")%></td></tr>
	<tr><th>Pincode :</th><td id="my_pincode"><%=rs.getString("user_pincode")%></td></tr>
	<tr><th>City :</th><td id="my_city"><%=rs.getString("user_city")%></td></tr>
	<tr><th>Contact :</th><td id="my_contact"><%=rs.getString("user_contact")%></td></tr>
	<tr><th>E-Mail :</th><td id="my_email"><%=rs.getString("user_email")%></td></tr>
	</table>
	<br><button id="change_details_button" style="color:#0066CC;padding:10px;" onclick="editDetails();"><b>Change Details</b></button></td>
	</div>
	
	<div id="account_details_edit" style="visibility:Hidden;border:#0066cc groove 5px;padding:10px 5px;">
	<h3><i>Edit Account</i></h3>
	<form action="" id="edit_details_form">
	<table border="1" class="details_table" cellpadding="10">
	<tr><th>Name :</th><td><input class="edit_text" type="text" id="new_name" name="new_name" value="<%=rs.getString("user_name")%>"></td></tr>
	<tr><th>Address :</th><td><textarea class="edit_text" rows="2" cols="25" id="new_address" name="new_address" wrap="hard"><%=rs.getString("user_address")%></textarea></td></tr>
	<tr><th>Pincode :</th><td><input class="edit_text" type="text" id="new_pincode" name="new_pincode" value="<%=rs.getString("user_pincode")%>"></td></tr>
	<tr>
		<th>City :</th>
		<td>
			<select class="reg_input" id="new_city" name="new_city" style="text-align:center;color:#0066CC;width:300px;">
			<option value="-1">---- Select City ----</option>
			<option value="Gwalior" <%if(rs.getString("user_city").equals("Gwalior")){out.print("selected=\"selected\"");}%>>Gwalior</option>
			<option value="Datia" <%if(rs.getString("user_city").equals("Datia")){out.print("selected=\"selected\"");}%>>Datia</option>
			<option value="Dabra" <%if(rs.getString("user_city").equals("Dabra")){out.print("selected=\"selected\"");}%>>Dabra</option>
			<option value="Bhopal" <%if(rs.getString("user_city").equals("Bhopal")){out.print("selected=\"selected\"");}%>>Bhopal</option>
			<option value="Indore" <%if(rs.getString("user_city").equals("Indore")){out.print("selected=\"selected\"");}%>>Indore</option>
			<option value="Jabalpur" <%if(rs.getString("user_city").equals("Jabalpur")){out.print("selected=\"selected\"");}%>>Jabalpur</option>
			</select>
		</td>
	</tr>
	<tr><th>Contact :</th><td><input class="edit_text" type="text" id="new_contact" name="new_contact" value="<%=rs.getString("user_contact")%>"></td></tr>
	</table>
	</form>
	<br><button id="change_details_submit_button" style="background-color:#0066cc;color:#FFFFFF;padding:10px 50px;" onclick="updateDetails();"><b>Change</b></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="$('#account_details_edit').fadeOut('slow');$('#account_details').slideDown();" style="background-color:#4d4c4c;color:#FFFFFF;padding:10px 50px;">Cancel</button>
	</div>
	<br>
	<button style="padding:5px 20px;font-weight:bold;border:groove thin #ff6600; color:#ff6600;" onclick="openBox('extra_outer_box','extra_inner_box','user_account_change_password_1.jsp');">
	Change Your Password</button>
	<%
}
%>
</center>
<%@ include file="include_footer.jsp"%>		
</body>
</html>
<%@ include file="include_bottom.jsp"%>
