<%@include file="shipper_top.jsp"%>
<%
String request_from=request.getParameter("order_to");
String request_to=request.getParameter("order_from");
String requester_type=request.getParameter("requester");
if(DriverManager.getConnection("jdbc:mysql://localhost/HUAS_SHIPPINGS","hucky","password").createStatement().executeQuery("select * from SHIPPING_REQUESTS where shipping_request_status='Awaiting for Shipper'").next())
{
	DriverManager.getConnection("jdbc:mysql://localhost/HUAS_SHIPPINGS","hucky","password").createStatement().executeUpdate("insert into SHIPPER_ACKNOWLEDGEMENTS values('"+request_from+"','"+request_to+"','"+uid+"',NOW(),'"+requester_type+"')");
	%>1<%
}
else
{
	%>0<%
}
%>
<%@include file="shipper_bottom.jsp"%>
