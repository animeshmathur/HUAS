<%@ include file="manufacturer_top.jsp"%>
<html>
<head>
<%@ include file="manufacturer_head.jsp"%>
<script>
function showAddProductForm()
{
	$("#add_product_form").css("visibility","visible");
}

function closeAddProductForm()
{
	$("#add_product_form").css("visibility","hidden");
}

function addProductSubmit()
{
	pnm=document.getElementById('new_product_name').value.replace('  ',' ');
	pcode=document.getElementById('new_product_code').value.replace('  ',' ');
	pspec=document.getElementById('new_product_specification').value.replace('  ',' ');
	if(pnm==""||pspec=="")
	{
		alert("Please fill Product name & specification fields properly!");
		return false;
	}
	else
	{
		document.getElementById('add_product_form').innerHTML="<h2>Please Wait...</h2>";
		$.post("manufacturer_new_product_submit.jsp","pnm="+pnm+"&pcode"+pcode+"&pspec="+pspec,
		function(data,status)
		{
			location.reload();
		}
		);
	}
}

function setProductDetails(pid,pname)
{
	$("#product_list").hide();
	$("#product_details").css("visibility","visible");
	$("#product_details").load("manufacturer_set_product_details.jsp","pid="+pid+"&pname="+pname);
}

function showProductList()
{
	$("#product_details").css("visibility","hidden");
	$("#product_details").html("<br><br><br><h3>Loading...</h3>");
	$("#product_list").show();
}

function getProductDetails(pid,pname)
{
	$("#product_list").hide();
	$("#product_details").css("visibility","visible");
	$("#product_details").html("<br><br><br><h3>Loading...</h3>");
	$("#product_details").load("manufacturer_get_product_details.jsp","pid="+pid+"&pname="+pname);
}

function setProductDetailParameters(pid,pname)
{
	$("#product_list").hide();
	$("#product_details").css("visibility","visible");
	$("#product_details").html("<br><br><br><h3>Loading...</h3>");
	$("#product_details").load("manufacturer_set_product_detail_parameters.jsp","pid="+pid+"&pname="+pname);
}

function manageProducts()
{
	$("#product_list").hide();
	$("#product_details").css("visibility","visible");
	$("#product_details").html("<br><br><br><h3>Loading...</h3>");
	$("#product_details").load("manufacturer_edit_products.jsp");
	return false;
}
</script>
</head>
<body>
	<%@ include file="manufacturer_header.jsp"%>
	<center>
	<div id="product_list" style="width:100%;">
	<h2>:: Products ::</h2>
	<%
	ResultSet rs=smt.executeQuery("select * from products");
	if(rs.next())
	{
		%>
		<table cellpadding=10 width="80%" style="text-align:center;">
		<%
		do
		{
			if(cn.createStatement().executeQuery("show tables like 'product_"+rs.getString("product_id")+"_details'").next())
			{
				if(cn.createStatement().executeQuery("select * from product_"+rs.getString("product_id")+"_details where parameter_value is null").next())
				{
					%>
					<tr><td><button class="product_button" style="width:100%;height:50px;font-size:16px;" onclick="setProductDetailParameters('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>');" title="View / Manage Details"><b><%=rs.getString("product_name")%></b></button></td></tr>
					<%
				}
				else
				{
					%>
					<tr><td><button class="product_button" style="width:100%;height:50px;font-size:16px;" onclick="getProductDetails('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>');" title="View / Manage Details"><b><%=rs.getString("product_name")%></b></button></td></tr>
					<%
				}
			}
			else
			{
				%>
				<tr><td><button style="width:100%;height:50px;font-size:16px;" onclick="setProductDetails('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>');" title="View / Manage Details"><b><%=rs.getString("product_name")%></b></button></td></tr>
				<%
			}
		}while(rs.next());
		%>
		</table>
		<%
	}
	else
	{
		%>
		<span style="color:#006600;font-size:13px;">* List of products is empty. *</span>
		<%
	}
	%>
	<br><br>
	<a href="#" onclick="return(manageProducts());" style="color:#0066CC;font-size:12px;background-color:#FFFFFF;border-radius:10px;border:thin groove #AAAAAA;padding:10px 15px;"><b>Edit / Manage</b></a>
	<br><br><br>
	<button id="add_product_button" onclick="showAddProductForm();" style="color:#0066CC;background-color:#FFFFFF;border:thin groove #AAAAAA;padding:10px 15px;"><font color="#008800" style="font-size:20px;"><b>+</b></font>&nbsp;&nbsp;&nbsp;<span style="font-size:13px;"><b>Add Product</b></span></button>
	</div>
	<div id="add_product_form" style="text-align:center;width:80%;position:fixed;top:120px;left:100px;border:solid #AAAAAA thin;border-radius:20px;background-color:#FFFFFF;visibility:hidden;">
	<center><span><button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:0px;padding:0px 20px;" onclick="closeAddProductForm();" title="Close">x</button></span>
	<h2>Add New Product</h2>
	<table cellpadding=10 style="text-align:center;width:100%;">
	<tr><td><input type="text" id="new_product_name" style="height:50px;width:80%;padding:10px;" placeholder="Product Name"></td></tr>
	<tr><td><input type="text" id="new_product_code" style="height:50px;width:80%;padding:10px;" placeholder="Product Code (if any)"></td></tr>
	<tr><td><textarea id="new_product_specification" style="height:100px;width:80%;padding:10px;font-size:14px;" placeholder="Product Specification ..."></textarea></td></tr>
	<tr>
		<td>
			<button onclick="addProductSubmit();" style="padding:10px 20px;">ADD</button>
		</td>
	</tr>
	</table>
	</center>
	</div>
	<div id="product_details" style="width:100%;visibility:hidden;">
		<br><br><br>
		<h3>Loading...</h3>
	</div>
	</center>
	<%@ include file="manufacturer_footer.jsp"%>
</body>
</html>
<%@ include file="manufacturer_bottom.jsp"%>
