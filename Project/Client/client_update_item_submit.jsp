<%@ include file="client_top.jsp"%>
<%
	String item_id=request.getParameter("item_id");
	String item_name=request.getParameter("item_name");
	String item_brand=request.getParameter("item_brand");
	String item_on_emart=request.getParameter("item_on_emart");
	
	smt.executeUpdate("update item_reg set item_name='"+item_name+"',item_brand='"+item_brand+"',item_on_emart='"+item_on_emart+"' where item_id='"+item_id+"'");
	//out.println("<font color=\"#006600\">Item Information Updated!</font>");
%>
<%@ include file="client_bottom.jsp"%>


