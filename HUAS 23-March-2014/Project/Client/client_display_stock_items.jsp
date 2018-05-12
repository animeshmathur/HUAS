<%@ include file="client_top.jsp"%>
	<script>
	function showUpdateItemForm(item_id)
	{
		$("#item_update_form").html("<br><br><br><h3>Loading...</h3>");
		$("#item_update_area").css("visibility","visible");
		$("#item_update_form").load("client_update_item_info.jsp","item_id="+item_id);
	}
	function closeItemUpdateForm()
	{
		$("#item_update_area").css("visibility","hidden");
		$("#item_update_form").html("<br><br><br><h3>Loading...</h3>");
	}
	
	function confirmRemoveAction(item_id)
	{
		if(prompt("Are you sure you want to remove this item from stock?If yes, type 'YES' below:\nNote: All information regarding this item will be permanently lost!")=="YES")
		{
			$("#items_list").html("<br><br><br><h3>Please Wait...</h3>");
			$.post("client_remove_item.jsp","item_id="+item_id,
			function(data,status)
			{
				alert(data);
				$("#stock_details").html("<br><br><br><h3>Loading...</h3>");
				$("#stock_details").load("client_display_stock_items.jsp");
			}
			);
		}
	}
	</script>
<script>
function checkStockDetails()
{
	if($("#new_stock_item").val()!='n/a'&&parseInt($("#new_stock_qty").val())&&parseFloat($("#new_stock_cp").val())&&parseFloat($("#new_stock_sp").val()))
	{
		$("#new_stock_qty").val(parseInt($("#new_stock_qty").val()));
		$("#new_stock_cp").val(parseFloat($("#new_stock_cp").val()));
		$("#new_stock_sp").val(parseFloat($("#new_stock_sp").val()));
		return true;
	}
	else
	{
		//alert(parseInt($("#new_stock_qty").val()));
		return false;
	}
}

function addItemStock(itemid,itemnm)
{
	$("#new_stock_item").val(itemid);
	$("#new_stock_item_name").html(itemnm);
	$("#add_stock_box").css("visibility","visible");
}

