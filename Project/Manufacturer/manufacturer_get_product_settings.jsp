<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("pid");
ses.putValue("pid",product_id);
String product_name=request.getParameter("pname");
%>
<script>
function removeDetailParameter(param)
{
	if(confirm("Are you sure you want to drop this parameter?\nCaution: Details of product regarding this parameter will be lost!"))
	{
		$.post("manufacturer_remove_product_detail_parameter.jsp","param="+param);
		$("#"+param).fadeOut("slow");
	}
	return false;
}

function addParameter()
{
	new_parameter=prompt("New Parameter Name : ");
	if(new_parameter!=""&&new_parameter!=null)
	{
		param_name=new_parameter;
		new_parameter=new_parameter.replace("  "," ");
		new_parameter=new_parameter.replace(" ","_");
		new_parameter_value=prompt("Value of '"+new_parameter+"' :");
		new_parameter_value=new_parameter_value.replace("  "," ");
		new_parameter_value=new_parameter_value.replace("&","%26");
		new_parameter_value=new_parameter_value.replace("%","%25");
		if(new_parameter_value!="")
		{
			$.post("manufacturer_add_product_detail_parameter.jsp","param="+new_parameter+"&param_value="+new_parameter_value);
			$("#detail_parameters_list").append("<tr id=\""+new_parameter+"\"><td>"+new_parameter+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick=\"return(removeDetailParameter('"+new_parameter+"'));\" style=\"color:#0066CC;\">Drop</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>");
		}
		else
		{
			return false;
		}
	}
	else if(new_parameter=="")
	{
		alert("Invalid Parameter!");
		return false;
	}
}
</script>
<h2><%=product_name%></h2>
<%
if(smt.executeQuery("show tables like 'product_"+product_id+"_details'").next())
{
	ResultSet rs=smt.executeQuery("select parameter_name from product_"+product_id+"_details");
	if(rs.next())
	{
		%>
		<span style="font-size:14px;"><b>&bull; Detail Parameters &bull;</b></span><br><br>
		<table id="detail_parameters_list" cellpadding="10" style="text-align:center;font-size:13px;background-color:#FFFFFF;border-radius:10px;border:#4d4c4c groove thin;">
		<%
		do
		{
			%>
			<tr id="<%=rs.getString("parameter_name")%>"><td><%=rs.getString("parameter_name")%></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="return(removeDetailParameter('<%=rs.getString("parameter_name")%>'));" style="color:#0066CC; ">Drop</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
			<%
		}while(rs.next());
		%>
		</table>
		<%
	}
	%>
	<br>
	<button id="add_c_param_button" style="height:40px;width:150px;background-color:#FFFFFF;color:#0066CC;" onclick="addParameter();"><b style="font-size:17px;color:#00CC00">+</b>&nbsp;&nbsp;&nbsp;<span style="font-size:13px;">Add Parameter</span></button>
	<%
}
else
{
	%>
	<span style="color:#FF0000;font-size:13px;">* No Parameters Defined For This Product.</span>
	<%
}
%>
<%@ include file="manufacturer_bottom.jsp"%>
