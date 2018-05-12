<%@ include file="../include_top.jsp"%>
<%
String mart_id=request.getParameter("mart_id");
ses.putValue("mart_id",mart_id);
String mart_db="";
String mart_name="";
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992").createStatement().executeQuery("select mart_userid from MART_REGISTER where mart_id='"+mart_id+"'");
if(rs.next())
{
	ResultSet rs1=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992").createStatement().executeQuery("select firm_name,user_db from MERCHANT_REGISTER where userid='"+rs.getString("mart_userid")+"'");
	if(rs1.next())
	{
		mart_db=rs1.getString("user_db");
		ses.putValue("mart_db",mart_db);
		mart_name=rs1.getString("firm_name");
	}
	rs1.close();
}
rs.close();
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/"+mart_db,"hucky","13071992");
Statement stmt=cnn.createStatement();
%>
<style>
#mart_left
{
	float:left;
	width:78%;
	padding:20px 40px;
}
#mart_right
{
	float:right;
	width:20%;
}
.item_categories
{
	width:100%;
	background-color:#FFFFFF;
	color:#0066cc;
	font-size:13px;
	padding:3px 10px;
	text-align:left;
	border:#0066cc groove thin;
	border-radius:5px;
}
.category_items
{
	width:100%;
	text-align:center;
	font-size:13px;
}
.item_name
{
	font-weight:bold;
	color:#4d4c4c;
	font-size:12px;
}
.item_brand
{
	font-size:11.5px;
	color:#888888;
	font-style:italic;
}
.item_price
{
	font-size:12px;
	color:#4d4c4c;
}
.item:hover
{
	border-radius:20px;
	background-color:#FFFFCC;
}
</style>
<script>
function toggleCategoryView(area)
{
	$(area).slideToggle();
}

var selected_items=new Array();
var selected_items_qty=new Array();
var selected_items_cost=new Array();

function pushItem(itemid,cost)
{
	//var qty=parseInt(prompt("Quantity : "));
	var qty;
	if(qty=parseInt(prompt("Quantity : ")))
	{
		//alert(qty);
		selected_items.push(itemid);
		selected_items_qty.push(qty);
		selected_items_cost.push(cost);
		$("#item_"+itemid).attr("onclick","popItem('"+itemid+"')");
		//$("#item_"+itemid).css("border","#4d4c4c 2px inset");
		$("#item_"+itemid).css("background-color","#EEEEEE");
		$("#item_"+itemid).css("border-radius","20px");
		//alert(selected_items);
	}
}

function popItem(itemid)
{
	selected_items.splice(selected_items.indexOf(itemid),1);
	selected_items_qty.splice(selected_items.indexOf(itemid),1);
	selected_items_cost.splice(selected_items.indexOf(itemid),1);
	$("#item_"+itemid).attr("onclick","pushItem('"+itemid+"')");
	$("#item_"+itemid).css("background-color","");
	$("#item_"+itemid).css("border","");
	$("#item_"+itemid).css("border-radius","20px");
}

function placeOrder(ordered_items_prices)
{
	if(confirm("Submit Order?"))
	{
		$("#extra_inner_box").html("<center><br><br><img src=\"images/loading.gif\"><br><br><h3>Please Wait...</h3></center>");
		$.post("E-Mart/mart_submit_order.jsp","ordered_items="+selected_items+"&ordered_qty="+selected_items_qty+"&ordered_items_prices="+ordered_items_prices,
		function(data,status)
		{
			$("#extra_inner_box").html("<center><br><br><img src=\"images/tick.jpg\"><br><br><h3>Congrats! Your order has been placed successfully. </h3><br><button onclick=\"closeBox('extra_outer_box','extra_inner_box')\" style=\"width:160px;color:#FFFFFF;background-color:#FF2222;border:#4d4c4c groove thin;padding:5px 10px;\"><b>Close</b></button></center>");
		}
		);
	}
	else
	{
		return false;
	}
}
</script>
<div id="mart_left">
<center>
<h3><%=mart_name%></h3>
<%
rs=stmt.executeQuery("select * from item_category");
if(rs.next())
{
	do
	{
		%>
		<button class="item_categories" onclick="toggleCategoryView('#<%=rs.getString("cat_id")%>_area')">&nabla; --- <b><%=rs.getString("cat_name")%> ---</b></button><br>
		<div class="category_items" id="<%=rs.getString("cat_id")%>_area">
		<br>
		<%
		ResultSet rs1=cnn.createStatement().executeQuery("select * from item_reg where cat_id='"+rs.getString("cat_id")+"' and item_on_emart='YES'");
		if(rs1.next())
		{
			String item_cost="";
			int i=0;
			%>
			<table cellpadding="10" style="width:100%;text-align:center;font-size:12px;">
			<tr>
			<%
			ResultSet rs2=null;
			do
			{
				rs2=cnn.createStatement().executeQuery("select max(stock_item_sp) as item_cost from item_stocks where stock_item_id='"+rs1.getString("item_id")+"'");
				if(rs2.next())
				{
					item_cost=rs2.getString("item_cost");
				}
				rs2.close();
				if(item_cost!=null)
				{
					if(i%5==0&&i!=0)
					{
						%>
						</tr><tr>
						<%
					}
					%>
					<td>
						<div id="item_<%=rs1.getString("item_id")%>" class="item" style="padding:5px;" onclick="pushItem('<%=rs1.getString("item_id")%>','<%=item_cost%>')">
						<img src="images/no_image.jpg" height="80px" alt="<%=rs1.getString("item_name")%>"><br><br>
						<span class="item_name"><%=rs1.getString("item_name")%> </span><span class="item_brand"> - <%=rs1.getString("item_brand")%></span><br><span class="item_price">Rs. <font color="#00BB00"><%=item_cost%></font> /-</span>
						</div>
					</td>
					<%
					i++;
				}
			}while(rs1.next());
			if(i%5!=0)
			{
				while(i>5&&i%5!=0)
				{
					%><td></td><%
					i++;
				}
				%></tr><%
			}
			%>
			</table>
			<%
		}
		%>
		</div>
		<br>
		<%
	}while(rs.next());
}
%>
<!--script>$(".category_items").slideUp();</script-->
</center>
</div>
<div id="mart_right">
<table cellspacing="20px" style="width:100px;position:fixed;right:10px;top:15px;border-left:#0066cc 3px groove">
	<tr>
		<td>
			<a href="#" onclick="return(closeMart());"><img src="images/exit.png" title="Exit"><br><b><font color="#FF0000" style="font-size:12px;">EXIT</font></b></a>
		</td>
	</tr>
	<tr>
		<td>
			<a href="#" onclick="return(proceedToBill());"><img src="images/cart.bmp"><br><b><font color="#006600" style="font-size:12px;">Proceed To Order</font></b></a>
		</td>
	</tr>
</table>
<div id="extra_outer_box" style="background-color:#FFFFFF;height:80%;width:60%;border:#0066CC solid 3px;border-radius:5px;position:fixed;top:10%;left:15%;visibility:hidden;border-radius:10px;">
	<button style="color:#FF6600;float:right;font-size:13px;border:0;padding:5px;" onclick="closeBox('extra_outer_box','extra_inner_box');" title="Close">x</button>
	<div id="extra_inner_box" style="width:100%;height:92%;overflow-y:scroll;"><center><br><br><img src="images/loading.gif"><br><br><h3>Loading...</h3></center></div>
</div>
</div>
<img src="images/HUAS.png" height=30px width=80px style="position:fixed;opacity:8;bottom:20px;right:20px;">
<%@ include file="../include_bottom.jsp"%>


