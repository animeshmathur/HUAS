<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("pid");
String product_name=request.getParameter("pname");
%>
<script>
var count=0;
function removeStockEntry(eid)
{
	if(prompt("Type 'YES' if you want to remove this entry:")=="YES")
	{
		count--;
		$.post("manufacturer_stock_remove_entry.jsp","eid="+eid);
		$("#"+eid).fadeOut(1000,
		function()
		{
			$("#stock_list").html("<span style=\"color:#c40e0e;font-size:20px;\">Loading...</span>");
			$("#stock_list").load("manufacturer_stock_get_stock_list.jsp");
			if(count==0)
			{
				showStockList();
			}
		}
		);
	}
}
</script>
<button style="float:left;background-color:#FFFFFF;position:absolute;left:10px;color:#666666;font-size:13px;" onclick="showStockList();">&lt;&lt;</button>
<h4>Stock Entries For ' <font color="#c40e0e"><%=product_name%></font> '</h4>
<%
ResultSet rs=smt.executeQuery("select *,date(stock_entry_time) as entry_date from product_stock where product_id='"+product_id+"' order by date(stock_entry_time) desc");
if(rs.next())
{
	int count=0;
	%>
	<table cellpadding="10" width="88%" style="text-align:center">
		<tr><th>Quantity</th><th>Date Of Mfg.</th><th>Date Of Exp.</th><th>Stock Entered On</th><th></th></tr>
	<%
	do
	{
		%>
		<tr id="<%=rs.getString("stock_entry_id")%>"><td><%=rs.getString("quantity")%></td><td><%=rs.getString("date_of_mfg")%></td><td><%=rs.getString("date_of_exp")%></td><td><%=rs.getString("entry_date")%></td><td><button onclick="removeStockEntry('<%=rs.getString("stock_entry_id")%>')" style="background-color:#FFFFFF;color:#FF0000;">Remove</button></td></tr>
		<%
		count++;
	}while(rs.next());
	%>
	</table>
	<script>count=<%=count%>;</script>
	<%
}
%>
<%@ include file="manufacturer_bottom.jsp"%>
