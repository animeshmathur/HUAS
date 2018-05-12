<%@ include file="client_top.jsp"%>
<script>
function checkStockDetails()
{
	if($("#stock_item").val()!='-1'&&parseInt($("#stock_qty").val())&&parseFloat($("#stock_cp").val())&&parseFloat($("#stock_sp").val()))
	{
		$("#stock_qty").val(parseInt($("#stock_qty").val()));
		$("#stock_cp").val(parseFloat($("#stock_cp").val()));
		$("#stock_sp").val(parseFloat($("#stock_sp").val()));
		return true;
	}
	else
	{
		//alert(parseInt($("#stock_qty").val()));
		return false;
	}
}

function addItemStockSubmit()
{
	if(checkStockDetails())
	{
		qs=$("#stock_form").serialize();
		//alert(qs);
		$.post("client_add_item_stock_submit.jsp",qs);
		closeBox("extra_outer_box","extra_inner_box");
		alert("Stock added!");
	}
	else
	{
		alert("Kindly fill important details properly!");
	}
}
</script>
<%
ResultSet rs=smt.executeQuery("select * from item_reg order by cat_id");
if(rs.next())
{
	%>
	<center>
	<h3>Add Stock</h3>
	<form id="stock_form" onsubmit="return false;">
	<table border="1" cellpadding="10px" style="width:98%;text-align:center;font-size:13px;border:thin #4d4d4d solid;">
		<tr>
			<th>Item</th>
			<td>
			<select style="min-width:230px" id="stock_item" name="stock_item">
				<option value="-1">--- Select item ---</option>
				<%
				do
				{
					%>
					<option value="<%=rs.getString("item_id")%>"><%=rs.getString("item_name")%></option>
					<%
				}while(rs.next());
				%>
			</select>
			</td>
		</tr>
		<tr><th>Quantity</th><td><input type="text" id="stock_qty" name="stock_qty"></td></tr>
		<tr><th>Cost Price (per item)</th><td><input type="text" id="stock_cp" name="stock_cp"></td></tr>
		<tr><th>Selling Price (per item)</th><td><input type="text" id="stock_sp" name="stock_sp"></td></tr>
		<tr><th>Date of Mfg.</th><td><input type="text" id="stock_mfg" name="stock_mfg" placeholder="(optional)"></td></tr>
		<tr><th>Date of Exp.</th><td><input type="text" id="stock_exp" name="stock_exp" placeholder="(optional)"></td></tr>
		<tr><td><input type="button" value="Insert" onclick="addItemStockSubmit();" style="background-color:#ffffff;color:#4d4c4c;padding:5px 10px;"></td><td><input type="reset"  style="background-color:#ffffff;color:#4d4c4c;padding:5px 10px;"></td></tr>
	</table>
	</form>
	</center>
	<%
}
%>
<%@ include file="client_bottom.jsp"%>
