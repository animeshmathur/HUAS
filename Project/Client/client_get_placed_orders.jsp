<%@ include file="client_top.jsp"%>
<%
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992");
Statement stmt=cnn.createStatement();

ResultSet rs=stmt.executeQuery("select *,concat(day(order_time),\"-\",month(order_time),\"-\",year(order_time)) as order_date from PRODUCT_ORDERS where order_from='"+dbuser+"'");
if(rs.next())
{
	String order_to_db="";
	ResultSet rs1;
	%>
	<script>
	var order_product_nm=new Array();
	var order_qty=new Array();
	var order_del_date=new Array();
	function changeOrderDetails(order_id)
	{	
		$("#ordered_product_name").text(order_product_nm[order_id]);
		document.getElementById("changed_quantity").value=order_qty[order_id];
		document.getElementById("changed_delivery_date").value=order_del_date[order_id];
		$("#change_order_button").attr("onclick","changeOrderDetailsSubmit('"+order_id+"');");
		$("#revoke_order_button").attr("onclick","revokeOrder('"+order_id+"');");
		$("#extra_box").css("visibility","visible");
		return false;
	}
	
	function closeChangeOrderDetailsForm()
	{
		$("#extra_box").css("visibility","hidden");
		document.getElementById("changed_quantity").value="";
		document.getElementById("changed_delivery_date").value="";
		$("#revoke_order_button").attr("onclick","");
	}
	
	function revokeOrder(order_id)
	{
		if(confirm("Are you sure, you want to revoke this order?"))
		{
			//$("#change_order_button").hide();
			//$("#revoke_order_button").hide();
			//$("#change_order_status").html("<img src=\"images/loading.gif\"><br><br>Please Wait...");
			$.post("client_order_remove.jsp","oid="+order_id);
			$("#manufacturer_order_"+order_id).remove();
			closeChangeOrderDetailsForm();
			alert("Order revoked!");
		}
	}
	
	function changeOrderDetailsSubmit(order_id)
	{
		if(document.getElementById('changed_quantity').value=="")
		{
			alert("Quantity field can not be blank!");
			return false;
		}
		else
		{
			//$("#change_order_button").hide();
			//$("#revoke_order_button").hide();
			qty=document.getElementById('changed_quantity').value.replace("&","%26");
			d_date=document.getElementById('changed_delivery_date').value.replace("&","%26");
			//$("#change_order_status").html("<img src=\"images/loading.gif\"><br><br>Please Wait...");
			$.post("client_change_order_details_submit.jsp","oid="+order_id+"&qty="+qty+"&d_date="+d_date);
			closeChangeOrderDetailsForm();
			$("#manufacturer_order_del_date_"+order_id).html(d_date);
			$("#manufacturer_order_qty_"+order_id).html("<b>"+qty+"</b>");
			alert("Details Changed!")
		}
	}
	</script>
	<h3>Orders to Manufacturers</h3>
	<table cellpadding="10" style="width:88%;text-align:center;font-size:13px;color:#4D4C4C;background-color:#FFFFFF;border:groove thick #4D4C4C;">
		<tr><th>Order To</th><th>Item</th><th>Quantity</th><th>Status</th><th>Ordered On</th><th>Delivery Date</th><th>Options</th></tr>
	<%
	do
	{
		%>
		<script>order_qty['<%=rs.getString("order_id")%>']='<%=rs.getString("product_quantity")%>';order_del_date['<%=rs.getString("order_id")%>']='<%=rs.getString("order_delivery_date")%>';</script>       
		<tr id="manufacturer_order_<%=rs.getString("order_id")%>">
		<td>
			<%
			rs1=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992").createStatement().executeQuery("select firm_name,user_db from MANUFACTURER_REGISTER where userid='"+rs.getString("order_to")+"'");
			if(rs1.next())
			{
				%>
				<%=rs1.getString("firm_name")%>
				<%
				order_to_db=rs1.getString("user_db");
			}
			rs1.close();
			%>
		</td>
		<td>
			<%
			rs1=DriverManager.getConnection("jdbc:mysql://localhost/"+order_to_db,"hucky","13071992").createStatement().executeQuery("select product_name from products where product_id='"+rs.getString("product_id")+"'");
			if(rs1.next())
			{
				%>
				<script>order_product_nm[<%=rs.getString("order_id")%>]='<%=rs1.getString("product_name")%>';</script>
				<b><%=rs1.getString("product_name")%></b>
				<%
			}
			rs1.close();
			%>
		</td>
		<td id="manufacturer_order_qty_<%=rs.getString("order_id")%>"><b><%=rs.getString("product_quantity")%></b></td>
		<td>
			<%
			if(rs.getString("order_status").equals("Revoked"))
			{
				%>
				<font color="#FF0000"><%=rs.getString("order_status")%></font>
				<%
			}
			else
			{
				%>
				<%=rs.getString("order_status")%>
				<%
			}
			%>
		</td>
		<td><%=rs.getString("order_date")%></td>
		<td "manufacturer_order_del_date_<%=rs.getString("order_id")%>"><%=rs.getString("order_delivery_date")%></td>
		<td>
			<%
			if(!(rs.getString("order_status").equals("Revoked")||rs.getString("order_status").equals("Dispatched")||rs.getString("order_status").equals("Rejected")||rs.getString("order_status").equals("In Progress")))
			{
				%>
				<a href="#" style="color:#0066CC;" onclick="return(changeOrderDetails('<%=rs.getString("order_id")%>'));">Change Details</a>
				<%
			}
			else
			{
				%>-<%
			}
			%>
		</td>
		</tr>
		<%
	}while(rs.next());
	%>
	</table>
	<%
}
else
{
	%>
	<h3 style="color:#FF0000;">* No Orders Placed Yet *</h3>
	<%
}
cnn.close();
%>
<div id="extra_box" style="position:fixed;left:150px;top:150px;width:80%;min-height:300px;border:#4D4C4C solid thin;background-color:#FFFFFF;border-radius:10px;visibility:hidden;">
	<button id="cancel_change_order_button" style="border:0px;float:right;padding:10px;color:FF6666;background-color:#FFFFFF;" onclick="closeChangeOrderDetailsForm();">x</button>
	<h4 style="color:#0066CC;">Change Order Details For ' <span id="ordered_product_name" style="color:#c40e0e;"></span> '</h4>
	<table cellpadding="15" style="font-size:14px;text-align:center;width:80%;"><tr><td>Quantity :</td><td><input type="text" id="changed_quantity" style="padding:5px 10px;"></td></tr><tr><td>To Be Delivered On :</td><td><input type="text" id="changed_delivery_date" placeholder="DD-MM-YYYY" style="padding:5px 10px;"></td></tr></table>
	<br>
	<button id="change_order_button" style="padding:10px 20px;width:200px;">Change</button>
	<br><br>
	<button id="revoke_order_button" style="background-color:#c40e0e;color:#FFFFFF;padding:10px 15px;">&bull;&nbsp;&nbsp; Revoke Order &nbsp;&nbsp;&bull;</button>
	<span id="change_order_status" style="color:#0066CC;font-size:13px;font-weight:bold;"></span>
	<br><br>
</div>
<%@ include file="client_bottom.jsp"%>
