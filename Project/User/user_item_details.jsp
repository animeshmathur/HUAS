<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		
		long min_bid_value=0;
		
		String q="select seller_item_price from seller_items where seller_item_id='"+item_id+"'";
		ResultSet rs=smt.executeQuery(q);
		if(rs.next())
		{
			min_bid_value=Long.parseLong(rs.getString(1));
		}
		rs.close();
%>
		<script>
		$(document).ready(
		function()
		{
			$("#bid_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#bid_button").click(
			function()
			{
				$("#bid_button_area").slideUp(
				function()
				{
					$("#bid_form").fadeIn();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#bid_cancel_button").click(
			function()
			{
				$("#bid_form").fadeOut(
				function()
				{
					$("#bid_button_area").slideDown();
				}
				);
			}
			);						
		}
		);
		
		$(document).ready(
		function()
		{
			$("#bid_update_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#bid_update_button").click(
			function()
			{
				$("#bid_update_area").slideUp(
				function()
				{
					$("#bid_update_form").fadeIn();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#bid_update_cancel_button").click(
			function()
			{
				$("#bid_update_form").fadeOut(
				function()
				{
					$("#bid_update_area").slideDown();
				}
				);
			}
			);						
		}
		);
		</script>
		<script type="text/javascript">
		
		function confirmItemRequest()
		{
			var act=confirm("You are about to send your request to the seller! Continue?");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		function confirmRemoveAction()
		{
			var act=confirm("Are you sure you want to remove this item from sale?");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		
		function changePicture()
		{
			var x=document.getElementById("change_picture");
			x.innerHTML="<form action=\"user_change_item_image.jsp?itemid=<%=item_id%>\">Select Picture: <input type=file name=item_pic>&nbsp&nbsp<input type=submit value=Change></form>";
		}
		
		function checkQuery(item_id)
		{
			if(document.item_query.query.value==""||document.item_query.query.value==" "||document.item_query.query.value=="  ")
			{
				alert("Please enter your query!");
				return false;
			}
			loadBox('user_item_query.jsp','query='+document.getElementById('new_query').value+'&item_id='+item_id);
			return true;
		}
		
		function checkBid(url,item_id,action)
		{
			new_bid=document.getElementById('new_bid_value').value;
			//alert("hello");
			if(new_bid==""||!parseInt(new_bid,10))
			{
				alert("Please provide the proper bid value!");
				return false;
			}
			if(parseInt(new_bid,10)<=parseInt(<%=min_bid_value%>,10))
			{
				alert("Bid Should be greater than Rs. "+<%=min_bid_value%>+"/-");
				return false;
			}
			loadBox(url,'item_id='+item_id+'&bid_value='+parseInt(new_bid,10));
		}
		
		function confirmCancelBid()
		{
			var act=confirm("Are you sure you want to cancel your placed bid?\nNote: This action can't be undone.");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		</script>
		
		<style>
		.rupees
		{
			color:green;
		}
		</style>
			<%
			String seller_msg="";
			seller_msg=request.getParameter("seller_msg");
			if(seller_msg!=null)
			{
				if(Integer.parseInt(seller_msg)==1)
				{
					%>
					<script type="text/javascript">
					alert("Item Details Updated!");
					</script>
					<%
				}
			}
			String buyer_request_msg="";
			buyer_request_msg=request.getParameter("buyer_request_msg");
			if(buyer_request_msg!=null)
			{
				if(Integer.parseInt(buyer_request_msg)==0)
				{
					%>
					<script type="text/javascript">
					alert("Your request is already placed to the seller!\nPlease wait while the seller acknowledge...Thank You.");
					</script>
					<%
				}
				if(Integer.parseInt(buyer_request_msg)==1)
				{
					%>
					<script type="text/javascript">
					alert("Your request is delivered for seller's consideration!\nThank You.");
					</script>
					<%
				}
			}
			
			String bid_msg=request.getParameter("msg");
			if(bid_msg!=null)
			{
				if(bid_msg.equals("notDigit"))
				{
					%>
					<script type="text/javascript">
					alert("Please enter valid bid value in digits!");
					</script>
					<%
				}
				if(bid_msg.equals("done"))
				{
					%>
					<script type="text/javascript">
					alert("Your bid is placed succesfully!");
					</script>
					<%
				}
				if(bid_msg.equals("updated"))
				{
					%>
					<script type="text/javascript">
					alert("Your bid value is updated successfully!");
					</script>
					<%
				}
				if(bid_msg.equals("cancelled"))
				{
					%>
					<script type="text/javascript">
					alert("Your bid is cancelled successfully!");
					</script>
					<%
				}
			}
			
			String seller_id="";
			q="select * from seller_items where seller_item_id='"+item_id+"'";
			rs=smt.executeQuery(q);
			if(rs.next())
			{
				seller_id=rs.getString(2);		
				%>
				<center>
				<div id="item_details" style="width:85%;height:440px">
				<center>
				<h3><i><%=rs.getString(3)%></i></h3>
				<div id="item_img" style="float:left;width:35%;height:370px">
					<img src="uploads/<%=rs.getString(5)%>" height=60% width=100% alt="uploads/no_image.jpg"><br>  
					<p><b>Status</b>:<i> <font color=green><%=rs.getString(6)%></font></i></p>
					<%
						String q1="select user_name,user_contact from user_register where userid='"+seller_id+"'";
						Statement smt1=cn.createStatement();
						String seller_name="";
						String seller_contact="";
						ResultSet rs1=smt1.executeQuery(q1);
						if(rs1.next())
						{
							seller_name=rs1.getString(1);
							seller_contact=rs1.getString(2);
						}
						rs1.close();
					%>
					<p><b>Seller: </b><i><%=seller_name%></i></p>
					<p><b>Contact: </b><i>+91-<%=seller_contact%></i></p>
				</div>
				<div id=item_description style="float:right;width:65%;height:370px">
					<center><b><i><font color=#AAAAAA>Description</font></i></b></center><br>
					<textarea wrap="hard" readonly=true cols=50 rows=8 style="border-radius:10px;border-color:#666666;border-style:solid;border-width:thin;color:#0066CC;background-color:#FFFFDD;font-size:13px;resize:none;padding:10px 10px;" disabled><%=rs.getString(4)%></textarea>
					<br>
					<%
					if(rs.getString("seller_item_price_type").equals("Bid"))
					{
						String highest_bid="";
						q1="select max(bid_value) from seller_item_bids where seller_item_id='"+item_id+"'";
						rs1=smt1.executeQuery(q1);
						if(rs1.next())
						{
							highest_bid=rs1.getString(1);
						}
						if(highest_bid!=null)
						{
							%>
							<br>	
							Highest Bid Placed :<i> <span class="rupees">Rs.</span> <font color=blue><%=highest_bid%></font> /-</i><br><br>
							<%
						}
						%>
						Minimum Bid Value :<i> <span class="rupees">Rs.</span> <font color=blue><%=min_bid_value%></font> /-</i><br>
						<%
					}
				
					if(seller_id.equals(userid))
					{
						%>
						<table cellpadding=10>
							<tr>
								<td>
									<button onclick="loadBox('user_seller_view_item_requests.jsp','item_id=<%=item_id%>');" style="background-color:#006600;color:#FFFFFF">View Requests</button>
								</td>
								<td>
									<button onclick="loadBox('user_seller_edit_item_details.jsp','item_id=<%=item_id%>')" style="background-color:#FF6600;color:#FFFFFF">Edit Details</button>
								</td>
								<td>
									<button onclick="if(confirm('Are you sure, do you want to remove this item?')){loadBox('user_seller_remove_item.jsp','item_id=<%=item_id%>');}" style="background-color:#FF0000;color:#FFFFFF">Remove</button>
								</td>
							</tr>
							</table>
							<%
							if(rs.getString("seller_item_price_type").equals("Fixed"))
							{
								%>
								<table>
								<tr>
									<td>
										<i>Price : <span class="rupees">Rs.</span> <font color=blue><%=rs.getString("seller_item_price")%></font> /-</i>
									</td>
								</tr>
								</table>
								<%
							}
					}
					else
					{
						%>
						<br>
						<%
						if(rs.getString("seller_item_price_type").equals("Fixed"))
						{
							%>
							<i>Price : <span class="rupees">Rs.</span> <font color=blue><%=rs.getString("seller_item_price")%></font> /-</i>
							<%
						}
						else if(rs.getString("seller_item_price_type").equals("Bid"))
						{
							String q2="select * from seller_item_bids where userid='"+userid+"' and seller_item_id='"+item_id+"'";
							Statement smt2=cn.createStatement();
							ResultSet rs2=smt2.executeQuery(q2);
							if(rs2.next())
							{
								%>
								<span id="bid_update_area">
								<table>
								<tr>
									<td>
										Your Bid:<i> <span class="rupees">Rs.</span> <font color=blue><%=rs2.getString("bid_value")%></font> /-</i>
									</td>
									<td>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="bid_update_button" style="background-color:#0066CC;color:#FFFFFF;">:: Update ::</button>
									</td>
								</tr>
								</table>
								<table>
									<tr>
										<td style="text-align:center;">
												<button onclick="if(confirm('Cancel your bid?')){loadBox('user_item_cancel_bid.jsp','item_id=<%=item_id%>')}" style="background-color:#FFFFFF;color:#FF0000;border-color:#FF6666;border-width:thin;border-style:solid;">:: Cancel Your Bid ::</button>
										</td>
									</tr>
								</table> 
								</span>
								<div id="bid_update_form" style="background-color:#FFFFCC;border-color:#FFCC66;border-width:thin;border-style:solid;">
								<button id="bid_update_cancel_button" style="float:right;background-color:#FFFFFF;color:#FF6666;border-color:#FF6666;border-width:thin;border-style:solid;"><b>x</b></button>
								<br>
									<font color="green"><i>Rs.</i></font> <input type="text" id="new_bid_value" placeholder="Your Bid Value (in digits only)">&nbsp;&nbsp;<button onclick="checkBid('user_item_update_bid.jsp','<%=item_id%>');" style="background-color:#3388CC;color:#FFFFFF;height:25px">Update!</button>
								</div>
								<%
							}
							else
							{
								%>
								<div id="bid_area">	
								<div id="bid_form"  style="width:85%;background-color:#FFFFCC;border-color:#FFCC66;border-width:thin;border-style:solid;">   
								<button id="bid_cancel_button" style="float:right;background-color:#FFFFFF;color:#FF6666;border-color:#FF6666;border-width:thin;border-style:solid;"><b>x</b></button>
								<br>
									<font color=green><i>Rs.</i></font> <input type="text" id="new_bid_value" placeholder="Your Bid Value (in digits only)">&nbsp;&nbsp;<button onclick="checkBid('user_item_place_bid.jsp','<%=item_id%>')" style="background-color:#3388CC;color:#FFFFFF;height:25px">Bid!</button>
								</div>
								<span id="bid_button_area">
									<button id="bid_button" style="background-color:#3388CC;color:#FFFFFF;height:25px">:: Place Your Bid! ::</button>
								</span>
								</div>
								<%
							}
						}
						else
						{
							if(smt.executeQuery("select * from seller_item_requests where item_id='"+item_id+"' and userid='"+userid+"'").next())
							{
								%>
								<span style="color:#006600;">* <b>This item is requested.</b> *</span>
								<%
							}
							else
							{
								%>
								<button onclick="loadBox('user_buyer_request_item.jsp','item_id=<%=item_id%>');" style="background-color:#3388CC;color:#FFFFFF;height:30px">:: Make Your Request! ::</button>
								<%
							}
						}
					}
					%>
				</div>
				<%
			}
			rs.close();
			String user_name="";
		%>
		</center>
		</div>
		<div id="item_queries" style="width:88%;border-top-style:solid;border-top-width:thin;border-top-color:#0066CC;">
			<center>
			<h3><font color=grey><i>Have Queries</i></font><font color=red><i>?</i></font></h3>
			<%
			q="select * from seller_item_queries where item_id='"+item_id+"' order by CONVERT(query_id,DECIMAL)";
			rs=smt.executeQuery(q);
			if(rs.next())
			{
				%>
				<table cellpadding="10" style="background-color:#FFFFDD;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#FFFFFF;width:100%;text-align:left;">
				<%
				do
				{
					String query_userid=rs.getString("userid");
					q="select user_name from user_register where userid='"+query_userid+"'";
					Statement smt1=cn.createStatement();
					ResultSet rs1=smt1.executeQuery(q);
					if(rs1.next())
					{
						user_name=rs1.getString(1);
					}
					rs1.close();
					%>
					<tr>
						<td style="font-size:13px;text-align:left;">
							<%
							if(seller_id.equals(query_userid))
							{
								%>
								<font color="#FF6600">#&nbsp;<i><%=user_name%></i></font>
								<%
							}
							else
							{
								%>
								<font color="#666666">#&nbsp;<i><%=user_name%></i></font>
								<%
							}
							%>
						</td>
						<td>
							<%
							if(seller_id.equals(query_userid))
							{
								%>
								<textarea  wrap="hard" name="query" readonly="true" style="background-color:#FFFFDD;width:100%;font-style:italic;color:green;border-width:0;font-size:13px;resize:none" disabled><%=rs.getString("query_text")%></textarea>
								<%
							}
							else
							{
								%>
								<textarea wrap="hard" name="query" readonly="true" style="background-color:#FFFFDD;width:100%;font-style:italic;color:blue;border-width:0;font-size:13px;resize:none" disabled><%=rs.getString("query_text")%></textarea>
								<%
							}
							%>
						</td>
						<td>
							<%
							if(rs.getString("userid").equals(userid))
							{
								%>
								<button onclick="if(confirm('Confirm ?')){loadBox('user_item_delete_query.jsp','item_id=<%=item_id%>&query_id=<%=rs.getString(1)%>');}" style="color:#FF3333;font-size:10px">X</button>
								<%
							}
							%>
						</td>
					</tr>
					<%
				}while(rs.next());
				%>
				</table>
				<%
			}
			%>
			<form action="user_item_query.jsp" method="post" name="item_query" onsubmit="checkQuery();">
				<input type="hidden" name="item_id" value="<%=item_id%>">
			<br><table cellpadding=10 style="background-color:#0066cc;width:100%;color:#FFFFFF;border-radius:10px;test-align:left;">
			<tr>
				<td style="font-size:13px;">
					<%
						rs.close();
						q="select user_name from user_register where userid='"+userid+"'";
						rs=smt.executeQuery(q);
						if(rs.next())
						{
							user_name=rs.getString(1);
						}
					%>
				<i># <%=user_name%></i>
				</td>
				<td>
					<textarea wrap="hard" name="query" id="new_query" style="width:100%;font-size:13px;"></textarea>
				</td>
				<td>
					<button onclick="return(checkQuery('<%=item_id%>'));" style="color:#0066cc;"><b>Ask!</b>
				</td>
			</tr>
			</table>
			</form>
			</center>
		</div>
		</center>
<%@ include file="include_bottom.jsp"%>
