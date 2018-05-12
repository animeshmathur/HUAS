<%@ include file="client_top.jsp"%>
<html>
<head>
<%@ include file="client_head.jsp"%>
<script>
var searchby="Product";
function searchManufacturer()
{
	keyword=document.getElementById('manufacturer_product_keyword').value;
	if(keyword!="")
	{
		keyword=keyword.replace("&","%26");
		$("#manufacturer_search_box").css("visibility","visible");
		$("#manufacturer_search_results").load("client_search_manufacturers.jsp","searchby="+searchby+"&keyword="+keyword);
		
	}
}

function closeSearchManufacturerBox()
{
	$("#manufacturer_search_box").css("visibility","hidden");
	$("#manufacturer_search_results").html("<center><br><br><img src=\"images/loading.gif\"><br><br>Loading...</center>");
}

function getPlacedOrders()
{
	$("#orders_area").html("<br><br><img src=\"images/loading.gif\"><br><br><b>Loading...</b>");
	$.post("client_get_placed_orders.jsp",
	function(data,status)
	{
		$("#orders_area").html(data);
	}
	);
}

function setManufacturerSearchBy(val)
{
	searchby=val;
}

function getMartOrders()
{
	$("#orders_area").html("<br><br><img src=\"images/loading.gif\"><br><br><b>Loading...</b>");
	$.post("client_get_mart_orders.jsp",
	function(data,status)
	{
		$("#orders_area").html(data);
	}
	);	
}
</script>
<style>
#placed_orders_button:hover
{
	background-color:#c40e0e;
}
</style>
</head>
<body>
	<%@ include file="client_header.jsp"%>
	<center><br>
	<div id="search_manufacturers" style="padding:10px;width:23%;float:left;min-height:400px;border-right:groove #4D4C4C thin;font-size:13px;">
		<br>
		<button id="manufacturer_orders_button" style="height:50px;width:80%;" onclick="getPlacedOrders()"><b>Orders to Manufacturers</b></button><br><br>
		<button id="emart_orders_button" style="height:50px;width:80%;" onclick="getMartOrders()"><b>Orders from E-Mart</b></button>
		<br>
		<h3>&bull; Search for Manufacturers &bull;</h3>
		<input type="radio" name="search_by" id="search_by" value="Product" checked="checked" onclick="setManufacturerSearchBy('Product');">By Product&nbsp;&nbsp;<input type="radio" name="search_by" id="search_by" value="Name" onclick="setManufacturerSearchBy('Name');">By Name<br><br>
		<table width="100%"><tr><td><input type="text" id="manufacturer_product_keyword" style="font-size:13px;width:100%;height:30px;padding:0px 5px;text-align:center;" placeholder="Search keyword"></td><td><button style="background-color:#FFFFFF;" onclick="searchManufacturer();" title="Search"><img src="images/search.jpeg"></button></td></tr></table>
	</div>
	<div id="orders_area" style="width:75%;float:right;">
	<script>getMartOrders();</script>
	</div>
	<div id="manufacturer_search_box" style="visibility:hidden;border-radius:10px;position:fixed;left:150px;top:150px;width:80%;height:350px;border:#4D4C4C solid thin;background-color:#FFFFFF;">
		<button style="color:#FF3300;padding:5px;float:right;background-color:#FFFFFF;" onclick="closeSearchManufacturerBox();">x</button><br>
		<div id="manufacturer_search_results" style="overflow-y:scroll;height:300px;width:100%:"><center><br><br><img src="images/loading.gif"><br><br>Loading...</center></div>
	</div>
	</center>
	<%@ include file="client_footer.jsp"%>
</body>
</html>
<%@ include file="client_bottom.jsp"%>
