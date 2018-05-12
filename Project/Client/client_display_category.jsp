<%@ include file="client_top.jsp"%>
	<script>
	function confirmRemoveAction(catid)
	{
		if(confirm("Are you sure you want to remove this category?\nNote: Removing this category will remove all items associated with it!"))
		{
			$.post("client_remove_category.jsp","cat_id="+catid,
			function(data,status)
			{
				alert(data);
				$("#stock_details").html("<br><br><br><h3>Loading...</h3>");
				$("#stock_details").load("client_display_category.jsp");
			}
			);
		}
	}
	
	function showAddCategoryForm()
	{
		$("#add_category_form").css("visibility","visible");
	}
	
	function closeAddCategoryForm()
	{
		$("#add_category_form").css("visibility","hidden");
	}
	
	function addCategorySubmit()
	{
		if(document.getElementById('cat_name').value=="")
		{
			alert("Category Name can not be blank!");
			return false;
		}
		cat_name=document.getElementById('cat_name').value;
		cat_desc=document.getElementById('cat_desc').value;
		cat_name=cat_name.replace("&","%26");
		cat_desc=cat_desc.replace("&","%26");
		$.post("client_insert_category_submit.jsp","cat_name="+cat_name+"&cat_desc="+cat_desc,
		function(data,status)
		{
			alert(data);
			$("#stock_details").html("<br><br><br><h3>Loading...</h3>");
			$("#stock_details").load("client_display_category.jsp");
		}
		);
	}
	</script>
	<center>
	<h3>Add / Remove Categories</h3>
		<%
		String q="select * from item_category";
		ResultSet rs=smt.executeQuery(q);
		if(rs.next())
		{
			%>
			<table border="1" cellpadding="10" style="text-align:center;font-size:13px;width:80%;">
			<tr><th>Category Name</th><th>Description</th><th><i>Option</i></th></tr>
			<%
			do
			{
				%>
				<tr>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><button onclick="confirmRemoveAction('<%=rs.getString(1)%>');">Remove</button></td>
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
			<font color=red>* No Category Defined *</font>
			<%
		}
		%>
	<br>
	<button onclick="showAddCategoryForm();" style="padding:10px 15px;width:150px;background-color:#FFFFFF;color:#0066CC;font-size:13px;"><span style="color:#00AA00;font-size:20px;"><b>+</b></span>&nbsp;&nbsp;Add Category</button>
	<div id="add_category_form" style="padding:10px;text-align:center;width:60%;position:fixed;top:120px;left:15%;border:solid #AAAAAA thin;border-radius:20px;background-color:#FFFFFF;visibility:hidden;">
	<center>
	<span><button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:0px;padding:0px 20px;" onclick="closeAddCategoryForm();" title="Close">x</button></span>
	<h2>Add New Category</h2>
	<p id="cat_op_status"></p>
	<table border=0 cellpadding=10 cellspacing=5 style="text-align:center;width:100%;">
	<tr><td>Category Name<font color="red"> * </font>:</td><td><input type="text" id="cat_name" ></td></tr>
	<tr><td>Category Description:</td><td><textarea id="cat_desc" style="width:200px;"></textarea></td></tr>
	</table>
	<button onclick="addCategorySubmit()" style="padding:10px;">ADD</button>
	</center>
	</div>
	</center>
<%@ include file="client_bottom.jsp"%>
