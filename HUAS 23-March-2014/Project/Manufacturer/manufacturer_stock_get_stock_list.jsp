<%@ include file="manufacturer_top.jsp"%>
<%
ResultSet rs=smt.executeQuery("select * from products");
if(rs.next())
{
	%>
	<table cellpadding="10" width="80%" style="text-align:center;border:groove thin #E5E5E5;border-radius:10px;font-size:16px;color:#4D4C4C;background-color:#FFFFFF;">
		<tr><th>Product_Name</th><th>Product_Code</th><th>Quantity Status</th><th>Last Manufactured On</th><th>Earliest Expiry On</th><th>Options</th></tr>
		<%
		do
		{
			if(cn.createStatement().executeQuery("show tables like 'product_"+rs.getString("product_id")+"_details'").next())
			{
				ResultSet rs1=cn.createStatement().executeQuery("select sum(quantity) as total_quantity,max(date_of_mfg) as mfg,min(date_of_exp) as exp from product_stock where product_id='"+rs.getString("product_id")+"' group by product_id");
				if(rs1.next())
				{
					%>
					<tr><td><b><%=rs.getString("product_name")%></b></td><td><%=rs.getString("product_code")%></td><td><%=rs1.getString("total_quantity")%></td><td><%=rs1.getString("mfg")%></td><td><%=rs1.getString("exp")%></td><td><button style="padding:10px;font-size:14px;" onclick="editStockEntries('<%=rs.getString("product_id")%>','<%=rs.getString("product_name")%>')"><b>Edit Stock Entries</b></button></td></tr>
					<%
				}
				else
				{
					%>
					<tr><td><b><%=rs.getString("product_name")%></b></td><td><%=rs.getString("product_code")%></td><td>- <i>Not Defined</i> -</td><td>- <i>Not Defined</i> -</td><td>- <i>Not Defined</i> -</td><td>-</td></tr>
					<%
				}
			}
		}while(rs.next());
		%>
	</table>
	<br>
	<table cellpadding="50">
		<tr><td><button style="padding:10px;background-color:#FFFFFF;color:#0066CC;" onclick="showAddStockForm();"><font color="#008800" style="font-size:20px;"><b>+</b></font>&nbsp;&nbsp;&nbsp;<span style="font-size:14px;"><b>Insert New Stock</b></span></button></td></tr>
	</table>
	<div id="add_stock_form" style="z-index:2;position:fixed;top:130px;left:100px;width:88%;height:440px;border:solid thin #4D4C4C;background-color:#FFFFFF;visibility:hidden;">
	<button style="background:#FFFFFF;color:#FF6600;float:right;font-size:13px;border:0px;padding:10px;" onclick="closeAddStockForm();" title="Close">x</button>
	<h3 style="color:#0066CC;width:80%;">&bull; New Stock &bull;</h3>
	<form action="manufacturer_stock_add_stock_submit.jsp" onsubmit="return(checkAddStockForm());" method="post">
	<table cellpadding="15" style="width:88%;text-align:center;">
		<tr>
			<td><b>Select Product</b> <sup style="color:#FF0000;font-size:12px;">*</sup> :</td>
			<td>
				<select name="add_stock_product_id" id="add_stock_product_id" style="background-color:#FFFFFF;color:#0066CC;min-width:300px;">
					<option value="-1" style="color:#AAAAAA;">--- Select Product ---</option>
					<%
					rs.close();
					rs=smt.executeQuery("select * from products");
					while(rs.next())
					{
						if(cn.createStatement().executeQuery("show tables like 'product_"+rs.getString("product_id")+"_details'").next())
						{
							%>
							<option value="<%=rs.getString("product_id")%>"><%=rs.getString("product_name")%></option>
							<%
						}
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td><b>Quantity</b> <sup style="color:#FF0000;font-size:12px;">*</sup> :</td><td><input type="text" name="add_stock_quantity" id="add_stock_quantity" style="width:300px;"></td>
		</tr>
		<tr>
			<td><b>Date Of Manufacturing</b> <i style="color:#AAAAAA;">(Optional)</i> :</td>
			<td>
				<select name="add_stock_day_of_mfg" id="add_stock_day_of_mfg" style="background-color:#FFFFFF;width:50px;">
				<option value="-">Day</option>
				<%
				for(int i=1;i<=31;i++)
				{
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				</select>	
				&nbsp;&nbsp;&nbsp;<select name="add_stock_month_of_mfg" id="add_stock_month_of_mfg" style="background-color:#FFFFFF;width:160px;"><option value="-">Month</option><option value="1">January</option><option value="2">February</option><option value="3">March</option><option value="4">April</option><option value="5">May</option><option value="6">June</option><option value="7">July</option><option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option><option value="12">December</option></select>&nbsp;&nbsp;&nbsp;
				<select name="add_stock_year_of_mfg" id="add_stock_year_of_mfg" style="background-color:#FFFFFF;width:60px;">
				<option value="-">Year</option>
				<%
				for(int i=2000;i<=2050;i++)
				{
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				</select>
			</td>
		</tr>
		<tr>
			<td><b>Date Of Expiry</b> <i style="color:#AAAAAA;">(Optional)</i> :</td>
			<td>
				<select name="add_stock_day_of_exp" id="add_stock_day_of_exp" style="background-color:#FFFFFF;width:50px;">
				<option value="-">Day</option>
				<%
				for(int i=1;i<=31;i++)
				{
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				</select>
				&nbsp;&nbsp;&nbsp;<select name="add_stock_month_of_exp" id="add_stock_month_of_exp" style="background-color:#FFFFFF;width:160px;"><option value="-">Month</option><option value="1">January</option><option value="2">February</option><option value="3">March</option><option value="4">April</option><option value="5">May</option><option value="6">June</option><option value="7">July</option><option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option><option value="12">December</option></select>&nbsp;&nbsp;&nbsp;
				<select name="add_stock_year_of_exp" id="add_stock_year_of_exp" style="background-color:#FFFFFF;width:60px;">
				<option value="-">Year</option>
				<%
				for(int i=2000;i<=2050;i++)
				{
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				</select>
				</td>
		</tr>
	</table><br>
	<button type="submit" style="padding:10px 20px;background-color:#4D4C4C;color:#FFFFFF;"><b>ADD</b></button>
	</form>
	</div>
	<%
}	
%>
<%@ include file="manufacturer_bottom.jsp"%>
