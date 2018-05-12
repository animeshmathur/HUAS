<%@ include file="include_top.jsp"%>
<%
		String cat_id=request.getParameter("cat_id");
		String cat_name="";
		
		String q="select * from rent_categories where category_id='"+cat_id+"'";
		ResultSet rs=smt.executeQuery(q);
		
		if(rs.next())
		{
			cat_name=rs.getString("category_name");
		}
		rs.close();
		
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
				$("#rent_field_form").toggle();
				$("#rent_field_text").toggle();
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
			}
			%>
		
		<script type="text/javascript">
			document.write("<a href=\""+document.referrer+"\" style=\"color:#0066CC\">&lt;&lt; Back</a>");
		</script>
		
		<center>
			<h3 style="color:#666666"><i>Rentable(s) for '&nbsp;<font color=#0066CC><b><%=cat_name%></b></font>&nbsp;'</i></h3>
			<div id="rent_field" style="width:80%;color:#0066CC;border-bottom-style:solid;border-bottom-width:thin;border-bottom-color:#0066CC">
				<span id="rent_field_text">
				* * *&nbsp;&nbsp;<span style="color:#CC6600"><i>Place Your Entity :</i></span>&nbsp;&nbsp;&nbsp;<button class="rent_field_button" style="color:#FFFFFF;background-color:#FF6600;width:200px">&nbsp;For Rent&nbsp;</button>&nbsp;&nbsp;* * *
				<br><br>
				</span>
				
				<span id="rent_field_form">
				<button class="rent_field_button" style="border-radius:5px;color:#FF6666;float:right;background-color:#FFFFFF;">x</button>
				<form action=user_rents_insert.jsp method=post name=rent_form onSubmit="return(checkFields());">
					<h4><i>Place Your Entity For Rent</i></h4>
					<table cellpadding=4 cellspacing=4 style="border-radius:20px;background-color:#FFFFFF;width:80%;border-style:solid;border-color:#FFCC66;border-width:2px;">
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
											String op_cat_id=rs.getString("category_id");
											%>
											<option value=<%=op_cat_id%><%if(op_cat_id.equals(cat_id)){%> selected=true<%}%>><%=rs.getString("category_name")%></option>
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
			<br><br>
			<%
			q="select * from user_rents where category_id='"+cat_id+"'";
			rs=smt.executeQuery(q);
			if(rs.next())
			{
				do
				{
					String extra_detail=rs.getString("rent_details");
					%>
					<span style="width:30%;float:left;border-width:thick;border-style:solid;border-color:#FFFFFF">
						<table style="background-color:#FFFFAA;width:100%;;font-size:12px">
							<tr>
								<td>
									<font color=#FF6600 style="font-size:15px"><b><%=rs.getString("rent_title")%></b></font>
								</td>
							</tr>
							<tr>
								<td><b>Rent Cost: </b><i><font color=#006600><%=rs.getString("rent_cost")%></font></i></td>
							</tr>
							<tr>
								<td><b>Contact: </b><i><font color=#0066CC><%=rs.getString("rent_contact")%></font></i></td>
							</tr>
							<%
							//if(!extra_detail.equals(""))
							//{
								%>
								<tr>
									<td>
										<textarea rows=2 style="color:#4d4c4c;width:100%;background-color:#FFFFAA;border-width:0px;font-size:12px;font-style:italic;resize:none;text-align:center" readonly=true disabled><%=rs.getString("rent_details")%></textarea>
									</td>
								</tr>
								<%
							//}
							%>
						</table>
					</span>
					<%
				}while(rs.next());
			}
			%>
			</div>
			
		</center>
		<%@ include file="include_footer.jsp"%>
		</body>
		</html>
<%@ include file="include_bottom.jsp"%>
