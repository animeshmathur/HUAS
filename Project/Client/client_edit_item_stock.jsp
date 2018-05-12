<%@ include file="client_top.jsp"%>
<%
String item_id=request.getParameter("item_id");
%>
<script>
function removeStock(stock,no)
{
	if(confirm("Do you really want to discard this stock?"))
	{
		$.post("client_remove_item_stock.jsp","stock="+stock);	$('#item_<%=item_id%>_qty').html(parseInt($('#item_<%=item_id%>_qty').html())-parseInt($('#stock_qty_'+no).html()));
		//alert(parseInt($('#item_<%=item_id%>_qty').text())-parseInt($("#stock_qty_"+no).text()));
		$("#stock_"+no).remove();
		alert("Stock discarded!");
	}
}
</script>
<center>
<h3>Stock Details of ' <%=request.getParameter("item_name")%> '</h3>
<%
ResultSet rs=smt.executeQuery("select *,concat(day(item_stock),\"-\",month(item_stock),\"-\",year(item_stock),\" at \",time(item_stock)) as stock_time from item_stocks where stock_item_id='"+item_id+"' order by item_stock");
if(rs.next())
{
	int count=1;
	%>
	<table cellpadding="10" style="text-align:center;font-size:13px;">
	<tr><th>S.No.</th><th>Qty.</th><th>Cost Price (per item)</th><th>Selling Price (per item)</th><th>Stock Time</th><th></th></tr>
	<%
	do
	{
		%>
		<tr id="stock_<%=count%>"><td><%=count%>.</td><td id="stock_qty_<%=count%>"><%=rs.getString("stock_item_qty")%></td><td><%=rs.getString("stock_item_cp")%></td><td><%=rs.getString("stock_item_sp")%></td><td><%=rs.getString("stock_time")%></td><td><button onclick="removeStock('<%=rs.getString("item_stock")%>','<%=count%>');" style="background-color:#FF3333;color:#FFFFFF;font-size:13px;">Discard</button></td></tr>
		<%
		count++;
	}while(rs.next());
	%>
	</table>
	<%
}
%>
</center>
<%@ include file="client_bottom.jsp"%>
