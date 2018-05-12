<%@ include file="client_top.jsp"%>
<%
	int total_items=Integer.parseInt(request.getParameter("total_items"));
	String item_id[]=new String[total_items];
	int item_qty[]=new int[total_items];
	for(int i=0;i<total_items;i++)
	{
		item_id[i]=request.getParameter("item_id_"+(i+1));
		item_qty[i]=Integer.parseInt(request.getParameter("item_qty_"+(i+1)));
	}
	
	String bill_id=request.getParameter("bill_id");
	String total_amount=request.getParameter("total_amount");

	for(int i=0;i<total_items;i++)
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
						smt.executeUpdate("update item_stocks set stock_item_qty='0' where item_stock='"+rs1.getString("item_stock")+"'");
						smt.executeUpdate("insert into bill_history_items values('"+bill_id+"','"+item_id[i]+"','"+stock_qty+"','"+rs1.getString("stock_item_sp")+"')");
						tmp_qty=tmp_qty-stock_qty;
					}
					else if(stock_qty>tmp_qty)
					{
						smt.executeUpdate("update item_stocks set stock_item_qty=stock_item_qty-"+tmp_qty+" where item_stock='"+rs1.getString("item_stock")+"'");
						smt.executeUpdate("insert into bill_history_items values('"+bill_id+"','"+item_id[i]+"','"+tmp_qty+"','"+rs1.getString("stock_item_sp")+"')");
						tmp_qty=0;
					}
				}while(rs1.next()&&tmp_qty>0);
			}
			rs1.close();
	}
	smt.executeUpdate("insert into bill_history values('"+bill_id+"','"+total_amount+"',NOW())");
	smt.executeUpdate("update autogen set bill_id=bill_id+1");
	cn.close();
%>
<%@ include file="client_bottom.jsp"%>