function addItemStockSubmit()
{
	if(checkStockDetails())
	{
		qs=$("#new_stock_form").serialize();
		//alert(qs);
		$.post("client_add_item_stock_submit.jsp",qs);
		new_qty=parseInt($("#item_"+$("#new_stock_item").val()+"_qty").text())+parseInt($("#new_stock_qty").val());
		//alert(new_qty);
		$("#item_"+$("#new_stock_item").val()+"_qty").html(new_qty);
		$("#add_stock_reset_button").click();
		$("#add_stock_box").css("visibility","hidden");
		alert("Stock added!");
	}
	else
	{
		alert("Kindly fill important details properly!");
	}
}
</script>
	<center>
	<div id="items_list">
		<i><h3>Items in Stock</h3></i>
		<%;
		ResultSet rs1=smt.executeQuery("select * from item_category");
		ResultSet rs2=null;
		if(rs1.next())
		{
			do
			{
			String item_name="";
			String item_id="";
			String item_brand="";
			%>
			<h4 style="float:left;">&bull; <%=rs1.getString("cat_name")%></h4>
			<table cellpadding=10 style="text-align:center;font-size:13px;width:98%;color:#4d4c4c;">
			<th>Item Name</th><th>Brand</th><th>Net Qty.</th><th>Stock</th><th>Details</th><th></th>
			<%
			int item_qty=0;
			rs2=cn.createStatement().executeQuery("select * from item_reg where cat_id='"+rs1.getString("cat_id")+"'");
			if(rs2.next())
			{
				do
				{
					item_qty=0;
					item_name=rs2.getString("item_name");
					item_id=rs2.getString("item_id");
					item_brand=rs2.getString("item_brand");
					try
					{
						ResultSet rs3=cn.createStatement().executeQuery("select sum(stock_item_qty) as net_qty from item_stocks where stock_item_id='"+item_id+"' group by stock_item_id");
						if(rs3.next())
						{
							if(Integer.parseInt(rs3.getString("net_qty"))>0)
							{item_qty=Integer.parseInt(rs3.getString("net_qty"));}
							else
							{item_qty=0;}
						}
						//out.println(item_qty);
						rs3.close();
					}
					catch(Exception e)
					{
						item_qty=0;
					}
					if(item_qty>10)
					{
						%>
						<tr bgcolor="#FFFFAA">
						<%
					}
					else if(item_qty==0)
					{
						%>
						<tr bgcolor="#FF4444" style="color:#FFFFFF;">
						<%
					}
					else
					{
						%>
						<tr bgcolor="#FFCC66">
						<%
					}
					%>
					<td><%=item_name%></td>
					<td><%=item_brand%></td>
					<td id="item_<%=item_id%>_qty"><%=item_qty%></td>
					<td style="width:150px;">
						<button onClick="addItemStock('<%=item_id%>','<%=item_name%>')"><font color="#00AA00">+</font> Add</button>
						&nbsp;&nbsp;
						<button id="stock_button_<%=item_id%>" onClick="openBox('extra_outer_box','extra_inner_box','client_edit_item_stock.jsp','item_id=<%=item_id%>&item_name=<%=item_name%>');">Edit</button>
					</td>
					<td style="width:100px;">
						<button id="update_button_<%=item_id%>" onClick="showUpdateItemForm('<%=item_id%>');">Change</button>
					</td>
					<td style="width:100px;">
						<button style="background-color:#FF6666;" onclick="confirmRemoveAction('<%=item_id%>');">Remove</button>
					</td>
				</tr>
				<%
				}while(rs2.next());
				%>
				</table>
				<%
			}
			}while(rs1.next());
		}
		else
		{
			%>
			<font color=red>* No items available</font>
			<%
		}
		%>
		<br><br>
	</div>
	<div id="item_update_area" style="padding:10px;width:80%;height:460px;position:fixed;top:100px;left:100px;border:double #AAAAAA thick;border-radius:20px;background-color:#FFFFFF;visibility:hidden;">
	<button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:#E5E5E5 solid thin;" onclick="closeItemUpdateForm();" title="Close">x</button><br><br>
	<div id="item_update_form" style="width:100%;height:420px;overflow-y:scroll;">
	<br><br><br><h3>Loading...</h3>
	</div>	
	<div id="add_stock_box" style="background-color:#FFFFFF;height:80%;width:60%;border:#4d4c4c solid 3px;border-radius:5px;position:fixed;top:10%;left:15%;visibility:hidden;border-radius:10px;">
	<button style="color:#FF6600;float:right;font-size:13px;border:0;padding:5px;" onclick="$('#add_stock_box').css('visibility','hidden');" title="Close">x</button>
	<h3>Add Stock</h3>
	<form id="new_stock_form" onsubmit="return false;">
	<input type="hidden" id="new_stock_item" name="stock_item" value="n/a">
	<table border="1" cellpadding="10px" style="width:98%;text-align:center;font-size:13px;border:thin #4d4d4d solid;">
		<tr><th>Item</th><td><span id="new_stock_item_name" style="font-weight:bold;"></span></td></tr>
		<tr><th>Quantity</th><td><input type="text" id="new_stock_qty" name="stock_qty"></td></tr>
		<tr><th>Cost Price (per item)</th><td><input type="text" id="new_stock_cp" name="stock_cp"></td></tr>
		<tr><th>Selling Price (per item)</th><td><input type="text" id="new_stock_sp" name="stock_sp"></td></tr>
		<tr><th>Date of Mfg.</th><td><input type="text" id="new_stock_mfg" name="stock_mfg" placeholder="(optional)"></td></tr>
		<tr><th>Date of Exp.</th><td><input type="text" id="new_stock_exp" name="stock_exp" placeholder="(optional)"></td></tr>
		<tr><td><input type="button" value="Insert" onclick="addItemStockSubmit();" style="background-color:#ffffff;color:#4d4c4c;padding:5px 10px;"></td><td><input id="add_stock_reset_button" type="reset" style="background-color:#ffffff;color:#4d4c4c;padding:5px 10px;"></td></tr>
	</table>
	</form>
	</div>
	</div>
	</center>
<%@ include file="client_bottom.jsp"%>
