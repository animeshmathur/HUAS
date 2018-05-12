<%@ include file="client_top.jsp"%>
	<html>
	<head>
	<%@ include file="client_head.jsp"%>
	</head>
	<body>
	<%@ include file="client_header.jsp"%>
	<center>
	<style>
	.stock_button
	{
		border-radius:20px;
		width:100%;
		height:60px;
		font-size:16px;
		font-weight:bold;
	}
	.stock_button:hover
	{
		background-color:#c40e0e;
		color:#FFFFFF;
		opacity:1;
	}
	</style>
	<script>
	function showStockDetail(url)
	{
		$("#stock_menu").fadeOut(
		function()
		{
			$("#stock_detail_area").css("visibility","visible");
			$("#stock_details").html("<br><br><img src=\"images/loading.gif\"><br><br><h3>Loading...</h3>");
			$("#stock_details").load(url);
		}
		);
	}
	
	function closeStockDetail()
	{
		$("#stock_menu").fadeIn();
		$("#stock_detail_area").css("visibility","hidden");
		$("#stock_details").html("<br><br><br><h3>Loading...</h3>");
	}
	</script>
	<div id="stock_menu">
		<h3><i>STOCK</i></h3>
		<table cellpadding="10" style="width:60%;text-align:center;">
		<tr>
			<td><button class="stock_button" onclick="showStockDetail('client_display_stock_items.jsp');">Inventory</button></td>
		</tr>
		<tr>
			<td><button class="stock_button" onclick="showStockDetail('client_insert_item.jsp');">Add new item</button></td>
		</tr>
		<tr>
			<td><button class="stock_button" onclick="showStockDetail('client_display_category.jsp');">Add / Remove Categories</button></td>
		</tr>
		</table>
	</div>
	<div id="stock_detail_area" style="width:98%;visibility:hidden;padding:10px;">
	<button onclick="closeStockDetail();" style="background-color:#FFFFFF;color:#4d4c4c;float:left;padding:5px 10px;"><b>&lt;&lt; Go Back</b></button>
	<div id="stock_details"></div>
	</div>
	</center>
	<%@ include file="client_footer.jsp"%>
	</body>
	</html>
<%@ include file="client_bottom.jsp"%>
