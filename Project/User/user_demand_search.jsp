<%@ include file="include_top.jsp"%>
<%
String user_wish=request.getParameter("user_wish");
%>
<%--
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			if(document.demand_form.demand_title.value=="")
			{
				alert("Please specify demand title!");
				return false;
			}
			if(document.demand_form.demand_desc.value=="")
			{
				alert("Please specify demand desciption!");
				return false;
			}
			return true;
		}
		
		function makeDemand()
		{
			var x=document.getElementById("make_demand");
			x.innerHTML="<form action=\"user_demand_submit.jsp\" name=\"demand_form\" onSubmit=\"return(checkFields());\" method=\"post\"><h4 style=\"color:red\">:: Please Specify Your Demand ::</h4><table style=\"width:50%;background-color:#CCDDEE;border-style:solid;border-width:thin;border-color:red\"><tr><td><input type=text name=demand_title size=35 placeholder=\"----- Demand Title -----\"></td></tr><tr><td><textarea name=demand_desc cols=50 rows=5 placeholder=\"------ Demand Description ------\"></textarea></td></tr><tr><td><input type=submit value=\"Submit Your Demand!\" style=\"color:#FFFFFF;background-color:red\"></td></tr></table></form>";
		}
		//-->
		</script>
--%>
		<center>
			<%
			String q="select * from seller_items where not userid='"+userid+"' and (seller_item_name like '%"+user_wish+"%' or seller_item_description like '%"+user_wish+"%')";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				%>
				<h3 style="color:#0066CC">We found few item(s) that may fullfill your wish :</h3>
				<%--
				<span id="make_demand" style="background-color:#CCDDEE">
					 <h5>::- <i><font color="red">Not Satisfied.....</font><font color="#220000"> ???</font></i>&nbsp;&nbsp;<input type=button value=":: Place Your Demand ::" onClick="makeDemand();" style="background-color:red;color:#FFFFFF"> -::</h5>
				</span>
				--%>
				<%
				int count=1;
				%>
				<table cellspacing=10 cellpadding=5  width=80%>
				<%
				do
				{
					if(count%2!=0)
					{
						%>
						<tr>
						<%
					}
					%>	
						<td style="width:10%;background-color:#FFFFFF;">
							<img src="uploads/<%=rs.getString("seller_item_image")%>" height=50px width=55px>
						</td>
						<td style="width:40%;background-color:#FFFFCC;">
							<a href="#" style="color:#0066CC" onclick="loadBox('user_item_details.jsp','item_id=<%=rs.getString("seller_item_id")%>');return false;"><i><%=rs.getString("seller_item_name")%></i></a>
							<%
							if(rs.getString("seller_item_price_type").equals("Bid"))
							{
								%>
								&nbsp;<blink><font style="color:red;font-size:12px">On Bid!</font></blink>
								<%
							}
							%>
						</td>
					<%
					if(count%2==0)
					{
						%>
						</tr>
						<%
						count++;
					}
					else
					{
						count++;
					}
				}while(rs.next());
				if(count%2==0)
				{
					%>
					</tr>
					<%
				}
				%>
				</table>
				<%
			}
			else
			{
				%>
				<br>
				<span style="color:rgb(0,150,0);font-size:24px">
				* No Result Found *
				</span>
				<br><br>
				<%
			}
			%>
		</center>
<%@ include file="include_bottom.jsp"%>
