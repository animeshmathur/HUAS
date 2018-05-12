<%@ include file="include_top.jsp"%>
<%
String keyword=request.getParameter("keyword");
%>
		<center>
		<%
		
		String q="select category_id,count(rent_id) from user_rents where rent_title like '%"+keyword+"%' or rent_details like '%"+keyword+"%' group by category_id";
		ResultSet rs=smt.executeQuery(q);
		
		%>
			<h2 style="color:#0066CC"><i>Search Results for '<%=keyword%>'</i></h2>
		<%
		
		if(rs.next())
		{
			keyword=keyword.replace(" ","+");
			String cat_id="";
			Statement smt1=cn.createStatement();
			ResultSet rs1=null;
			%>
			</center>
			<ul style="color:#0066CC">
			<%
			do
			{
				cat_id=rs.getString(1);
				rs1=smt1.executeQuery("select category_name from rent_categories where category_id='"+cat_id+"'");
				if(rs1.next())
				{
					%>
						<li>
							<a href="#" onclick="loadSearchBox('user_rent_search_view_category_results.jsp','cat_id=<%=cat_id%>&keyword=<%=keyword%>');return false;" style="background-color:#FFFFAA;font-size:14px;color:#0066FF"><u><i><b><%=rs.getString(2)%> Result(s)</b> found in category '<b><%=rs1.getString(1)%></b>'</i></u></a><br><br>
						</li>
					<%
				}
				rs1.close();
			}while(rs.next());
			%>
			</ul>
			<center >
		<%
		}
		else
		{
			%>
				<font color=red><i>Sorry!</i></font>&nbsp;
				<font color=green><i>No search results found for '<%=keyword%>'</i></font>
			<%
		}
		%>
		</center>
<%@ include file="include_bottom.jsp"%>
