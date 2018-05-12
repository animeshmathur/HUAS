<%@include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		String bid_value=request.getParameter("bid_value");
		
		try
		{
			Long.parseLong(bid_value);
			String q="update seller_item_bids set bid_value='"+bid_value+"' where seller_item_id='"+item_id+"' and userid='"+userid+"'";
			smt.executeUpdate(q);	
			response.sendRedirect("user_item_details.jsp?msg=updated&item_id="+item_id);
		}
		catch(Exception ex)
		{
			response.sendRedirect("user_item_details.jsp?msg=notDigit&item_id="+item_id);
		}
	%>
<%@ include file="include_bottom.jsp"%>

