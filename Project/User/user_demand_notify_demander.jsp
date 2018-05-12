<%@ include file="include_top.jsp"%>
<%		
		String demand_id=request.getParameter("demand_id");
		String demand_article=request.getParameter("demand_article");
		
		ResultSet rs=smt.executeQuery("select notification_id from autogen");
		
		String notification_id="";
		if(rs.next())
		{
			notification_id=rs.getString(1);
		}
		rs.close();
		
		smt.executeUpdate("insert into user_demand_notifications values('"+notification_id+"','"+demand_id+"','"+userid+"')");
		
		smt.executeUpdate("update autogen set notification_id=notification_id+1");
%>
<%@ include file="include_bottom.jsp"%>
