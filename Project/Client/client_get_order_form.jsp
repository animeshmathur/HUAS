<%@ include file="client_top.jsp"%>
<%
String manufacturer=request.getParameter("order_to_user");
String manufacturer_db=request.getParameter("order_to_db");
String manufacturer_firm=request.getParameter("order_to_firm");
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/"+manufacturer_db,"hucky","13071992");
ses.putValue("manufacturer",manufacturer);
Statement stmt=cnn.createStatement();
ResultSet rs=stmt.executeQuery("select * from products");
if(rs.next())
{
	%>
	<script>
	var total_orders=0;
	var pid_arr=new Array();
	function toggleOrderDetails(pid,pname)
	{
		if(document.getElementById('order_'+pid))
		{
			pid_arr.splice(pid_arr.indexOf(pid),1);
			$("#order_"+pid).remove();
			total_orders--;
			if(total_orders==0)
			{
				$("#order_submit_button").css("visibility","hidden");
			}
		}
		else
		{
			pid_arr.push(pid);
			$("#order_details").append("<table id=\"order_"+pid+"\" cellpadding=\"10\" style=\"font-size:13px;text-align:center;\"><caption><br><span style=\"font-size:13px;\"><b>Order Details for ' "+pname+" ' :</b></span><br></caption><tr><td>Quantity:</td><td><input type=\"text\" name=\""+pid+"_qty\" id=\""+pid+"_qty\"></td><td>&nbsp;&nbsp;&nbsp;&nbsp;To be delivered on <i style=\"color:#AAAAAA;\">(optional)</i> :</td><td><input type=\"text\" name=\""+pid+"_del_date\" id=\""+pid+"_del_date\" placeholder=\"DD-MM-YYYY\"></td></tr></table>");
			total_orders++;
			if(total_orders==1)
			{
				$("#order_submit_button").css("visibility","visible");
			}
		}
	}
	
	function checkOrderFields()
	{
		if(total_orders==0)
		{
			alert("Kindly select atleast one product!");
			return false;
		}
		for(i=0;i<pid_arr.length;i++)
		{
			if(document.getElementById(pid_arr[i]+'_qty').value=="")
			{
				alert("Kindly fill all fields properly!");
				return false;
			}
		}
		submitOrder();
	}
	
	function submitOrder()
	{
		qs="total_orders="+total_orders;
		for(i=0;i<total_orders;i++)
		{
			qs+="&pid_"+i+"="+pid_arr[i]+"&"+pid_arr[i]+"_qty="+document.getElementById(pid_arr[i]+'_qty').value+"&"+pid_arr[i]+"_del_date="+document.getElementById(pid_arr[i]+'_del_date').value;
		}
		$("#order_form").html("<br><br><img src=\"images/loading.gif\"><br><h3>Please wait while your order is being processed...</span></h3>");
		$.post("client_order_submit.jsp",qs,
		function(data,status)
		{
			$("#order_form").html("<br><br><br><h3 style=\"color:#006600;\">"+data+"</h3>");
		}
		);
		return false;
	}
	</script>
	<div id="order_form">
	<h4 style="color:#4D4C4C;">:: <%=manufacturer_firm%> ::</h4>
	<h3>Place Order</h3>
	<table cellpadding="10" style="font-size:13px;min-width:80%;border-radius:26px;border:solid thin #4D4C4C;background-color:#4d4c4c;color:#FFFFFF;">
	<tr>
	<td><span style="font-size:13px;"><b>Select products to place order for :</b></span></td>
	<td>
	<table cellpadding="10" style="font-size:13px;color:#FFFFFF;width:100%;">
	<tr>
	<%
	int count=1;
	do
	{
		if(count%4==0)
		{%></tr><tr><%}
		%>
		<td><input type="checkbox" id="product_<%=count%>" name="product_<%=count%>" value="<%=rs.getString("product_name")%>" onclick="toggleOrderDetails('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>');"><%=rs.getString("product_name")%></td>
		<%
		count++;
	}while(rs.next());
	%>
	</table>
	</tr>
	</td>
	</tr>
	</table>
	<div id="order_details"></div>
	<br>
	<input id="order_submit_button" type="submit" onclick="return(checkOrderFields());" value="Submit Order" style="visibility:hidden;height:40px;width:150px;background-color:#4D4C4C;color:#FFFFFF;">
	</div>
	<%
}
cnn.close();
%>
<%@ include file="client_bottom.jsp"%>
