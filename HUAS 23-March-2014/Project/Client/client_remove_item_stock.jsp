<%@ include file="client_top.jsp"%>
<%
smt.executeUpdate("delete from item_stocks where item_stock='"+request.getParameter("stock")+"'");
%>
<%@ include file="client_bottom.jsp"%>
