<%@ include file="client_top.jsp"%>
<%
String order_id=request.getParameter("oid");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992");
Statement stmt=cnn.createStatement();
stmt.executeUpdate("update PRODUCT_ORDERS set order_status='Revoked' where order_id='"+order_id+"'");
%>
<%@ include file="client_bottom.jsp"%>
