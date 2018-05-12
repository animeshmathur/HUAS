<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<script>
		$(document).ready(
		function()
		{
			$("#seller_item_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#seller_button").click(
			function()
			{
				$("#buyer").toggle();
				$("#seller_text").toggle();
				$("#seller_item_form").fadeToggle("slow");
			}
			);
		});
		
		$(document).ready(
		function()
		{
			$("#seller_cancel_button").click(
			function()
			{
				$("#seller_item_form").fadeToggle("slow",
				function()
				{
					$("#buyer").toggle();
					$("#seller_text").toggle();
				}
				);
			}
			);
		});
		</script>
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			//alert("check");
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
			if(document.seller_item.price_type.value==-1)
			{
				alert("Please select price type!");
				return false;
			}
			if((document.seller_item.item_amt.value==""&&document.seller_item.price_type.value=="Bid")||(document.seller_item.item_amt.value==""&&document.seller_item.price_type.value=="Fixed"))
			{
				alert("Please provide the price!");
				return false;
			}
			return true;
		}
		
		function setPriceType()
		{
			//alert("check");
			var x=document.getElementById("price_field");
			var sel=document.seller_item.price_type.value;
			if(sel=="Fixed")
			{
				document.seller_item.price_type.value="Fixed";
				x.innerHTML="Rs. <input type=text name=item_amt size=15 placeholder=\"Item Price\" style=\"border-width:2px;border-style:solid;border-color:#FFCC66;\">";
			}
			if(sel=="Bid")
			{
				document.seller_item.price_type.value="Bid";
				x.innerHTML="Rs. <input type=text name=item_amt size=15 placeholder=\"Initial Price for Bid\" style=\"border-width:2px;border-style:solid;border-color:#FFCC66;\">";
			}
			if(sel=="None")
			{
				document.seller_item.price_type.value="None";
				x.innerHTML="";
			}
			if(sel==-1)
			{
				document.seller_item.price_type.value=-1;
				x.innerHTML="";
			}
		}
		
		//-->
		</script>
		<style>
		td
		{
			text-align:center;
		}
		</style>
		</head>
		<body>
		<%@ include file="include_header.jsp"%>
		<center>
			<%
			String seller_msg="";
			seller_msg=request.getParameter("seller_msg");
			if(seller_msg!=null)
			{
				if(seller_msg.equals("1"))
				{
					%>
					<script type="text/javascript">
					alert("Your item is successfully registered!\nTo view your item's information click to 'My Items'. Thank You!");
					</script>
					<%
				}
				if(seller_msg.equals("Invalid_Price"))
				{
					%>
					<script type="text/javascript">
					alert("Invalid Price! Please provide valid price in digits.");
					</script>
					<%
				}
			}
			%>
		<div id="buyer" style="width:85%;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC">
			<center>
			<h3 style="color:#0066CC"><img src="images/buyer.jpeg" height=60 width=65>&nbsp;&nbsp;Buyers</h3>
			<form action="user_buyer.jsp">
			<button type="submit" style="height:100px;width:80%;background-color:#FFFFCC;">
			<table cellpadding=5 style="text-align:center;width:100%;color:#0066CC;font-size:14px;">
			<tr>
			<td>
			<i><b>Explore</b> and <b>buy</b> items avilable for sale.</i>
			</td>
			</tr>
			</table>
			</button>
			</form>
			</center>
			<br>
		</div>
		<div id="seller" style="width:85%;color:#0066CC;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC">
			<center>
			<form id="seller_item_form" action="user_seller_register_item.jsp" name="seller_item" onsubmit="return(checkFields());">
			<br>
			<input type="button" id="seller_cancel_button" value="x" style="background-color:#FFFFFF;color:#FF6666;border-color:#FFFFFF;float:right;font-weight:bold;border-bottom-color:#FF6666;border-bottom-style:solid;border-bottom-width:thin;border-right-color:#FF6666;border-right-style:solid;border-right-width:thin;">
			<br>
			<span style="color:#0066CC"><img src="images/seller.jpg" height=50 width=55><i>Sell Your Item</i></span>
			<br><br>
			<span style="color:#FF6600;font-size:14px;width:80%">::Please Fill Your Item Details Below::</span>
			<br>
			<table cellpadding=6 style="width:80%;text-align:center;background-color:#FFFFCC;">
			<tr>
				<td>
					<input type=text name=item_name placeholder="Name of Item" style="width:100%;background-color:#FFFFFF;border-width:3px;border-style:solid;border-color:#FFCC66;">
				</td>
			</tr>
			<tr>
				<td>
					<textarea name=item_desc cols=50 rows=6 maxlength=300 placeholder="Description of Item" style="width:100%;background-color:#FFFFFF;border-width:3px;border-style:solid;border-color:#FFCC66;"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<select name="price_type" onChange="setPriceType()" style="background-color:#FFFFFF;width:60%;text-align:center;border-width:3px;border-style:solid;border-color:#FFCC66;">
						<option value=-1>--- Select Price Type ---</option>
						<option value="None">On Deal</option> 
						<option value="Fixed">Fixed Price</option> 
						<option value="Bid">Price Over Bid</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="price_field"  style="width:100%;color:#0066CC;font-style:italic;">
				</td>
			</tr>
			<tr>
				<td>
					<input type=submit value="Put On Sale!" style="width:80%;color:#FFFFFF;background-color:#FF6600;">
				</td>
			</tr>
			</table>
			</form>
			<br>
			<span id="seller_text">
			<h3 style="color:#0066CC"><img src="images/seller.jpg" height=60 width=65>&nbsp;&nbsp;Sellers</h3>
			<button id="seller_button" style="height:100px;width:80%;background-color:#FFCC66;">
			<table cellpadding=5 style="color:#0066CC;width:100%;text-align:center;">
			<tr>
				<td>
					<span style="font-size:14px;">
					<i>Want to <b>sell</b> an item <font color="#FF6666" style="font-size:20px"><b>?</b></font>&nbsp;&nbsp;Register your item for sale and look for its buyers.</i>
					</span>
				</td>
				<td>
					<span style="font-size:14px;">::  Click Here!  ::</span>
				</td>
			</tr>
			</table>
			</button>
			</span>
			</center>
			<br>
		</div>
		</center>
		<%@ include file="include_footer.jsp"%>
</body>
</html>
<%@ include file="include_bottom.jsp"%>
