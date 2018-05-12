<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		ses.putValue("item_id",item_id);
%>
		<script>
		$(document).ready(
		function()
		{
			$("#change_picture_form").hide();
		}
		);
		
		$(document).ready(
		function()
		{
			$("#change_picture_button").click(
			function()
			{
				$("#change_picture_button").fadeOut(
				function()
				{
					$("#change_picture_form").fadeIn();
				}
				);
			}
			);
		}
		);
		
		$(document).ready(
		function()
		{
			$("#change_picture_cancel_button").click(
			function()
			{
				$("#change_picture_form").fadeOut(
				function()
				{
					$("#change_picture_button").fadeIn();
				}
				);
			}
			);
		}
		);
		</script>
		<script type="text/javascript">
		function confirmRemoveAction()
		{
			var act=confirm("Are you sure you want to remove this item from sale?");
			if(act==true)
			{
				return true;
			}
			return false;
		}
		
		function checkPicture()
		{
			filename=document.change_item_pic.item_pic.value;
			if(filename=="")
			{
				alert("Please select item's picture!");
				return false;
			}
			else
			{	
				//alert("Checking...!");
				var parts = filename.split('.');
				var ext=parts[parts.length - 1];;
				ext=ext.toLowerCase(); 
				//alert(ext);
				if(ext=="jpg"||ext=="jpeg"||ext=="bmp"||ext=="png")
				{
					$("#change_picture_form").after("<img src=\"images/loading.gif\" height=\"50px;\"><br><b>Please wait...</b>");
					$("#change_picture_form").hide();
					//alert("Done!");
					return true;
				}
				else
				{
					alert("Make sure file is an image of allowed extension - jpg, bmp or png !");
					return false;
				}
			}
		}
		
		function checkFields()
		{
			var update_form=document.getElementById('item_detail_update_form');
			if(update_form.item_name.value=="")
			{
				alert("Please enter Item's Name!");
				update_form.item_name.focus();
				return false;
			}
			if(update_form.item_desc.value=="")
			{
				alert("Please provide item description!");
				update_form.item_desc.focus();
				return false;
			}
			if(update_form.item_price.value!="N/A"&&!parseInt(update_form.item_price.value))
			{
				alert("Please provide valid item price!");
				update_form.item_price.focus();
				return false;
			}
			return true;
		}
		
		function submitDetails()
		{
			chk=false;
			chk=checkFields();
			if(chk)
			{
				qstr=$("#item_detail_update_form").serialize();
				//alert(qstr);
				loadBox('user_seller_edit_item_details_submit.jsp',qstr);
			}
			return false;
		}
		</script>
		<center>
		<div>
			<%
			String q="select * from seller_items where seller_item_id='"+item_id+"' and userid='"+userid+"'";
			ResultSet rs=smt.executeQuery(q);
			if(rs.next())
			{
				String seller_id=rs.getString(2);			
					String msg=request.getParameter("msg");
					if(msg!=null)
					{
						if(msg.equals("1"))
						{
						%>
						<script type="text/javascript">
						alert("Image Changed!");
						</script>
						<%
						}
				
						if(msg.equals("0"))
						{
						%>
						<script type="text/javascript">
						alert("Invalid Image!");
						</script>
						<%
						}
						
						if(msg.equals("Invalid_Price"))
						{
						%>
						<script type="text/javascript">
						alert("Please provide valid price!");
						</script>
						<%
						}
					}
				if(seller_id.equals(userid))
				{
					%>
						<style>
						td
						{
							color:#0066CC;
							text-align:center;
						}
						</style>
						<h3><i><%=rs.getString(3)%></i></h3>  
						<div id="change_picture" style="width:85%;background-color:#FFFFFF;">
						<table cellpadding=10>
						<tr>
						<td>	
							<img src="uploads/<%=rs.getString(5)%>" height=100px width=140px alt="uploads/no_image.jpg"><br><br>
						</td>
						<td>
							<span id="change_picture_form">
							<button id="change_picture_cancel_button" style="color:#FF6666;background-color:#FFFFFF;border-color:#FF6666;border-width:thin;border-style:solid;border-radius:5px;float:right;">x</button>
							<form action="upload_file.jsp?itemid=<%=item_id%>" name="change_item_pic" enctype="multipart/form-data" method="post" onsubmit="return(checkPicture());">
							<b>Select Picture:</b><br><br><input type="file" name="item_pic">&nbsp;&nbsp;<br><br><input type=submit value=Change style="background-color:#FF6600;color:#FFFFFF;width:150px;">
							</form>
							</span>
							<input type=button id="change_picture_button" value="Change Picture" style="background-color:#FFFFFF;color:#0066CC;">
						</td>
						</tr>
						</table>
						</div>
						<form id="item_detail_update_form">
						<input type="hidden" name="item_id" value="<%=item_id%>">
						<table cellpadding=5 style="width:85%;background-color:#FFFFFF;">
						<tr><td><i>Item Name <font color="#FF3333">*</font>:</i></td><td><input type=text name="item_name" value="<%=rs.getString("seller_item_name")%>" size="35"></td></tr>
						<tr><td><i>Item Description <font color="#FF3333">*</font>:</i></td><td><textarea name="item_desc" cols="50" rows="8" style="resize:none"><%=rs.getString("seller_item_description")%></textarea></td></tr>
						<%
						String price_type=rs.getString("seller_item_price_type");
						if(price_type.equals("Fixed"))
						{
							%>
							<tr>
								<td>
								<i>Fixed Price <font color=red>*</font> :</i>
								</td>
								<td>
								<font color="green"><i>Rs.</i>&nbsp;</font><input type="text" name="item_price" value="<%=rs.getString("seller_item_price")%>">
								</td>
							</tr>
							<%
						}
						else if(price_type.equals("Bid"))
						{
							%>
							<tr>
								<td>
								<i>Initial Bid Price <font color=red>*</font> :</i><br>
								<span style="font-size:13px;color:#FF6666">(<i>Caution: Change may cause inconsistency</i>)</span>
								</td>
								<td>
								<font color="green"><i>Rs.</i>&nbsp;</font><input type="text" name="item_price" value="<%=rs.getString("seller_item_price")%>">
								</td>
							</tr>
							<%
						}
						else
						{
							%><input type="hidden" name="item_price" value="N/A"><%
						}
						%>
						<tr>
							<td><i>Status:</i></td>
							<td>
								<select name=item_status style="text-align:center;width:150px;background-color:#FFFFFF;">
								<%
								String item_status=rs.getString("seller_item_status");
								if(item_status.equals("On Sale"))
								{	
									%>
									<option value="On Sale"> On Sale </option>
									<option value="Sold"> Sold </option>
									<%
								}
								else
								{
									%>
									<option value="Sold"> Sold </option>
									<option value="On Sale"> On Sale </option>						
									<%
								}
								%>
								</select>
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<input type="button" onclick="submitDetails();" style="color:#FFFFFF;background-color:#0066CC;border-radius:5px;" value="Update">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset">
							</td>
						</tr>
						</table>
						</form>
					<%
				}
			}
			%>
		</div>
		</center>
<%@ include file="include_bottom.jsp"%>
