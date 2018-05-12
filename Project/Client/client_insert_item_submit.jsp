<%@ include file="client_top.jsp"%>
<%
	String cat_id=request.getParameter("cat_id");
	String item_id=request.getParameter("item_id");
	String item_name=request.getParameter("item_name");
	String item_brand=request.getParameter("item_brand");
	String item_on_emart=request.getParameter("item_on_emart");
	ResultSet rs=smt.executeQuery("select item_id from autogen");
	if(rs.next())
	{
		smt.executeUpdate("insert into item_reg values('"+rs.getString("item_id")+"','"+cat_id+"','"+item_name+"','"+item_brand+"','"+item_on_emart+"')");
		smt.executeUpdate("update autogen set item_id=item_id+1");
	}
	response.sendRedirect("client_stock.jsp");
%>
<%@ include file="client_bottom.jsp"%>
