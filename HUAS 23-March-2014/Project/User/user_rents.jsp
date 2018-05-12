<%@ include file="include_top.jsp"%>
<%
String q="";
ResultSet rs=null;
%>
		<html>
		<head>
		<%@ include file="head.jsp"%>
		<script>
		$(document).ready(
		function()
		{
			$("#rent_field_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$(".rent_field_button").click(
			function()
			{
				$("#rent_field_text").toggle();
				$("#rent_field_form").toggle();
			}
			);
		}
		);
		</script>
		<script type="text/javascript">
		<!--
		function checkFields()
		{
			var x=document.rent_form;
			if(x.rent_title.value=="")
			{
				alert("Please provide name/title of entity!");
				x.rent_title.focus();
				return false;
			}
			else if(x.cat_id.value=="-1")
			{
				alert("Please select appropriate category!");
				x.cat_id.focus();
				return false;
			}
			else if(x.rent_cost.value=="")
			{
				alert("Please provide cost of rent!");
				x.rent_cost.focus();
				return false;
			}
			else if(x.rent_contact.value=="")
			{
				alert("Please provide contact no.!");
				x.rent_contact.focus();
				return false;
			}
			return confirm("You are about to register your entity for rent! Continue..?");
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
				if(msg.equals("Rent_Inserted"))
				{
					%>
					<script type="text/javascript">
						alert("Done!");
					</script>
					<%
				}
				if(msg.equals("Invalid_Contact"))
				{
					%>
					<script type="text/javascript">
						alert("Invalid Contact! Only digits are allowed. ");
					</script>
					<%
				}
			}
			%>
		<center>
			<h2 style="color:#0066CC"><i> Rents </i></h2>
			<div id="rent_field" style="width:80%;color:#0066CC;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC">
				<span id="rent_field_text">
				* * *&nbsp;&nbsp;<span style="color:#CC6600"><i>Place Your Entity :</i></span>&nbsp;&nbsp;&nbsp;<button class="rent_field_button" style="color:#FFFFFF;background-color:#FF6600;width:200px">&nbsp;For Rent&nbsp;</button>&nbsp;&nbsp;* * *
				<br><br>
				</span>
				
				<span id="rent_field_form">
				<button class="rent_field_button" style="border-radius:5px;color:#FF6666;float:right;background-color:#FFFFFF;">x</button>
				<form action=user_rents_insert.jsp method=post name=rent_form onSubmit="return(checkFields());">
					<h4><i>Place Your Entity For Rent</i></h4>
					<table cellpadding=4 cellspacing=4 style="border-radius:20px;background-color:#FFFFDD;width:80%;border-style:solid;border-color:#FFCC66;border-width:2px;">
						<tr>
							<td>
								<input type=text name=rent_title placeholder="-------------------- Entity on Rent --------------------" style="text-align:center;width:100%;">
							</td>
						</tr>
						<tr>
							<td>
								<select name=cat_id style="text-align:center;background-color:#FFFFFF;width:100%">
									<option value=-1>-------------------- Category --------------------</option>
									<%
										rs=smt.executeQuery("select category_id,category_name from rent_categories where not category_name='Others'");
										while(rs.next())
										{
											%>
												<option value=<%=rs.getString("category_id")%>><%=rs.getString("category_name")%></option>
											<%
										}
									%>
									<option value=14>Others</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<input type=text name=rent_cost placeholder=" Cost of Rent (ex. Rs.xxxx per unit)" style="width:100%;">
							</td>
						</tr>
						<tr>
							<td>
								<input type=text name=rent_contact placeholder="Contact No. (visible to customers)" style="width:100%;">
							</td>
						</tr>
						<tr>
							<td>
								<textarea name=rent_details placeholder="Extra Details (if any)" rows=2 maxlength=100 style="width:100%"></textarea>
							</td>
						</tr>
					</table>	
					<input type=submit value=Submit style="color:#FFFFFF;background-color:#FF6600;width:50%">
				</form>
				</span>
			</div>
			<div id="rent_categories">
			<style>
			.rent_categories
			{
				background-color:#FFFFAA;
			}
			.rent_categories:hover
			{
				background-color:#FFCC66;
			}
			</style>
			<h3><font color=grey><i>:: Browse through appropriate category ::</i></font></h3>
			<%
			rs.close();
			q="select * from rent_categories where not category_name='Others'";
			rs=smt.executeQuery(q);
			if(rs.next())
			{
				do
				{
					%>
					<table style="width:60%;">
						<tr>
							<td class="rent_categories" style="text-align:center;">
								<a href="user_rents_browse_category.jsp?cat_id=<%=rs.getString("category_id")%>" style="color:#0066CC;font-size:15px">
								<i><u><%=rs.getString("category_name")%></u></i>
								</a>
							</td>
						</tr>
					</table>
					<%
				}while(rs.next());
				%>
					<table style="width:60%;">
						<tr>
							<td class="rent_categories" style="text-align:center;">
								<a href="user_rents_browse_category.jsp?cat_id=14" style="color:#0066CC;font-size:15px">
								<i><u>Others.....</u></i>
								</a>
							</td>
						</tr>
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
