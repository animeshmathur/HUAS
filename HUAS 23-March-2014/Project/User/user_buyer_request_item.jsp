<%@ include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		ResultSet rs=smt.executeQuery("select request_id from seller_item_requests where item_id='"+item_id+"' and userid='"+userid+"'");
		
		if(rs.next())
		{
			response.sendRedirect("user_item_details.jsp?item_id="+item_id+"&buyer_request_msg=0");
		}
		else
		{
			rs.close();
			String request_id="";
			rs=smt.executeQuery("select request_id from autogen");
			if(rs.next())
			{
				request_id=rs.getString(1);
			}
			rs.close();
			smt.executeUpdate("insert into seller_item_requests values('"+request_id+"','"+item_id+"','"+userid+"',NOW())");
			smt.executeUpdate("update autogen set request_id=request_id+1");
			response.sendRedirect("user_item_details.jsp?item_id="+item_id+"&buyer_request_msg=1");
		}
%>
<%@ include file="include_bottom.jsp"%>
