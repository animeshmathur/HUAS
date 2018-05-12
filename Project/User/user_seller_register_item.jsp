<%@ include file="include_top.jsp"%>
<%
		String item_name=request.getParameter("item_name");
		String item_desc=request.getParameter("item_desc");
		String item_price_type=request.getParameter("price_type");
		String item_price="";
		if(item_price_type.equals("None"))
		{
			item_price="0";
		}
		else
		{
			item_price=request.getParameter("item_amt");
			try
			{
				Double.parseDouble(item_price);
			}
			catch(Exception e)
			{
				response.sendRedirect("user_sales.jsp?seller_msg=Invalid_Price");
			}
		}
		
		item_desc=item_desc.replace("'","''");
		
		String q="select seller_item_id from autogen";
		String seller_item_id="";
		ResultSet rs=smt.executeQuery(q);
		if(rs.next())
		{
			seller_item_id=rs.getString(1);
		}
		rs.close();
		
		q="select now()";
		String item_date="";
		rs=smt.executeQuery(q);
		if(rs.next())
		{
			item_date=rs.getString(1);
		}	
		rs.close();		
		q="insert into seller_items values('"+seller_item_id+"','"+userid+"','"+item_name+"','"+item_desc+"','no_image.jpg','On Sale','"+item_date+"','"+item_price_type+"','"+item_price+"')";
		smt.executeUpdate(q);
		smt.executeUpdate("update autogen set seller_item_id=seller_item_id+1");
		response.sendRedirect("user_sales.jsp?seller_msg=1");
	}
%>
<%@ include file="include_bottom.jsp"%>
