<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		String query=request.getParameter("query");
		query=query.replace("'","''");
		String query_id="";
		ResultSet rs=smt.executeQuery("select query_id from autogen");
		if(rs.next())
		{
			query_id=rs.getString(1);
		}
		rs.close();
		smt.executeUpdate("insert into seller_item_queries values('"+query_id+"','"+item_id+"','"+userid+"','"+query+"',NOW())");
		smt.executeUpdate("update autogen set query_id=query_id+1");
		smt.close();
		response.sendRedirect("user_item_details.jsp?item_id="+item_id);		
%>
<%@ include file="include_bottom.jsp"%>
