<%@ include file="include_top.jsp"%>
<html>
<head>
<%@ include file="head.jsp"%>
<style>
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
</style>
<script>
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

</script>
</head>
<body>
<%@ include file="include_header.jsp"%>
<br><br><br><br>
	<div class="home_item" id="home_1">
		<img src="images/cart.bmp">
		<h3>E-Marts</h3>
		Experience all new way of shopping.
	</div>
	<div class="home_item" id="home_2">
		<img src="images/buyer.jpeg">
		<h3>Sales</h3>
		Buy or sell a second hand item as per your need.
	</div>
	<div class="home_item" id="home_3">
		<img src="images/wish.jpeg">
		<h3>Demands</h3>
		Place your demand and look for those who can fullfill them.
	</div>
	<div class="home_item" id="home_4">
		<img src="images/rents.jpg">
		<h3>Rents</h3>
		Get or provide any item or service for rent.
	</div>
<%@ include file="include_footer.jsp"%>		
</body>
</html>
<%@ include file="include_bottom.jsp"%>
