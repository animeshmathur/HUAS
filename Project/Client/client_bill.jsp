<%@page import="java.util.*"%>
<%@ include file="client_top.jsp"%>
<%
	String err=request.getParameter("err");
%>
	<html>
	<head>
	<%@ include file="client_head.jsp"%>
	<script>
	<%
	ResultSet rs=smt.executeQuery("select item_id,item_name from item_reg");
	if(rs.next())
	{
		int i=0;
		%>
		var item_id=new Array();
		var item_name=new Array();
		var item_qty=new Array();
		<%
		ResultSet rs1=null;
		do
		{
			rs1=cn.createStatement().executeQuery("select sum(stock_item_qty) as item_net_qty from item_stocks where stock_item_id='"+rs.getString("item_id")+"' group by stock_item_id");
			if(rs1.next())
			{
				int item_qty=0;
				try
				{
					item_qty=Integer.parseInt(rs1.getString("item_net_qty"));
					if(item_qty>0)
					{
					%>
					item_id[<%=i%>]="<%=rs.getString("item_id")%>";
					item_name[item_id[<%=i%>]]="<%=rs.getString("item_name")%>";
					item_qty[item_id[<%=i%>]]="<%=rs1.getString("item_net_qty")%>";
					<%
					i++;
					}
				}
				catch(Exception ex)
				{
					item_qty=0;
				}
			}
			rs1.close();
		}while(rs.next());
	}
	%>	
	var item_no=1;
	
	$(document).ready(
		function()
		{
			var item_list=document.getElementById("item_list");
			var code="<tr id=item_no_"+item_no+">";
			code+="<td><font color=#0066CC><i>("+item_no+").</i></font></td>";
			code+="<td style=\"width:80%;\"><select name=item_id_"+item_no+" id=item_id_"+item_no+" onChange=\"setQuantity("+item_no+");\" style=\"padding:5px;text-align:center;color:#0066CC;background-color:#FFFFFF;width:100%;\">";
			code+="<option value=-1>------ Select item ------</option>"
			for(i=0;i<item_id.length;i++)
			{
				code+="<option value="+item_id[i]+">"+item_name[item_id[i]]+"</option>";
			}
			code+="</select></td>";
			code+="<td style=\"width:15%;\"><select name=item_qty_"+item_no+" id=qty_of_"+item_no+" onChange=\"document.getElementById('addItemButton').focus()\" style=\"padding:5px;text-align:center;color:#0066CC;background-color:#FFFFFF;width:100%;\">";
			code+="<option value=-1>----- Qty -----</option>";
			code+="</select></td>";
			code+="</tr>";
			item_list.innerHTML=code;
			document.getElementById('item_id_'+item_no).focus();
		}
	);
	
	function setQuantity(item_no)
	{
		selected_item_id=document.getElementById('item_id_'+item_no).value;
		var x=document.getElementById("qty_of_"+item_no);
		//alert(item_id.indexOf(y.value));
		var code="<option value=-1>----- Qty -----</option>";
		for(i=1;i<=parseInt(item_qty[selected_item_id]);i++)
		{
			code+="<option value=\""+i+"\">"+i+"</option>";
		}
		x.innerHTML=code;
		x.focus();
	}
	
	function removeItemField()
	{
		$(document).ready(
		function()
		{
			$("#item_no_"+item_no).remove();
			item_no--;
			if(item_no!=1)
			{
				$("#item_no_"+item_no).append("<td><button id=\"removeItemButton_"+item_no+"\" onclick=\"removeItemField()\" style=\"background-color:#FFFFFF;color:#FF6600;border:#FF6600 solid thin;border-radius:5px;\">-</button></td>");
			}
		}
		);
	}
	
	$(document).ready(
	function()
	{
		$("#addItemButton").click(
		function()
		{
			$("#removeItemButton_"+item_no).remove();
			item_no++;
			var code="<tr id=item_no_"+item_no+">";
			code+="<td><font color=#0066CC><i>("+item_no+").</i></font></td>";
			code+="<td style=\"width:80%;\"><select name=item_id_"+item_no+" id=item_id_"+item_no+" onChange=\"setQuantity("+item_no+");\" style=\"padding:5px;text-align:center;color:#0066CC;background-color:#FFFFFF;width:100%;\">";
			code+="<option value=-1>------ Select item ------</option>"
			for(i=0;i<item_id.length;i++)
			{
				code+="<option value="+item_id[i]+">"+item_name[item_id[i]]+"</option>";
			}
			code+="</select></td>";
			code+="<td style=\"width:15%;\"><select name=item_qty_"+item_no+" id=qty_of_"+item_no+" onChange=\"document.getElementById('addItemButton').focus()\" style=\"padding:5px;text-align:center;color:#0066CC;background-color:#FFFFFF;width:100%;\">";
			code+="<option value=-1>----- Qty -----</option>";
			code+="</select></td>";
			code+="<td><button id=\"removeItemButton_"+item_no+"\" onclick=\"removeItemField()\" style=\"background-color:#FFFFFF;color:#FF6600;border:#FF6600 solid thin;border-radius:5px;\">-</button></td>";
			code+="</tr>";
			$("#item_no_"+(item_no-1)).after(code);
			document.getElementById('item_id_'+item_no).focus();
		}
		);
	}
	);	
	</script>
	<script type="text/javascript">
	
	function checkField()
	{
		if(document.currentForm.item_id_1.value=="-1")
		{
			alert("Please select an item!");
			return false;
		}
		if(document.currentForm.item_qty_1.value=="-1")
		{
			alert("Please specify the quantity!");
			return false;
		}
		document.getElementById('total_items_field').innerHTML="<input type=hidden name=total_items value=\""+item_no+"\">";
		submitItems();
	}
	
	function submitItems()
	{
		bill_data=$("form").serialize();
		openBox("extra_outer_box","extra_inner_box","client_bill_display.jsp",bill_data);
	}
	</script>
	</head>
	<body>
	<%@ include file="client_header.jsp"%>
	<center>
		<%
		String msg=request.getParameter("msg");
		if(msg!=null)
		{
			%>
			<font color=green>* Billing Completed :)</font>
			<%
		}
		%>
	<form action="client_bill_display.jsp" name="currentForm" method="post" onsubmit="return false;">
	<h3 style="color:#0066CC;"><i>Billing</i></h3>
	<%
	if(err!=null)
	{
		%>
		<font color=red>* Invalid Items in List</font>
		<%
	}
	%>
	<table cellpadding=5 id="item_list" style="width:80%;text-align:center;">
	</table>
	<br>
	<p id="total_items_field"></p>
	<input type="button" value="+ Add Item" id="addItemButton" style="height:30px;background-color:#FF6600;color:#FFFFFF;width:150px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" id="reset_button" value="Reset" style="height:30px;background-color:#FF3333;color:#FFFFFF;width:150px;"><br><br><br>
	<input type="button" onclick="checkField();" value="Proceed  &gt;&gt;" style="height:30px;background-color:#0066CC;color:#FFFFFF;width:150px;">
	<div id="total_item_field"></div>
	</form>
	</center>
	<%@ include file="client_footer.jsp"%>
	</body>
	</html>
<%@ include file="client_bottom.jsp"%>
