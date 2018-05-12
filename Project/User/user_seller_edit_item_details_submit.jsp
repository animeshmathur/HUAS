<%@ include file="include_top.jsp"%>
<%
		String item_id=ses.getValue("item_id").toString();
		
		String item_name=request.getParameter("item_name");
		String item_desc=request.getParameter("item_desc");
		String item_status=request.getParameter("item_status");
		String item_price=request.getParameter("item_price");

		item_name=item_name.replace("'","''");
		item_desc=item_desc.replace("'","''");
				
		if(!item_price.equals("N/A"))
		{
			try
			{
				double item_price_value=Double.parseDouble(item_price);
				String q="update seller_items set seller_item_name='"+item_name+"',seller_item_description='"+item_desc+"',seller_item_status='"+item_status+"',seller_item_price='"+item_price+"' where seller_item_id='"+item_id+"' and userid='"+userid+"'";
				smt.executeUpdate(q);
			}
			catch(Exception e)
			{
				response.sendRedirect("user_seller_edit_item_details.jsp?item_id="+item_id+"&msg=Invalid_Price");
			}
		}
		else
		{
			String q="update seller_items set seller_item_name='"+item_name+"',seller_item_description='"+item_desc+"',seller_item_status='"+item_status+"' where seller_item_id='"+item_id+"' and userid='"+userid+"'";
			smt.executeUpdate(q);
		}
		response.sendRedirect("user_item_details.jsp?item_id="+item_id+"&seller_msg=1");
%>
<%@ include file="include_bottom.jsp"%>
