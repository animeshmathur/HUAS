<%@ include file="include_top.jsp"%>
<%
		
		String item_id=request.getParameter("item_id");
		String bid_value=request.getParameter("bid_value");
		
		try
		{
			Long.parseLong(bid_value);
			String q="insert into seller_item_bids values('"+item_id+"','"+userid+"','"+bid_value+"')";
			smt.executeUpdate(q);
			response.sendRedirect("user_item_details.jsp?msg=done&item_id="+item_id);
		}
		catch(Exception ex)
		{
			response.sendRedirect("user_item_details.jsp?msg=notDigit&item_id="+item_id);
		}
%>
<%@ include file="include_bottom.jsp"%>


