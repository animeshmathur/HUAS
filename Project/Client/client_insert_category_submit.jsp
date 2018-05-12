<%@ include file="client_top.jsp"%>
<%
	String cat_id="";
	ResultSet rs=smt.executeQuery("select cat_id from autogen");
	String catid="";
	if(rs.next())
	{
		cat_id=rs.getString(1);
		String cat_name=request.getParameter("cat_name");
		String cat_desc=request.getParameter("cat_desc");
		smt.executeUpdate("insert into item_category values('"+cat_id+"','"+cat_name+"','"+cat_desc+"')");
		smt.executeUpdate("update autogen set cat_id=cat_id+1");
		out.println("Category '"+cat_name+"' added!");
	}
%>
<%@ include file="client_bottom.jsp"%>
