<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		
		ResultSet rs=smt.executeQuery("select seller_item_name,seller_item_price_type from seller_items where seller_item_id='"+item_id+"' and userid='"+userid+"'");
		String item_name="";
		String price_type="";
		if(rs.next())
		{
			item_name=rs.getString(1);
			price_type=rs.getString(2);
		}
		rs.close();
%>
		<center>
		<div>
			<h3 style="color:#0066CC"><u>Requests for <i>'<%=item_name%>'</i></u></h3>
			<%
			if(price_type.equals("Fixed")||price_type.equals("None"))
			{
				rs=smt.executeQuery("select userid,day(request_time),month(request_time),year(request_time),time(request_time) from seller_item_requests where item_id='"+item_id+"' order by request_time");
				if(rs.next())
				{
					%>
					<table cellpadding=10 width=85%>
					<th>Buyer Name</th><th>Contact No.</th><th>Requested On</th>
					<%
					do
					{
						String buyer_id=rs.getString(1);
						Statement smt1=cn.createStatement();
						ResultSet rs1=smt1.executeQuery("select user_name,user_contact from user_register where userid='"+buyer_id+"'");
						String buyer_name="";
						String buyer_contact="";
						if(rs1.next())
						{
							buyer_name=rs1.getString(1);
							buyer_contact=rs1.getString(2);
						}
						rs1.close();
						%>
						<tr><td><i><%=buyer_name%></i></td><td><i>+91-<%=buyer_contact%></i></td><td><i><%=rs.getString(2)%>-<%=rs.getString(3)%>-<%=rs.getString(4)%> at <%=rs.getString(5)%></i></td></tr>
						<%
					}while(rs.next());
					%>
					</table>
					<%
				}
			}
			else if(price_type.equals("Bid"))
			{
				rs=smt.executeQuery("select * from seller_item_bids where seller_item_id='"+item_id+"' order by bid_value desc");
				if(rs.next())
				{
					%>	
					<i>Note:</i>&nbsp;&nbsp;<i style="color:rgb(0,150,0)">Buyers are shown in decreasing order of their bid value.</i><br><br>
					<table cellpadding=10 width=85%>
					<th>Buyer Name</th><th>Contact No.</th><th>Bid Value</th>
					<%
					do
					{
						String buyer_id=rs.getString("userid");
						Statement smt1=cn.createStatement();
						ResultSet rs1=smt1.executeQuery("select user_name,user_contact from user_register where userid='"+buyer_id+"'");
						String buyer_name="";
						String buyer_contact="";
						if(rs1.next())
						{
							buyer_name=rs1.getString(1);
							buyer_contact=rs1.getString(2);
						}
						rs1.close();
						%>
						<tr><td><i><%=buyer_name%></i></td><td><i>+91-<%=buyer_contact%></i></td><td><i><%=rs.getString("bid_value")%></i></td></tr>
						<%
					}while(rs.next());
					%>
					</table>
					<%
				}
			}
				%>
			</table>
		</div>
		</center>
<%@ include file="include_bottom.jsp"%>
