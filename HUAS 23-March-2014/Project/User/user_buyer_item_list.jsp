<%@ include file="include_top.jsp"%>
<%
	int start=Integer.parseInt(request.getParameter("start"));
	//out.println(start);
%>
<style>
.items
{
	background-color:#FFFFFF;
}
</style>
<%
ResultSet rs=smt.executeQuery("select * from seller_items where seller_item_status='On Sale' order by date(seller_item_date) desc limit "+start+",15");
int count=1;
if(rs.next())
{
	do
	{
		%>
		<style>
		#item_button_table:hover
		{
			border-radius:25px;
			background-color:#E5E5E5;
		}
		</style>
		<table cellpadding=10 id="item_button_table" style="width:33%;float:left;">
		<tr>
		<td>
		<button onclick="return(viewItemInfo('<%=rs.getString(1)%>'));" class="item_button" style="width:100%;background-color:#FFFFFF;border-color:#CACACA;border-style:groove;border-width:thin;">
		<table cellpadding=6 cellspacing=5 style="width:100%;text-align:center;font-size:13px;">
		<tr>
			<td class="items" style="width:68px;text-align:center;">
				<img src="uploads/<%=rs.getString(5)%>" alt="uploads/no_image.jpg" height=60px><br><br>
				<%
				if(!userid.equals(rs.getString(2)))
				{
					%>
					<font color=green><i>On Sale</i></font>
					<%
				}
				else
				{
					%>
					<font color=#FF6600><i>My Item</i></font>
					<%
				}
				%>
			</td>
			<td class="items" style="width:100%;text-align:center;">
				<span style="color:#0066CC;font-size:14px;">
					<i><b><%=rs.getString(3)%></b></i>
				</span>
				<%
				if(rs.getString("seller_item_price_type").equals("Bid"))
				{
					%>
					<br><br>&nbsp;&nbsp;<blink style="color:#FF0000;font-size:12px"><i>On Bid!</i></blink>
					<%
				}
				%>
			</td>
		</tr>
		</table>
		</button>
		</td>
		</tr>
		</table>
		<%
		count++;
	}while(rs.next()&&count<=15);
	%>
	<div id="item_navigators" style="float:left;width:100%;height:50px;padding:20px 20px;">
		<button id="button_previous" style="float:left;width:200px;background-color:#0066CC;color:#FFFFFF;font-weight:bold;" onclick="getPreviousList();">&lt;&lt; Previous</button>
		<button id="button_next" style="float:right;width:200px;background-color:#0066CC;color:#FFFFFF;font-weight:bold;" onclick="getNextList();">Next &gt;&gt;</button>
	</div>
	<%
	if(start==0)
	{
		%>
		<script>
		$("#button_previous").hide();
		</script>
		<%
	}
	else if(start!=0)
	{
		%>
		<script>
		$("#button_previous").show();
		</script>
		<%
	}
	if(count<=15)
	{
		%>
		<script>
		$("#button_next").hide();
		</script>
		<%
	}
	else
	{
		%>
		<script>
		$("#button_next").show();
		</script>
		<%
	}
}
%>
<%@ include file="include_bottom.jsp"%>

