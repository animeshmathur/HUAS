<%@ include file="include_top.jsp"%>
<html>
<head>
<%@ include file="head.jsp"%>
<script>
var start=0;
makelist(start);
		
function makelist(start_limit)
{
	$(document).ready(
	function()
	{
		$("#item_list").html("<br><br><img src=\"images/loading.gif\"><br><br><h5>Loading...</h5>");		
		$("#item_list").load("user_buyer_item_list.jsp","start="+start_limit,
		function()
		{
			$("#item_list").fadeIn("slow");
		}
		);
	}
	);
}
		
function getNextList()
{
	start=start+15;
	makelist(start);
}
		
function getPreviousList()
{
start=start-15;
makelist(start);
}

function viewItemInfo(itemid)
{
	openBox("extra_outer_box","extra_inner_box","user_item_details.jsp","item_id="+itemid);
}

</script>
</head>
<body>	
<%@ include file="include_header.jsp"%>
	<script type="text/javascript">
		//document.write('<a href="' + document.referrer + '" style=\"color:#0066CC;font-size:13px;\">&lt;&lt; Back</a>');
	</script>
<center>
		
<div id="item_list_area" style="width:85%;background-color:#FFFFFF;">
	<h4><i><font color="#FF6600">:: <font color="#0066CC">Latest Items On Sale</font> ::</font></i></h4>
	<span id="item_list">
	</span>
</div>
<br>
</center>
<%@ include file="include_footer.jsp"%>
</body>
</html>
<%@ include file="include_bottom.jsp"%>

