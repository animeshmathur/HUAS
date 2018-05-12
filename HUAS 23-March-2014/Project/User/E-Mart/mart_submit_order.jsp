<%@ include file="../include_top.jsp"%>
<%
String mart_id=ses.getValue("mart_id").toString();
String mart_db=ses.getValue("mart_db").toString();
String order_items=request.getParameter("ordered_items");
String order_quantities=request.getParameter("ordered_qty");
String order_prices=request.getParameter("ordered_items_prices");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
ResultSet rs=cnn.createStatement().executeQuery("select order_id from AUTOGEN");
if(rs.next())
{
	cnn.createStatement().executeUpdate("insert into MART_ORDERS values('"+rs.getString("order_id")+"','"+userid+"','"+mart_id+"','"+order_items+"','"+order_quantities+"','"+order_prices+"',NOW(),'In Progress')");
	cnn.createStatement().executeUpdate("update AUTOGEN set order_id=order_id+1");
}
cnn.close();
%>
<%@ include file="../include_bottom.jsp"%>
