<%@ include file="client_top.jsp"%>
<%
	String item_id=request.getParameter("item_id");
	%>
	<script type="text/javascript">
	function updateItemInfoSubmit(item_id)
	{
		if(document.getElementById('item_name').value==""||document.getElementById('item_brand').value=="")
		{
			alert("Please Fill important fields appropriately!");
			return false;
		}
		qs=$("#update_form").serialize();
		//alert(qs);
		$("#update_status").html("<font color=\"#c40e0e\">Please Wait...</font>");
		$.post("client_update_item_submit.jsp",qs+"&item_id="+item_id,
		function(data,status)
		{
		//	$("#update_status").html(data);
			$("#stock_details").html("<br><br><br><h3>Loading...</h3>");
			$("#stock_details").load("client_display_stock_items.jsp");
		}
		);
		return false;
	}
	</script>
	<center>
	<%
	ResultSet rs=smt.executeQuery("select * from item_reg where item_id='"+item_id+"'");
	if(rs.next())
	{
		String item_name=rs.getString("item_name");
		%>
		<span style="font-size:20px;color:#0066CC;"><i><b>'<%=item_name%>'</b></i></span>
		<p style="font-size:13px;" id="update_status"></p> 
		<form id="update_form" onsubmit="return false;"> 
		<table cellpadding="10" style="width:88%;font-size:13px;text-align:center;">
		<tr><td>Item Name<font color="red"> * </font>:</td><td><input type="text" id="item_name" name="item_name" value="<%=item_name%>"></td></tr>
		<tr><td>Brand<font color="red"> * </font>:</td><td><input type="text" id="item_brand" name="item_brand" value="<%=rs.getString("item_brand")%>"></td></tr>
		<tr><td>On E-Mart</td><td><input type="radio" name="item_on_emart" value="YES" <%if(rs.getString("item_on_emart").equals("YES")){out.print("checked=\"checked\"");}%>>Yes&nbsp;<input type="radio" name="item_on_emart" value="NO" <%if(rs.getString("item_on_emart").equals("NO")){out.print("checked=\"checked\"");}%>>No</td></tr>
		<tr><td><input type="submit" value="Update" onclick="updateItemInfoSubmit('<%=item_id%>');"></td><td><input type="reset"></td></tr>
		</table>
		</form>
		<%
	}
	%>
	</center>
<%@ include file="client_bottom.jsp"%>
