<%@ include file="client_top.jsp"%>
<%
String order_id=request.getParameter("orderid");
String new_status=request.getParameter("new_status");
DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992").createStatement().executeUpdate("update MART_ORDERS set order_status='"+new_status+"' where order_id='"+order_id+"'");
%>
<%@ include file="client_bottom.jsp"%>
