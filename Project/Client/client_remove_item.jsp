<%@ include file="client_top.jsp"%>
<%
	String item_id=request.getParameter("item_id");
	ResultSet rs=smt.executeQuery("select item_name from item_reg where item_id='"+item_id+"'");
	String item_name="";
	if(rs.next()){item_name=rs.getString("item_name");}
	rs.close();
	smt.executeUpdate("delete from item_reg where item_id='"+item_id+"'");
	out.println(item_name+" removed from stock!");
%>
<%@ include file="client_bottom.jsp"%>
