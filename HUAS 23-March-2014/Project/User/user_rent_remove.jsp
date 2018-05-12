<%@ include file="include_top.jsp"%>
<%
	smt.executeUpdate("delete from user_rents where rent_id='"+request.getParameter("item")+"' and userid='"+userid+"'");
%>
<%@ include file="include_bottom.jsp"%>



