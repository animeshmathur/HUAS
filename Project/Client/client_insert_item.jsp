<%@ include file="client_top.jsp"%>
	<script type="text/javascript">
	<!--
	function checkFields()
	{
		if(document.currentForm.cat_id.value=="-1"||document.currentForm.item_name.value==""||document.currentForm.item_brand.value==""||document.currentForm.item_cp.value==""||document.currentForm.item_sp.value==""||document.currentForm.item_qty.value=="")
		{
			alert("Please fill important fields appropriately!");
			return false;
		}
	}
	//-->
	</script>
	<center>
	<form action=client_insert_item_submit.jsp name=currentForm onsubmit="return(checkFields());">
	<h3><i>Add new item to stock</i></h3>
	<table border=0 cellpadding=10 style="text-align:center;width:60%;font-size:14px;">
	<tr>
		<td>Category<font color=red> * </font>:</td>
		<td>
			<select name="cat_id" style="min-width:200px;">
			<option value="-1">--select--</option>
			<%
			ResultSet rs=smt.executeQuery("select cat_id,cat_name from item_category");
			if(rs.next())
			{
				do
				{
					%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
					<%
				}while(rs.next());
			}
			%>
			</select>
		</td>
	</tr>
	<tr><td>Item Name<font color=red> * </font>:</td><td><input type=text name=item_name></td></tr>
	<tr><td>Brand<font color=red> * </font>:</td><td><input type=text name=item_brand></td></tr>
	<tr><td>Keep item in E-mart?</td><td><input type="radio" name="item_on_emart" value="YES">Yes &nbsp;<input type="radio" name="item_on_emart" value="NO">No</td></tr>
	<tr><td><input type=submit value=Insert></td><td><input type=reset></td></tr>
	</table>
	</form>
	</center>
<%@ include file="client_bottom.jsp"%>
