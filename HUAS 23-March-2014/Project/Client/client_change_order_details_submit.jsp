<%@ include file="client_top.jsp"%>
<%
String order_id=request.getParameter("oid");
String qty=request.getParameter("qty");
String delivery_date=request.getParameter("d_date");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992");
Statement stmt=cnn.createStatement();
stmt.executeUpdate("update PRODUCT_ORDERS set product_quantity='"+qty+"',order_delivery_date='"+delivery_date+"' where order_id='"+order_id+"'");
%>
<%@ include file="client_bottom.jsp"%>
