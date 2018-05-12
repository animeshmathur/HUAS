<%@page import="java.util.*"%>
<%@ include file="client_top.jsp"%>
<%
	int total_items=Integer.parseInt(request.getParameter("total_items"));
	String item_id[]=new String[total_items];
	int item_qty[]=new int[total_items];
	String temp_item_id="";
	String temp_item_qty="";
	int i=0;
	int invalid_items=0;
	int item_no=1;
	while(item_no<=total_items)
	{
		temp_item_id=request.getParameter("item_id_"+item_no);
		temp_item_qty=request.getParameter("item_qty_"+item_no);
		if(temp_item_id.equals("-1")||temp_item_qty.equals("-1"))
		{
			invalid_items++;
		}
		else
		{
			item_id[i]=temp_item_id;
			item_qty[i]=Integer.parseInt(temp_item_qty);
			i++;
		}
		item_no++;
	}
	total_items-=invalid_items;
%>
<script>

	function updateItemQuantity()
	{
		<%
		for(i=0;i<total_items;i++)
		{
			%>
			item_qty[<%=item_id[i]%>]=item_qty[<%=item_id[i]%>]-<%=item_qty[i]%>;
			<%
		}
		%>
	}
	
	function submitBill()
	{
		var data=$('#bill_form').serialize();
		//alert(data);
		$.post("client_bill_submit.jsp",data);
		updateItemQuantity();
		$("#reset_button").click();
		for(i=<%=(total_items+invalid_items)%>;i>1;i--)
		{
			removeItemField();
		}
		closeBox('extra_outer_box','extra_inner_box');
	}
	
	function PrintElem(elem)
    {
        Popup($(elem).html());
    }

    function Popup(data) 
    {
        var mywindow = window.open('', 'my div', 'height=400,width=600');
        mywindow.document.write('<html><head><title>Print Bill</title>');
        mywindow.document.write('</head><body >');
        mywindow.document.write(data);
        mywindow.document.write('</body></html>');

        mywindow.print();
        mywindow.close();

        return true;
    }
</script>
<center>	
<br><br>
<form id="bill_form" method="post"  style="color:#0066CC;" onsubmit="return false;">
	<div id="bill" style="width:100%;">
	<center>
	<%
	ResultSet rs=smt.executeQuery("select bill_id from autogen");
	if(rs.next())
	{
		String bill_id=rs.getString(1);
		%>
		<input type=hidden name=bill_id value="<%=bill_id%>">
		<h3 style="color:#0066CC;font-size:13px;height:15px;">Bill #<%=bill_id%></h3>
		<%
	}
	rs.close();
	%>
	</style>
	<input type=hidden name=total_items value="<%=total_items%>">
	<h3 style="color:#0066CC;height:15px;"><%=firmnm%></h3>
	<table border=0 cellpadding=10 style="text-align:center;font-size:13px;">
	<th>S.No.</th><th>Item Name</th><th>Qty.</th><th>Price</th>
	<%
	float item_cost=0;
	float item_total=0;
	float total=0;
	for(i=0;i<total_items;i++)
	{
		rs=smt.executeQuery("select * from item_reg where item_id='"+item_id[i]+"'");
		if(rs.next())
		{
			int tmp_qty=item_qty[i]; //used to get items from each item's stock that may have different item_sp
			ResultSet rs1=cn.createStatement().executeQuery("select * from item_stocks where stock_item_id='"+item_id[i]+"' and stock_item_qty>0");
			if(rs1.next())
			{
				int stock_qty=0;
				do
				{
					stock_qty=Integer.parseInt(rs1.getString("stock_item_qty"));
					if(stock_qty<=tmp_qty)
					{
						item_cost=Float.parseFloat(rs1.getString("stock_item_sp"))*stock_qty;
						tmp_qty=tmp_qty-stock_qty;
					}
					else if(stock_qty>tmp_qty)
					{
						item_cost=Float.parseFloat(rs1.getString("stock_item_sp"))*tmp_qty;
						tmp_qty=0;
					}
					item_total=item_total+item_cost;
				}while(rs1.next()&&tmp_qty>0);
				%>
					<input type="hidden" name="item_id_<%=i+1%>" value="<%=item_id[i]%>">
					<input type="hidden" name="item_qty_<%=i+1%>" value="<%=item_qty[i]%>">
					<tr><td><%=(i+1)%>.</td><td><%=rs.getString("item_name")%></td><td><%=item_qty[i]%></td><td><%=item_total%></td></tr>
				<%
				total=total+item_total;
				item_total=0;
			}
		}
	}
	%>
	<tr><td><b>Total</b></td><td></td><td></td><td><b><%=total%></b></td></tr>
	<input type="hidden" name="total_amount" value="<%=total%>">
	</table>
	</center>
	</div>
	<table cellspacing="10">
	<tr>
	<td><input type="button" id="print_button" onclick="PrintElem('#bill');" value="Print" style="color:#0066CC;background-color:#FFFFFF;border:#0066CC solid thin;border-radius:5px;"></td>
	<td><input type="button" value="Confirm & Finish" style="color:#0066CC;background-color:#FFFFFF;border:#0066CC solid thin;border-radius:5px;" onclick="submitBill();"></td>
	</tr>
	</table>
	</form>
	</center>
<%@ include file="client_bottom.jsp"%>
