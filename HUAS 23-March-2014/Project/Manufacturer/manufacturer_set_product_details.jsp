<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("pid");
ses.putValue("pid",product_id);
String product_name=request.getParameter("pname");
%>
<button style="float:left;background-color:#FFFFFF;position:absolute;left:10px;color:#666666;font-size:13px;" onclick="showProductList();">&lt;&lt;</button>
<h2><%=product_name%></h2>
<script>
c_param_no=0;
	
function submitProductDetailParameters()
{
	var params="pid=<%=product_id%>";
	var checked=0;
	for(i=1;i<=7;i++)
	{
		if(document.getElementById('param_'+i).checked)
		{
			params+="&param_"+i+"="+document.getElementById('param_'+i).value;
			checked++;
		}
	}
	params+="&c_param_no="+c_param_no;
	if(c_param_no>0)
	{
		for(i=1;i<=c_param_no;i++)
		{
			if(document.getElementById('c_param_'+i).checked)
			{
				params+="&c_param_"+i+"="+document.getElementById('c_param_'+i).value;
				checked++;
			}
		}
	}
	if(checked>0)
	{
		$.post("manufacturer_product_detail_parameters_submit.jsp",params,
		function(data,status)
		{
			//alert(data);
			setProductDetailParameters('<%=product_id%>','<%=product_name%>');
		}
		);
	}
	else
	{
		alert("Please select atleast one parameter !");
	}
}

function addParameter()
{
	new_parameter=prompt("New Parameter Name : ");
	if(new_parameter!=""&&new_parameter!=null)
	{
		c_param_no++;
		param_name=new_parameter;
		new_parameter=new_parameter.replace("  "," ");
		new_parameter=new_parameter.replace(" ","_");
		//alert(new_parameter);
		$("#custom_parameters").append("<tr><td><input type=\"checkbox\" id=\"c_param_"+c_param_no+"\" value=\""+new_parameter+"\"> "+param_name+"</td></tr>");
	}
	else if(new_parameter=="")
	{
		alert("Invalid Parameter!");
		return false;
	}
}
</script>
<h4><font color="#c40e0e">::</font> Please select detail parameters of this product <font color="#c40e0e">::</font></h4>
<table cellpadding=15 style="font-size:13px;">
<tr>
	<td><input type="checkbox" id="param_1" value="Quantity"> Quantity</td>
	<td><input type="checkbox" id="param_2" value="Production_Cost"> Production Cost</td>
	<td><input type="checkbox" id="param_3" value="Selling_Price"> Selling Price</td>
	<td><input type="checkbox" id="param_4" value="Maximum_Retail_Price"> Maximum Retail Price</td>
</tr>
<tr>
	<td><input type="checkbox" id="param_5" value="Contents"> Contents</td>
	<td><input type="checkbox" id="param_6" value="Net_Weight"> Net Weight</td>
	<td><input type="checkbox" id="param_7" value="brand"> Brand</td>
</tr>
</table>
<table id="custom_parameters" style="font-size:13px;"></table>
<br>
<table cellpadding="20px">
	<tr>
		<td>
			<button id="add_c_param_button" style="height:40px;width:150px;background-color:#FFFFFF;color:#0066CC;" onclick="addParameter();"><b style="font-size:17px;color:#00CC00">+</b>&nbsp;&nbsp;&nbsp;<span style="font-size:13px;">Add Parameter</span></button>
		</td>
		<td>
			<button style="height:40px;width:150px;font-size:16px;background-color:#4d4c4c;" onclick="submitProductDetailParameters();"><b>Continue</b></button>
		</td>
	</tr>
</table>
<%@ include file="manufacturer_bottom.jsp"%>
