<%@ include file="manufacturer_top.jsp"%>
<button style="float:left;background-color:#FFFFFF;position:absolute;left:10px;color:#666666;font-size:13px;" onclick="showProductList();">&lt;&lt;</button>
<script>
function getProductSettings(pid,pname)
{
	$("#product_settings").html("<br><br><br><h3>Loading...</h3>");
	$("#product_settings").load("manufacturer_get_product_settings.jsp","pid="+pid+"&pname="+pname);
}
</script>
<h3>&bull; Edit / Manage Products &bull;</h3>
<div style="border-bottom:1px groove #4D4C4C;width:88%;">
<%
ResultSet rs=smt.executeQuery("select * from products");
int c=1;
while(rs.next())
{
	if(c%4==0)
	{%><br><%}
	%>
	<button onclick="getProductSettings('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>')" style="background-color:#4D4C4C;color:#FFFFFF;height:40px;min-width:220px;font-size:13px;"><b><%=rs.getString("product_name")%></b></button>&nbsp;
	<%
	c++;
}
%>
<br><br><br>
</div>
<div id="product_settings" style="width:100%;">
<h4>* Please Select Any Product *</h4>
</div>
<%@ include file="manufacturer_bottom.jsp"%>
