<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<style>
		td
		{
			text-align:center;
		}
		</style>
		</head>
		<body>
		<%@ include file="include_header.jsp"%>
		<center>
			<h3><span style="color:#FF6600">::</span>&nbsp;<i>My Bids</i>&nbsp;<span style="color:#FF6600">::</span></h3>
			<%
			String q="select * from seller_item_bids where userid='"+userid+"'";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				String item_id="";
				String item_name="";
				String item_img="";
				long bid_value=0;
				long item_highest_bid=0;
				String q1="";
				Statement smt1=cn.createStatement();
				ResultSet rs1=null;
				%>
				<table cellspacing=5 width=100%>
					<tr>	
						<td>		
							<b>Probability Legend:</b>
						</td> 
						<td>
							<span style="background-color:#00CC00">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;100%
						</td>
						<td>
							<span style="background-color:#CCFF33">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;75-100% 
						</td>
						<td>
							<span style="background-color:#FFCC66">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;50-75% 
						</td>
						<td>
						<span style="background-color:#FFFF66">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&le;50% 
						</td>
					</tr>
				</table>
				<table cellpadding=10 width=100%>
						<th></th><th>Item Name</th><th>Highest Bid</th><th>Your Bid</th>
				<%
				do
				{
					item_id=rs.getString("seller_item_id");
					bid_value=Long.parseLong(rs.getString("bid_value"));
					q1="select seller_item_name,seller_item_image from seller_items where seller_item_id='"+item_id+"'";
					rs1=smt1.executeQuery(q1);
					if(rs1.next())
					{
						item_name=rs1.getString(1);
						item_img=rs1.getString(2);
					}
					rs1.close();
					
					q1="select max(bid_value) from seller_item_bids where seller_item_id='"+item_id+"'";
					rs1=smt1.executeQuery(q1);
					if(rs1.next())
					{
						item_highest_bid=Long.parseLong(rs1.getString(1));
					}
					rs1.close();
					%>
						<%
						float bid_per=((float)bid_value/(float)item_highest_bid)*100;
						if(bid_per==100)
						{
						%>
						<tr style="background-color:#00CC00">
							<td><img src="uploads/<%=item_img%>" alt="uploads/no_image.jpg" height="50px" width="55px"></td>
							<td><a href="#" onclick="openBox('extra_outer_box','extra_inner_box','user_item_details.jsp','item_id=<%=item_id%>');return false;" style="color:blue"><%=item_name%></a></td>
							<td><%=item_highest_bid%></td>
							<td><%=bid_value%></td>
						</tr>
						<%	
						}
						else if((bid_per>=75)&&(bid_per<100))
						{
						%>
						<tr style="background-color:#CCFF33">
							<td><img src="uploads/<%=item_img%>" alt="uploads/no_image.jpg" height="50px" width="55px"></td>
							<td><a href="user_item_details.jsp?item_id=<%=item_id%>" style="color:blue"><%=item_name%></a></td>
							<td><%=item_highest_bid%></td>
							<td><%=bid_value%></td>
						</tr>
						<%
						}
						else if((bid_per>=50)&&(bid_per<75))
						{
						%>
						<tr style="background-color:#FFCC66">
							<td><img src="uploads/<%=item_img%>" alt="uploads/no_image.jpg" height="50px" width="55px"></td>
							<td><a href="user_item_details.jsp?item_id=<%=item_id%>" style="color:blue"><%=item_name%></a></td>
							<td><%=item_highest_bid%></td>
							<td><%=bid_value%></td>
						</tr>
						<%
						}
						else if(bid_per<50)
						{
						%>
						<%=bid_per%>
						<tr style="background-color:#FFFF66">
							<td><img src="uploads/<%=item_img%>" alt="uploads/no_image.jpg" height="50px" width="55px"></td>
							<td><a href="user_item_details.jsp?item_id=<%=item_id%>" style="color:blue"><%=item_name%></a></td>
							<td><%=item_highest_bid%></td>
							<td><%=bid_value%></td>
						</tr>
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
				<span style="color:green">* You did not place any bid on any item yet! *</span>
				<%
			}
			%>
			<br><br><i>Go to Buyer's Zone and select an item to bid upon.</i><br><br>
			<a style="color:#0066CC;font-size:28px" href="user_buyer.jsp"><b><u>Enter Buyer's Zone!</u></b> -></a>
		</center>
		<%@ include file="include_footer.jsp"%>
		</body>
		</html>
<%@ include file="include_bottom.jsp"%>



