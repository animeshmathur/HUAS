<%@ page  import="java.text.DecimalFormat" %>
<%@ include file="client_top.jsp"%>
<html>
<head>
<%@ include file="client_head.jsp"%>
</head>
<body>
<%@ include file="client_header.jsp"%>
<center>
<div id="accounts_area" style="width:100%;">
<h3>Account Summary</h3>
<%
ResultSet rs=smt.executeQuery("select * from bill_history_items group by item_id");
if(rs.next())
{
	String item_name="";
	ResultSet rs1=null;
	%>
	<table cellpadding="10px" style="font-weight:bold;color:#4d4c4c;width:98%;font-size:13px;text-align:center;background-color:#FFFFFF;border:#4d4c4c solid thin;">
	<tr><th>Item</th><th>Quantity Sold</th><th>Cost Amount (Rs.)</th><th>Selling Amount (Rs.)</th><th>Profit (Rs.)</th></tr>
	<%
	int qty_sold;
	float net_cp;
	float net_sp;
	do
	{
		rs1=cn.createStatement().executeQuery("select item_name from item_reg where item_id='"+rs.getString("item_id")+"'");
		if(rs1.next())
		{
			item_name=rs1.getString("item_name");
		}
		rs1.close();
		//net_sp=qty_sold*Integer.parseInt(rs.getString("item_cost"));
		rs1=cn.createStatement().executeQuery("select * from item_stocks where stock_item_id='"+rs.getString("item_id")+"'");
		if(rs1.next())
		{
			qty_sold=0;
			net_cp=0;
			net_sp=0;
			do
			{
				if(rs1.getString("stock_item_qty").equals("0"))
				{
					qty_sold+=Integer.parseInt(rs1.getString("stock_qty_added"));
					net_cp+=Integer.parseInt(rs1.getString("stock_qty_added"))*Float.parseFloat(rs1.getString("stock_item_cp"));
					net_sp+=Integer.parseInt(rs1.getString("stock_qty_added"))*Float.parseFloat(rs1.getString("stock_item_sp"));
				}
				else
				{
					qty_sold+=Integer.parseInt(rs1.getString("stock_qty_added"))-Integer.parseInt(rs1.getString("stock_item_qty"));
					net_cp+=(Integer.parseInt(rs1.getString("stock_qty_added"))-Integer.parseInt(rs1.getString("stock_item_qty")))*Float.parseFloat(rs1.getString("stock_item_cp"));
					net_sp+=(Integer.parseInt(rs1.getString("stock_qty_added"))-Integer.parseInt(rs1.getString("stock_item_qty")))*Float.parseFloat(rs1.getString("stock_item_sp"));
				}
			}while(rs1.next());
			net_cp=Float.parseFloat(new DecimalFormat("#.##").format(net_cp));
			net_sp=Float.parseFloat(new DecimalFormat("#.##").format(net_sp));
			%>
			<tr><td><%=item_name%></td><td><%=qty_sold%></td><td><%=net_cp%></td><td><%=net_sp%></td><td><%=Float.parseFloat(new DecimalFormat("#.##").format(net_sp-net_cp))%></td></tr>
			<%
		}
	}while(rs.next());
	%>
	</table>
	<%
}
%>
</div>
</center>	
<%@ include file="client_footer.jsp"%>
</body>
</html>
<%@ include file="client_bottom.jsp"%>
