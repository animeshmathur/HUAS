<%@ include file="include_top.jsp"%>
<%
String demand_id=request.getParameter("demand_id");		
%>
		
		<center>
			<%
			String demand_title="";
			
			String q="select demand_title from user_demands where demand_id='"+demand_id+"' and userid='"+userid+"'";
			ResultSet rs=smt.executeQuery(q);
			
			if(rs.next())
			{
				demand_title=rs.getString(1);
				rs.close();
			
				q="select * from user_demand_notifications where demand_id='"+demand_id+"'";
				rs=smt.executeQuery(q);
				if(rs.next())
				{
					%>
					<h3 style="color:#0066CC">People who notified you for your demand '<%=demand_title%>' :</h3>
					<table cellspacing=10 cellpadding=5  width=100% style="background-color:#FFFFCC;">
					<%
					do
					{
						String q1="select user_name,user_contact from user_register where userid='"+rs.getString("notifier_userid")+"'";
						Statement smt1=cn.createStatement();
						ResultSet rs1=smt1.executeQuery(q1);
						if(rs1.next())
						{
							%>
							<tr>
								<td>
									<%=rs1.getString(1)%>
								</td>
								<td>
									<img src="images/contact.jpeg" height=20px width=25px>&nbsp;<i>+91-<%=rs1.getString(2)%></i>
								</td>
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
						<br>
						<span style="color:rgb(0,150,0);font-size:24px">
						* No Notifications Yet *
						</span>
						<br><br>
						<i style="color:#0066CC">Please wait while some people consider your demand and Notify.</i>
					<%
				}
			}
			%>
		</center>
<%@ include file="include_bottom.jsp"%>
