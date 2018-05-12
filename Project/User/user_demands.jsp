<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<script>
		$(document).ready(
		function()
		{
			$("#demand_search_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
		$("#search_demand_button").click(
		function()
		{
			$("#search_demand_button").slideToggle("fast",
			function()
			{
				$("#demand_search_form").toggle("slow");
			});
		}
		);
		}
		);
		
		$(document).ready(
		function()
		{
		$("#search_demand_cancel_button").click(
		function()
		{
			$("#demand_search_form").fadeToggle("slow",
			function()
			{
				$("#search_demand_button").slideToggle();
			});
		}
		);
		}
		);
		</script>
		<style>
		tr
		{
			color:#0066CC;
		}
		td
		{
			text-align:center;
		}
		</style>
		<script type="text/javascript">
		<!--
		
		function notifyDemander(demand)
		{
			if(confirm("You are about to notify demander for this article!\nNote: Your contact details will be available to demander."))
			{
				$.post('user_demand_notify_demander.jsp','demand_id='+demand);
				$('#notify_option_'+demand).html('<font color=green><b><i>Notified!</i></b></font>');
			}
		}
		//-->
		</script>
		</head>
		<body>
		<%@ include file="include_header.jsp"%>
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
		<center>
		<script type="text/javascript">
		<!--
		function checkDemandSearch()
		{
			if(document.search_demand.demand_article.value=="")
			{
				alert("Please specify your article!");
				return false;
			}
			return true;
		}
		
		function createSearchDemand()
		{
			var x=document.getElementById("demand_search");
			x.innerHTML="";
		}
		//-->
		</script>

		<%--
		<div id="demand_search" style="background-color:#FFFFFF;text-align:center;color:#0066CC;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC;width:80%">
	
			<span id="demand_search_form">
				<button id="search_demand_cancel_button" style="color:#FF6666;float:right;background-color:#FFFFFF;border:0px;">x</button>
				<h3><i>Look for Demands</i></h3>
				<p>
					<img src="images/wish.jpeg" height=80 width=100>&nbsp;&nbsp;&nbsp;<br><i>* Look for people who demand the following item *</i>
				</p>
				<center>
				<form action=user_demand_search_demander.jsp name=search_demand onSubmit="return(checkDemandSearch());">
				<table cellpadding=10>
				<tr>
					<td>
						<input type=text name=demand_article placeholder="... Specify the Article (ex. mobile, watch, tv, etc.) ..." size=40>
					</td>
					<td>
						<input type=submit value="Search!" style="background-color:#FFFFFF">
					</td>
				</tr>
				</table>
				</form>
				</center>
			</span>
			<button id="search_demand_button" style="background-color:#FFFFAA;color:0066CC;width:100%">
			<span id="demand_search_text">
			<font color="#FF6600"><i>Look for demander of article you have!</i></font><br>
			:: :: Click Here :: ::
			</span>
			</button>
			
		</div>
		--%>
		<div id="demand_items" style="color:#0066CC">
			<h3><span class="orange_color">::</span> Latest Items On Demand <span class="orange_color">::</span></h3>
			<%
			String q="select * from user_demands order by demand_id desc";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				int count=1;
				%>
				<table border="1" cellpadding="15"  width="100%">
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
							<td style="color:#666666;font-size:15px">
								<b><%=title%></b>
							</td>
							<td style="color:#4d4c4c;font-size:14px;width:40%;text-align:left;">
							<p><i><%=desc%></i></p>
							</td>
							<td>
								<b><i><%=demander_name%></i></b><br>
								<img src="images/contact.jpeg" height=20px width=25px>&nbsp;<i>+91-<%=demander_contact%></i>
							</td>
							<td>
								<%
								if(!demander_userid.equals(userid))
								{
									q1="select * from user_demand_notifications where demand_id='"+demand_id+"' and notifier_userid='"+userid+"'";
									rs1=smt1.executeQuery(q1);
									if(rs1.next())
									{
										%>
										<font color=green><b><i>Notified!</i></b></font>
										<%
									}
									else
									{
										%>
											<span id="notify_option_<%=demand_id%>">
											<button onclick="notifyDemander('<%=demand_id%>');"><b>Notify Demander!</b></button>
											</span>
										<%
									}
									rs1.close();
								}
								else
								{
									%>
									<i><font color="#FF6600"><b>My Demand</b></font></i>
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
				<%
			}
			%>
		</div>
		</center>
		<%@ include file="include_footer.jsp"%>
		</body>
		</html>
<%@ include file="include_bottom.jsp"%>

