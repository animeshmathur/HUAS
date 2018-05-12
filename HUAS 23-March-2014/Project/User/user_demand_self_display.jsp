<%@ include file="include_top.jsp"%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<script>
		$(document).ready(
		function()
		{
			$("#demand_wish_form").hide();
			$("#make_demand_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#make_wish_button").click(
			function()
			{
				$("#demand_text").slideUp(
				function()
				{
					$("#demand_wish_form").fadeIn();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#make_wish_cancel_button").click(
			function()
			{
				$("#demand_wish_form").fadeOut(
				function()
				{
					$("#demand_text").slideDown();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#make_demand_button").click(
			function()
			{
				$("#demand_text").slideUp(
				function()
				{
					$("#make_demand_form").fadeIn();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#make_demand_cancel_button").click(
			function()
			{
				$("#make_demand_form").fadeOut(
				function()
				{
					$("#demand_text").slideDown();
				}
				);
			}
			);
		}
		);
		</script>
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			
		}
		//-->
		</script>
		<style>
		th
		{
			background-color:#0066CC;
			color:#FFFFFF;
		}
		</style>
		</head>
		<body>
		<%@ include file="include_header.jsp"%>
		<center>
		<script type="text/javascript">
		<!--
		<%
		String msg=request.getParameter("msg");
		if(msg!=null)
		{
			if(msg.equals("Done"))
			{
				%>
					alert("Done!");
				<%
			}
			else if(msg.equals("Removed"))
			{
				%>
					alert("Removed!");
				<%
			}
		}
		%>
		
		function checkDemandFields()
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
		
		function checkWish()
		{
			if(document.getElementById('user_wish').value=="")
			{
				alert("Please specify the search keyword of your wish!");
				return false;
			}
			return true;
		}
		
		function searchWish()
		{
			chk=checkWish();
			if(chk)
			{
				//alert("chk");
				openBox("extra_outer_box","extra_inner_box","user_demand_search.jsp","user_wish="+document.getElementById("user_wish").value);
			}
		}
		
		function confirmRemove()
		{
			var act=confirm("Are you sure you want to cancel your demand?\nAll data related to this demand will be erased!");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		
		function loadLink(url)
		{
			openBox('extra_outer_box','extra_inner_box',url);
			return false;
		}
		//-->
		</script>
		<div id="demand_wish" style="background-color:#FFFFFF;text-align:center;color:#0066CC;width:80%">
			<span id="demand_text">
			<button id="make_wish_button" style="background-color:#FFFFCC;color:#0066CC;">
			<font color=green><i>:: Search Your Demand ::</i></font>
			</button>
			<button id="make_demand_button" style="background-color:#FFFFCC;color:#0066CC;">
			<font color=red><i>:: Make Your Demand ::</i></font>
			</button>
			</span>
			
			<span id="demand_wish_form">
			<button id="make_wish_cancel_button" style="color:#FF6666;float:right;background-color:#FFFFFF;border-style:solid;border-width:thin;border-color:#FF6666;">
			<b>x</b>
			</button>
			<h3 style="color:#0066CC">
			<i>Wish for Demand</i>
			</h3>
			<p style="color:green">
			<img src="images/wish.jpeg" height=80 width=100>&nbsp;&nbsp;&nbsp;<br><i>* Wish & Demand for any item you require. *</i>
			</p>
			<center>
				<table cellpadding=10 style="border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC;">
				<tr>
					<td>
						<input type=text name="user_wish" id="user_wish" placeholder="... Specify Your Wish ..." size=40>
					</td>
					<td>
						<button onclick="searchWish();" style="background-color:#FFFFFF">Wish</button>
					</td>
				</tr>
				</table>
			</center>
			</span>
			
			<span id="make_demand_form">
			<button id="make_demand_cancel_button" style="color:#FF6666;float:right;background-color:#FFFFFF;border-style:solid;border-width:thin;border-color:#FF6666;"><b>x</b></button>
			<form action="user_demand_submit.jsp" name="demand_form" onSubmit="return(checkDemandFields());" method="post">
				<h4 style="color:FF6666">:: Please Specify Your Demand ::</h4>
				<center>
				<table style="width:60%;background-color:#FFFFAA;border-style:solid;border-width:thin;border-color:red">
					<tr>
						<td>
							<input type=text name=demand_title size=35 style="text-align:center;color:" placeholder="----- Demand Title -----">
						</td>
					</tr>
					<tr>
						<td>
							<span style="color:#666666"><textarea name="demand_desc" cols="40" rows="5" wrap="hard" placeholder="------ Demand Description ------"></textarea></span>
						</td>
					</tr>
					<tr>
						<td>
							<input type=submit value="Submit Your Demand!" style="color:#FFFFFF;background-color:red">
						</td>
					</tr>
				</table>
				</center>
			</form>
			</span>
		</div>
		<div id="demand_items" style="color:#0066CC">
			<h3><i>My Demands</i></h3>
			<%
			String q="select * from user_demands where userid='"+userid+"' order by demand_id desc";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				%>
					<table style="width:85%;background-color:#FFFFFF;color:#0066CC" cellpadding=10 cellspacing=5>
					<th>Title</th><th>Description</th><th>Suggestions</th><th>Notifications</th><th></th>
				<%
				do
				{
					String demand_id=rs.getString("demand_id");
					String title=rs.getString("demand_title");
					String desc=rs.getString("demand_description");
					//desc=desc.substring(0,desc.length()/2);
					%>
						<tr>
							<td style="color:#0066CC;font-size:14px">
								<b><%=title%></b>
							</td>
							<td>
								<textarea readonly=true rows=2 cols=24 style="color:#666666;font-size:12px;border-width:0px;resize:none;font-style:italic;" disabled><%=desc%>...</textarea>
							</td>
							<td>
								<a href="#" onclick="return(loadLink('user_demand_search.jsp?user_wish=<%=title.replace(" ","+")%>'));" style="color:#0066CC;font-size:14px"><i><u>View</u></i></a>
							</td>
							<td>
								<a href="#" onclick="return(loadLink('user_demand_view_notifications.jsp?demand_id=<%=demand_id%>'));" style="color:#0066CC;font-size:14px"><i><u>View</u></i></a>
							</td>
							<td>
								<form action="user_demand_remove.jsp" method="post" onsubmit="return(confirmRemove());">
									<input type=hidden name="demand_id" value="<%=demand_id%>">
									<input type=submit value="Cancel" style="background-color:#FFFFFF">
								</form>
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
