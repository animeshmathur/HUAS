<%@ include file="include_top.jsp"%>
		<%
		String demand_article=request.getParameter("demand_article");
		demand_article=demand_article.replace("'","''");
		%>
<%--
		<script>
		$(document).ready(
		function()
		{
			$("#seller_item_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#seller_button").click(
			function()
			{
				$("#demand_results").fadeToggle("slow",
				function()
				{
					$("#seller_item_form").fadeToggle("fast");
				}
				);
			}
			);
		});
		
		$(document).ready(
		function()
		{
			$("#seller_cancel_button").click(
			function()
			{
				$("#seller_item_form").fadeToggle("fast",
				function()
				{
					$("#demand_results").fadeToggle();
				}
				);
			}
			);
		});
		</script>
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			//alert("check");
			if(document.seller_item.item_name.value=="")
			{
				alert("Please enter Item's Name!");
				return false;
			}
			if(document.seller_item.item_desc.value=="")
			{
				alert("Please provide item's description!");
				return false;
			}
			if(document.seller_item.price_type.value==-1)
			{
				alert("Please select price type!");
				return false;
			}
			if((document.seller_item.item_amt.value==""&&document.seller_item.price_type.value=="Bid")||(document.seller_item.item_amt.value==""&&document.seller_item.price_type.value=="Fixed"))
			{
				alert("Please provide the price!");
				return false;
			}
			return true;
		}
		
		function setPriceType()
		{
			//alert("check");
			var x=document.getElementById("price_field");
			var sel=document.seller_item.price_type.value;
			if(sel=="Fixed")
			{
				document.seller_item.price_type.value="Fixed";
				x.innerHTML="Rs. <input type=text name=item_amt size=15 placeholder=\"Item Price\" style=\"border-width:2px;border-style:solid;border-color:#FFCC66;\">";
			}
			if(sel=="Bid")
			{
				document.seller_item.price_type.value="Bid";
				x.innerHTML="Rs. <input type=text name=item_amt size=15 placeholder=\"Initial Price for Bid\" style=\"border-width:2px;border-style:solid;border-color:#FFCC66;\">";
			}
			if(sel=="None")
			{
				document.seller_item.price_type.value="None";
				x.innerHTML="";
			}
			if(sel==-1)
			{
				document.seller_item.price_type.value=-1;
				x.innerHTML="";
			}
		}
		
		function confirmNotify()
		{
			var act=confirm("You are about to notify demander about your article!\nNote: Your contact details will be available to demander.");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		//-->
		</script>
			<%
			String msg=request.getParameter("msg");
			if(msg!=null)
			{
				if(msg.equals("Done"))
				{
					%>
					<script type="text/javascript">
					alert("Notification Sent!");
					</script>
					<%
				}
			}
			%>
--%>
		<center>
<%--		
			<form id="seller_item_form" action="user_seller_register_item.jsp" name="seller_item" onsubmit="return(checkFields());" style="width:80%">
			<br>
			<input type="button" id="seller_cancel_button" value="x" style="background-color:#FFFFFF;color:#FF6666;border-color:#FFFFFF;float:right;font-weight:bold;border-bottom-color:#FF6666;border-bottom-style:solid;border-bottom-width:thin;border-right-color:#FF6666;border-right-style:solid;border-right-width:thin;">
			<br>
			<span style="color:#0066CC"><img src="images/seller.jpg" height=50 width=55><i>Sell Your Item</i></span>
			<br><br>
			<span style="color:#FF6600;font-size:14px;width:80%">::Please Fill Your Item Details Below::</span>
			
			<br>
			<table cellpadding=6 style="width:80%;text-align:center;">
			<tr>
				<td>
					<input type=text name=item_name placeholder="Name of Item" style="width:100%;background-color:#FFFFFF;border-width:3px;border-style:solid;border-color:#FFCC66;">
				</td>
			</tr>
			<tr>
				<td>
					<textarea name=item_desc cols=50 rows=6 placeholder="Description of Item" style="width:100%;background-color:#FFFFFF;border-width:3px;border-style:solid;border-color:#FFCC66;"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<select name="price_type" onChange="setPriceType()" style="background-color:#FFFFFF;width:60%;text-align:center;border-width:3px;border-style:solid;border-color:#FFCC66;">
						<option value=-1>--- Select Price Type ---</option>
						<option value="None">On Deal</option> 
						<option value="Fixed">Fixed Price</option> 
						<option value="Bid">Price Over Bid</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="price_field"  style="width:100%;color:#0066CC;font-style:italic;">
				</td>
			</tr>
			<tr>
				<td>
					<input type=submit value="Put On Sale!" style="width:80%;color:#FFFFFF;background-color:#FF6600;">
				</td>
			</tr>
			</table>
			</form>
--%>			
			<%
			String q="select * from user_demands where demand_title like '%"+demand_article+"%' or demand_description like '%"+demand_article+"%'";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				%>
				<span id="demand_results">
				<h3 style="color:#0066CC">Demander(s) of ' <%=request.getParameter("demand_article")%> ' :</h3>
<%--
					 <h5>::- <i><font color="red">Not Satisfied.....</font><font color="#220000"> ???</font></i>&nbsp;->&nbsp;<button id="seller_button" style="color:#0066CC;background-color:#FFFFFF;">Place Your Article On Sale</button> -::</h5>
--%>
				<%
				int count=1;
				%>
				<table cellspacing=10 cellpadding=5  width=100% style="background-color:#FFFFCC;">
				<th>Title</th><th>Description</th><th>Demander</th><th></th>
				<%
				do
				{
					String demand_id=rs.getString("demand_id");
					String title=rs.getString("demand_title");
					String desc=rs.getString("demand_description");
					String demander_userid=rs.getString("userid");
					//desc=desc.substring(0,desc.length()/2);
					
					String q1="select user_name,user_contact from user_register where userid='"+demander_userid+"'";
					Statement smt1=cn.createStatement();
					ResultSet rs1=smt1.executeQuery(q1);
					
					String demander_name="";
					String demander_contact="";
					
					if(rs1.next())
					{
						demander_name=rs1.getString(1);
						demander_contact=rs1.getString(2);
					}
					rs1.close();
					%>
						<tr>
							<td style="color:#000000;text-align:center;border-color:grey;border-style:solid;border-width:thick;">
								<b><i><%=title%></i></b>
							</td>
							<td style="text-align:center;border-color:grey;border-style:solid;border-width:thick;">
								<textarea readonly=true cols=35 style="color:#FF6600;background-color:#FFFFCC;font-size:14px;border-width:0px;resize:none;font-style:italic;"><%=desc%>...</textarea>
							</td>
							<td style="text-align:center;border-color:grey;border-style:solid;border-width:thick;">
								<b><i><%=demander_name%></i></b><br>
								<img src="images/contact.jpeg" height=20px width=25px>&nbsp;<i>+91-<%=demander_contact%></i>
							</td>
							<td style="text-align:center;border-color:grey;border-style:solid;border-width:thick;">
								<%
								if(!demander_userid.equals(userid))
								{
									q1="select * from user_demand_notifications where demand_id='"+demand_id+"' and notifier_userid='"+userid+"'";
									rs1=smt1.executeQuery(q1);
									if(rs1.next())
									{
										%>
										<font color=green><i>Notified!</i></font>
										<%
									}
									else
									{
										%>
										<form action="user_demand_notify_demander.jsp" onsubmit="return(confirmNotify());">
											<input type="hidden" name="demand_id" value="<%=demand_id%>">
											<input type="hidden" name="demand_article" value="<%=demand_article%>">
											<input type=submit value="Notify Demander!" style="color:#0066CC;background-color:#FFFFFF">
										</form>
										<%
									}
									rs1.close();
								}
								else
								{
									%>
									<i><font color=green>(My Demand)</font></i>
									<%
								}
								%>
							</td>
						</tr>
					<%
				}while(rs.next());
				if(count%2==0)
				{
					%>
					</tr>
					<%
				}
				%>
				</table>
				</span>
				<%
			}
			%>
		</center>
<%@ include file="include_bottom.jsp"%>
