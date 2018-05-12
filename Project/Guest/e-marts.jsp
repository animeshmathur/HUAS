<%@ include file="include_top.jsp"%>
<!Doctype html>
<html>
<head>
<%@ include file="head.jsp"%>
<script>
function loadArea(area,url,qs)
{
	$(area).load(url,qs);
}

function closeArea(area)
{
	$(area).css("visibility","hidden");
	$(area).html("<center><br><br><img src=\"images/loading.gif\"><br><br><b>Loading...</b></center>");
}

function loadMart(mart_id)
{
	$("#emart_area").css("visibility","visible");
	$("#emart_area").show('slow');
	loadArea("#emart_area","E-Mart/mart_home.jsp","mart_id="+mart_id);
}

function closeMart()
{
	$("#emart_area").hide('slow',function(){
		closeArea("#emart_area");
	});
	return false;
}

function proceedToBill()
{
	if(selected_items.length>0)
	{
            if(checkPurchaseAmount())
            {
				openBox("extra_outer_box","extra_inner_box","E-Mart/mart_generate_bill.jsp","selected_items="+selected_items+"&selected_items_qty="+selected_items_qty+"&selected_items_cost="+selected_items_cost);
            }
        }
	else
	{
		alert("Empty cart! Please select atleast one item.");
	}
	return false;
}
</script>
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
#emart_area
{
	height:100%;
	width:100%;
	background-color:#FFFFFF;
	z-index:1;
	position:fixed;
	top:0px;
	left:0px;
	visibility:hidden;
	border-bottom:thick #4d4c4c double;
}
</style>
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
</script>
</head>
<body>
<center>
<div id="header_area">
    <center>
		<img src="images/HUAS.png" width="300px" style="float:left;"><br><br>
			<form action="../User/userchecklogin.jsp" name="userlogin" onsubmit="return(checkFields());" method="post">
			<table cellpadding="10" style="color:#FFFFFF;font-size:13px;text-align:center;background-color:#0066CC;border-radius:15px;padding:5px 20px;">
			<tr><td><b><span style="font-size:15px;">LOGIN</span></b></td><td><input type="email" name="emailid" placeholder="Email ID" style="padding:5px 10px;text-align:center;"></td><td><input type="password" name="pwd" placeholder="Password" style="padding:5px 10px;text-align:center;"></td><td><input type="submit" value="Login" style="padding:5px 20px;color:#0066CC;font-weight:bold;"></td></tr>
			</table>
			<br>
			<a href="../index.jsp"><font color="#0066CC">Not Registered? Get registered and unleash the <b>World of Services</b>! <i><u><b>Register Now!</b></u></i></font></a><br><br>
			</form>
    </center>
</div>
<div id="emarts_list" style="width:100%;margin:0 auto;">
<h3 style="font-size:20px">E-Marts @ HUAS</h3>
<%
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992").createStatement().executeQuery("select userid,firm_name,firm_address,firm_contact from MERCHANT_REGISTER");
if(rs.next())
{
	Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
	String mart_id="";
	%>
	<style>
	.mart_button
	{
		background-color:#FFFFFF;
		color:#0066CC;
		border-radius:10px;
		width:88%;
		padding:10px;
	}
	.mart_button:hover
	{
		background-color:#0066CC;
		color:#FFFFFF;
	}
	.mart_info
	{
		font-size:11px;
	}
	</style>
	<table cellpadding="10" style="width:100%;color:#0066CC;font-size:12px;text-align:center;">
	<tr>
	<%
	int i=0;
	do
	{
		ResultSet rs1=cnn.createStatement().executeQuery("select mart_id from MART_REGISTER where mart_userid='"+rs.getString("userid")+"'");
		if(rs1.next())
		{
			mart_id=rs1.getString("mart_id");
		}
		if(i%3==0&&i!=0)
		{
			%>
			</tr><tr>
			<%
		}
		%>
			<td>
			<button class="mart_button" onclick="loadMart('<%=mart_id%>');">
				<b><%=rs.getString("firm_name")%></b><br><i><span class="mart_info"><%=rs.getString("firm_address")%><br><%=rs.getString("firm_contact")%></span></i>
			</button>
			</td>
		<%
		rs1.close();
		i++;
	}while(rs.next());
	if(i%3!=0)
	{
		while(i%3!=0)
		{
			%><td></td><%
			i++;
		}
		%></tr><%
	}
	cnn.close();
	%>
	</table>
	<%
}
%>
</div>
<div id="emart_area" style="overflow:scroll;"><center><br><br><img src="images/loading.gif"><br><br><b>Loading...</b></center></div>	
</center>
</body>
</html>
<%@ include file="include_bottom.jsp"%>

