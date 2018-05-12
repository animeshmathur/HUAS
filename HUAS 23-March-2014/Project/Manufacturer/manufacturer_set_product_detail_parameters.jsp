<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("pid");
ses.putValue("pid",product_id);
String product_name=request.getParameter("pname");
%>
<script>
var param=new Array();
var c=0;
function checkProductDetailParameters()
{
	for(i=1;i<=c;i++)
	{
		if(document.getElementById('param_'+i).value=="")
		{
			alert("Please fill all the fields properly!");
			return false;
		}
	}
}
</script>
<button style="float:left;background-color:#FFFFFF;position:absolute;left:10px;color:#666666;font-size:13px;" onclick="showProductList();">&lt;&lt;</button>
<h2><%=product_name%></h2>
<b>:: Please fill in the details ::</b>
<%
ResultSet rs=smt.executeQuery("select parameter_name from product_"+product_id+"_details");
%>
<form action="manufacturer_set_product_detail_parameters_submit.jsp" id="set_parameter_form" onsubmit="return(checkProductDetailParameters());">
<table cellpadding="10" style="text-align:center;width:60%;">
<%
int c=0;
while(rs.next())
{
	c++;
	String param=rs.getString("parameter_name");
	%>
	<tr><td><span style="font-size:15px;"><b><%=param%></b> : </span></td><td><textarea name="param_<%=c%>" style="width:400px;padding:10px;font-size:14px;resize:none;" maxlength="200" placeholder="<%=param%>"></textarea></td></tr>
	<%
}
%>
<tr><td><button type="submit" style="height:40px;width:150px;font-size:16px;background-color:#4d4c4c;color:#FFFFFF;"><b>Save</b></button></td><td><button type="reset" style="height:40px;width:150px;font-size:16px;background-color:#4d4c4c;color:#FFFFFF;"><b>Reset</b></button></td></tr>
</table>
<input type="hidden" name="no_of_param" value="<%=c%>">
</form>
<br><br><br>
<%@ include file="manufacturer_bottom.jsp"%>

