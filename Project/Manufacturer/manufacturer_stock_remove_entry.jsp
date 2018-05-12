<%@ include file="manufacturer_top.jsp"%>
<%
String entry_id=request.getParameter("eid");
smt.executeUpdate("delete from product_stock where stock_entry_id='"+entry_id+"'");
%>
<%@ include file="manufacturer_bottom.jsp"%>
