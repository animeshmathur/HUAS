<%@ include file="manufacturer_top.jsp"%>
<%
String order_permission=ses.getValue("orders_permission").toString();
String order_id=request.getParameter("order");
DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992").createStatement().executeUpdate("delete from PRODUCT_ORDERS where order_id='"+order_id+"' and order_to='"+dbuser+"'");
%>
<%@ include file="manufacturer_bottom.jsp"%>

