	
<div id="container">	
	<div id="top">
	<div id="topleft">
		<img src="images/HUAS.png">
	</div>
	<div id="topright">
		<div id="main_top">
		<center>
		<span id="main_top_left" style="float:left;text-align:center;width:82%;font-size:18px;font-style:italic;text-align:center;color:#FFFFFF;">
			<table cellpadding="10" style="text-align:center;width:100%;">
			<tr>
			<td><span id="link_1"><a class="main_links" href="user_home.jsp"><img src="images/home.bmp"><br><b>Home</b></a></span></td>
			<td><span id="link_2"><a class="main_links" href="e-marts.jsp"><img src="images/mart.bmp"><br><b>E-Marts</b></a></span></td>
			<td><span id="link_3"><a class="main_links" href="user_sales.jsp"><img src="images/sales.bmp"><br><b>Sales</b></a></span></td>
			<td><span id="link_4"><a class="main_links" href="user_demands.jsp"><img src="images/demands.bmp"><br><b>Demands</b></a></span></td>
			<td><span id="link_5"><a class="main_links" href="user_rents.jsp"><img src="images/rents.bmp"><br><b>Rents</b></a></span></td>
			</tr>
			</table>
		</span>
		<span id="main_top_right" style="width:18%;float:right;text-align:center;">
		<table cellpadding="5" style="text-align:center;width:100%;color:#FFFFFF;">
			<tr>
			<td><a class="main_links" href="user_account.jsp">My Account</a> | <a class="main_links" href="user_logout.jsp">LOGOUT</a></td>
			</tr>
			<tr>
			<td><marquee scrollamount="3">Welcome to HUAS, <i><%=my_name.split(" ")[0]%>!</i></marquee></td>
			</tr>
		</table>
		</span>
		</center>
		</div>
		<div id="main_bottom">
			<center>
			<span>
			<script>
			function makeSearch()
			{
				if(checkSearchFields())
				{
					openBox('search_outer_box','search_inner_box','user_search_results.jsp',$('#user_search').serialize());
					return true;
				}
				else
				{
					return false;
				}
			}
			</script>
			<form id="user_search" onSubmit="return false;">
			<table cellpadding="10" width="60%">
			<tr>
				<td>
					<input type="text" name="search_keyword" placeholder="--- Search keyword ---" style="width:500px;color:#0066CC;font-size:13px;padding:5px;border:thin solid #AAAAAA;">
				</td>
				<td>
					<select name="search_option" style="color:#0066CC;font-size:13px;;text-align:center;padding:5px;background-color:#FFFFFF;border:thin solid #AAAAAA;">
						<option value="-1" style="color:#AAAAAA"> -- Search in -- </option>
						<option value="1" style="color:#0066CC">Sales</option>
						<option value="2" style="color:#0066CC">Demands</option>
						<option value="3" style="color:#0066CC">Rents</option>
					</select>
				</td>
				<td>
					<button onclick="return(makeSearch());" style="border-radius:0px;border-style:solid;border-width:1px;border-color:#AAAAAA;color:#0066CC;background-color:#FFFFFF;width:40px;height:26px;font-size:15px;padding:3px 5px;"><img src="images/search.jpeg" height="15px" width="16px"></button>
				</td>
			</tr>
			</table>
			</form>
			<div id="search_outer_box" style="background-color:#FFFFFF;height:80%;width:88%;border:#0066CC groove thick;border-radius:5px;position:fixed;top:5%;left:5%;visibility:hidden;border-radius:10px;">
				<button id="search_box_back_button" style="color:#FF6600;float:left;font-size:13px;border:0;padding:5px;border-radius:10px;visibility:hidden;"><b>&lt;&lt; Back</b></button>
				<button style="color:#FF6600;float:right;font-size:13px;border:0;padding:5px;" onclick="$('#search_box_back_button').css('visibility','hidden');closeBox('search_outer_box','search_inner_box');" title="Close">x</button>
				<div id="search_inner_box" style="width:100%;height:92%;overflow-y:scroll;"><center><br><br><img src="images/loading.gif"><br><br><h3>Loading...</h3></center></div>
			</div>
			</span>
			</center>
		</div>
		</div>
	</div>
	
	<div id="mid">
		<div id="left">
			<ul style="font-size:13px;font-style:italic;"> 
			<li style=""><a href=user_items.jsp style="color:#0066CC;">My Items</a><br><br></li>
			<li><a href=user_demand_self_display.jsp style="color:#0066CC;">My Demands</a><br><br></li>
			<li><a href=user_buyer_view_bids.jsp style="color:#0066CC;">My Bids</a><br><br></li>
			<li><a href=user_carts.jsp style="color:#0066CC;">My Carts</a><br></li>
			</ul>
		</div>	
		<div id="content">
