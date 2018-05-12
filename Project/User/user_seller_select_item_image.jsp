<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<link rel="stylesheet" href="style.css" type="text/css" media="all">
		<title>HUAS</title>
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			if(document.seller_item.item_name.value=="")
			{
				alert("Please enter Item's Name!");
				return false;
			}
			if(document.seller_item.item_desc.value=="")
			{
				alert("Please provide item's description!");
				return false;
			}
			return true;
		}
		//-->
		</script>
		</head>
		<body>
			<a href="user_seller.jsp" style="color:blue"><i><< Back</i></a>
		<center>
		<div>
			<h2 style="color:#CCDDEE">Sellers Zone</h2>
			<p>::Picture of <b><i><%=item_name%></i></b>::</p>
			<table cellpadding=20>
			<form action="user_seller_upload_item_image.jsp" name="seller_item" enctype="multipart/form-data" onsubmit="return(checkFields())">
			<tr><td>Select:</td><td><input type=file name=item_pic></td></tr>
			<tr><td><input type=submit value=Upload></form></td><td><br><form action="user_seller_register_item.jsp"><input type=submit value="Skip & Continue"></form></td></tr>
			</table>
			</form>
		</div>
		</center>
		</body>
		</html>
<%@ include file="include_bottom.jsp"%>


