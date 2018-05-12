<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("pid");
ses.putValue("pid",product_id);
String product_name=request.getParameter("pname");
ResultSet rs=smt.executeQuery("select * from product_"+product_id+"_details");
%>
<script>
$("#product_details_editable").hide();

function editProductDetails()
{
	$(".product_details").fadeOut(
	function()
	{
		$("#product_details_editable").fadeIn();
	}
	);
	return false;
}

function cancelEditProductDetails()
{
	$("#product_details_editable").fadeOut(
	function()
	{
		$(".product_details").fadeIn();
	}
	);
}
</script>
<button style="float:left;background-color:#FFFFFF;position:absolute;left:10px;color:#666666;font-size:13px;" onclick="showProductList();">&lt;&lt;</button>
<h2><%=product_name%></h2>
<%
if(rs.next())
{
	do
	{
		%>
		<div class="product_details" style="padding:30px;float:left;">
		<table cellpadding="10" style="text-align:center;border:groove thin #4D4C4C;border-radius:10px;background-color:#FFFFFF;">
			<tr><td><span style="font-size:13px;"><%=rs.getString("parameter_name").replace("_"," ")%></span></td></tr>
			<tr><td><span style="font-size:18px;"><%=rs.getString("parameter_value")%></span></td></tr>
		</table>
		</div>
		<%
	}while(rs.next());
	%>
	<div class="product_details" style="width:100%;float:left;">[ <a href="#" style="color:#0066CC;" onclick="return(editProductDetails());"><b>Edit Details</b></a> ]</div>
	<%
}
rs.close();
rs=smt.executeQuery("select * from product_"+product_id+"_details");
%>
<div id="product_details_editable" style="width:88%;">
	<button style="background:#FFFFFF;border-radius:5px;color:#FF6600;float:right;font-size:13px;" title="Cancel" onclick="cancelEditProductDetails();">x</button>
<form action="manufacturer_update_product_detail_parameters_submit.jsp" id="set_parameter_form" onsubmit="return(checkProductDetailParameters());">
<table cellpadding="10" style="text-align:center;width:80%;">
<%
int c=0;
while(rs.next())
{
	c++;
	String param=rs.getString("parameter_name");
	%>
	<tr><td><span style="font-size:15px;"><b><%=param%></b> : </span></td><td><textarea name="param_<%=c%>" style="width:400px;padding:10px;font-size:14px;resize:none;" maxlength="200" placeholder="<%=param%>"><%=rs.getString("parameter_value")%></textarea></td></tr>
	<%
}
%>
<tr><td><button type="submit" style="height:40px;width:150px;font-size:16px;background-color:#4d4c4c;color:#FFFFFF;"><b>Save</b></button></td><td><button type="reset" style="height:40px;width:150px;font-size:16px;background-color:#4d4c4c;color:#FFFFFF;"><b>Reset</b></button></td></tr>
</table>
<input type="hidden" name="no_of_param" value="<%=c%>">
<input type="hidden" name="pname" value="<%=product_name%>">
<br><br><br>
</form>
</div>
<%@ include file="manufacturer_bottom.jsp"%>
