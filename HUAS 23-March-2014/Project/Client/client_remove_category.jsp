<%@ include file="client_top.jsp"%>
<%
	String cat_id=request.getParameter("cat_id");
	ResultSet rs=smt.executeQuery("select cat_name from item_category where cat_id='"+cat_id+"'");
	String cat_name="";
	if(rs.next())
	{
		cat_name=rs.getString("cat_name");
	}
	rs.close();
	smt.executeUpdate("delete from item_category where cat_id='"+cat_id+"'");
	out.println("Category '"+cat_name+"' and items associated with it have been removed!");
%>
<%@ include file="client_bottom.jsp"%>
