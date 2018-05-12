<%@include file="include_top.jsp"%>
<%
		String item_id=request.getParameter("item_id");
		
		String q="select userid from seller_items where seller_item_id='"+item_id+"' and userid='"+userid+"'";
		ResultSet rs=smt.executeQuery(q);
		if(rs.next())
		{
			if(rs.getString(1).equals(userid))
			{
				rs.close();
				q="delete from seller_items where seller_item_id='"+item_id+"'";
				smt.executeUpdate(q);
			}
		}
%>
		<script>
		alert("Item Removed!");
		location.reload();
		</script>
<%@ include file="include_bottom.jsp"%>
