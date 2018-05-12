<%@ include file="client_top.jsp"%>
<%
smt.executeUpdate("insert into item_stocks values(NOW(),'"+request.getParameter("stock_item")+"','"+request.getParameter("stock_qty")+"','"+request.getParameter("stock_cp")+"','"+request.getParameter("stock_sp")+"','"+request.getParameter("stock_mfg")+"','"+request.getParameter("stock_exp")+"','"+request.getParameter("stock_qty")+"')");
%>
<%@ include file="client_bottom.jsp"%>
