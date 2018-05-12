<%@ include file="include_top.jsp"%>
<% String user_keyword=request.getParameter("item_keyword"); %>
		<center>
		<div>
			<h3><i><font color=#0066CC>Search Result(s) for '<%=user_keyword%>'</font></i></h3>
			<table cellpadding=6 style="width:85%;background-color:#FFFFFF;border-style:solid;border-width:thick;border-color:#FFFFFF;text-align:center;">
			<%
			ResultSet rs=smt.executeQuery("select * from seller_items where seller_item_status='On Sale' and seller_item_name like '%"+user_keyword+"%' order by date(seller_item_date)");
			int count=1;
			if(rs.next())
			{
				do
				{
					%>
					<tr>
						<td><img src="uploads/<%=rs.getString(5)%>" alt="no_image.jpg" height=50px width=50px></td>
						<td><a onclick="openBox('extra_outer_box','extra_inner_box','user_item_details.jsp','item_id=<%=rs.getString(1)%>');return false;" href="#" style="color:0066CC"><u><%=rs.getString(3)%></u></td>
						<td>
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
								<font color=#FF6600><i>(My Item)</i></font>
							<%
							}
							%>
						</td>
					</tr>
					<%
					count++;
				}while(rs.next());
			}
			else
			{
				%>
				<i>
				<p><font color=red>Sorry!</font> Your item may not be available now.</p>
				<p>We recommend you to put your item in your " <a href="user_demand_self_display.jsp" style="color:green">Demands</a> "!</p>
				</i>
				<%
			}
			%>
			</table>
		</div>
		</center>
<%@ include file="include_bottom.jsp"%>
