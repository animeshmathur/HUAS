<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<script type="text/javascript">
		function removeRentItem(item)
		{
			if(confirm("Are you sure, do you want to remove this item from rent?"))
			{
				$("#rent_"+item).remove();
				$.post("user_rent_remove.jsp","item="+item);
			}
		}
		</script>
		<%
			String seller_msg="";
			seller_msg=request.getParameter("seller_msg");
			if(seller_msg!=null)
			{
				if(Integer.parseInt(seller_msg)==1)
				{
					%>
					<script type="text/javascript">
					alert("Item Removed!");
					</script>
					<%
				}
			}
			
			String msg=request.getParameter("msg"); 
			if(msg!=null)
			{
				if(msg.equals("Rent_Removed"))
				{
					%>
					<script type="text/javascript">
					alert("Rentable Removed!");
					</script>
					<%
				}
			}
		%>
		</head>
		<body>
		<%@ include file="include_header.jsp"%>
			<center>
			<div style="width:100%;"> 
			<%
			String q="select * from seller_items where userid='"+userid+"' order by seller_item_date";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				String item_id="";
				String item_status="";
				%>
				<h3><span style="color:#FF6600;">::</span>&nbsp;<i>Items for Sale</i>&nbsp;<span style="color:#FF6600">::</span></h3>
				<table cellpadding="5" style="background-color:#FFFFDD;width:100%;font-size:12px;border-style:solid;border-color:#FFCC66;border-width:2px;border-radius:15px;padding-bottom:">
				<%				
				do
				{
					item_id=rs.getString("seller_item_id");
					item_status=rs.getString("seller_item_status");
					%>
					<tr>
					<td>
						<img src="uploads/<%=rs.getString(5)%>" alt="no_image.jpg" height=50 width=50>
					</td>
					<td>
						<i><a onclick="return(openBox('extra_outer_box','extra_inner_box','user_item_details.jsp','item_id=<%=item_id%>'));" href="#" style="color:#0066CC"><b><%=rs.getString("seller_item_name")%></b></a></i>
						<%
						if(rs.getString("seller_item_price_type").equals("Bid"))
						{
							%>
							<br><span style="color:#FF0000;font-size:10px">ON BID!</span>
							<%
						}
						%>
					</td>
					<td>
						<i><b><font color=green><%=item_status%></font></b></i>
					</td>
					<td>
						<a href="#" onclick="openBox('extra_outer_box','extra_inner_box','user_seller_view_item_requests.jsp','item_id=<%=item_id%>');return false;" style="color:#0066CC;font-size:13px;"><u>View Requests</u></a>
					</td>
					</tr>
					<%
				}while(rs.next());
				%>
				</table><br><br>
				<%
			}
			rs.close();
			%>
			</div>
			<div style="width:100%;">
			<%
			q="select * from user_rents where userid='"+userid+"'";
			rs=smt.executeQuery(q);
			if(rs.next())
			{
			%>
				<h3><span style="color:#FF6600">::</span>&nbsp;<i>Items for Rent</i>&nbsp;<span style="color:#FF6600">::</span></h3>
				<table border=0 cellpadding=5 style="background-color:#FFFFCC;width:100%;font-size:12px;border-style:solid;border-color:#FFCC66;border-width:2px;border-radius:15px;">
				<%
				do
				{
					%>
					<tr id="rent_<%=rs.getString("rent_id")%>">
						<td>
							<b><font color=#0066CC><%=rs.getString("rent_title")%></font></b>
						</td>
						<td>
							<font color=#0066CC>
							<b>Cost:</b> <br><i><%=rs.getString("rent_cost")%></i><br><b>Contact:</b> <br><i><%=rs.getString("rent_contact")%></i>
							</font>
						</td>
						<td>
							<textarea cols=20 rows=2 readonly=true style="color:#0066CC;background-color:#FFFFCC;resize:none;border-width:0px"><%=rs.getString("rent_details")%></textarea>
						</td>
						<td>
							<font color=#FF6600><b>On Rent</b></font>
						</td>
						<td>
							<button onclick="removeRentItem('<%=rs.getString("rent_id")%>');" style="font-size:12px;color:#FFFFFF;background-color:#FF0000;width:60px;">Remove!</button>
						</td>
					</tr>
					<%
				}while(rs.next());
				%>
				</table>
				<%
			}
			%>
		</div>
		</center>
		<%@ include file="include_footer.jsp"%>
		</body>
		</html>
<%@ include file="include_bottom.jsp"%>
