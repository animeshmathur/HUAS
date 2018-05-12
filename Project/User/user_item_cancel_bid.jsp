<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		
		String q="delete from seller_item_bids where seller_item_id='"+item_id+"' and userid='"+userid+"'";
		smt.executeUpdate(q);
		
		response.sendRedirect("user_item_details.jsp?msg=cancelled&item_id="+item_id);
%>
<%@ include file="include_bottom.jsp"%>


