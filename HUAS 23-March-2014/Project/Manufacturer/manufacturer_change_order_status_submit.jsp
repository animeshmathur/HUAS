<%@ include file="manufacturer_top.jsp"%>
<%
String order_permission=ses.getValue("orders_permission").toString();
String order_id=request.getParameter("order");
String new_status=request.getParameter("new_status");
DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992").createStatement().executeUpdate("update PRODUCT_ORDERS set order_status='"+new_status+"' where order_id='"+order_id+"' and order_to='"+dbuser+"'");
%>
<%@ include file="manufacturer_bottom.jsp"%>
