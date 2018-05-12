<%@ include file="manufacturer_top.jsp"%>
<html>
<head>
<%@ include file="manufacturer_head.jsp"%>
</head>
<body>
<%@ include file="manufacturer_header.jsp"%>
<center>
<div id="accounting_area">
<h3>Accounting</h3>
<%
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992").createStatement().executeQuery("select * from PRODUCT_ORDERS where order_to='"+dbuser+"'");
if(rs.next())
{
	%>
	<table cellpadding="10" width="100%" style="background-color:#FFFFFF;">
	<tr>
	<th>Product</th><th>Qty. Manufactured</th><th>Production Cost</th><th>Qty. Sold</th><th>Net Profit</th>
	</tr>
	</table>
	<%
}
%>
</div>
</center>
<%@ include file="manufacturer_footer.jsp"%>
</body>
</html>
<%@ include file="manufacturer_bottom.jsp"%>
