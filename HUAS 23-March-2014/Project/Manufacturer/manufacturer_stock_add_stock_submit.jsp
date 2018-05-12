<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=request.getParameter("add_stock_product_id");
String quantity=request.getParameter("add_stock_quantity");
String date_of_mfg=request.getParameter("add_stock_year_of_mfg")+"-"+request.getParameter("add_stock_month_of_mfg")+"-"+request.getParameter("add_stock_day_of_mfg");
String date_of_exp=request.getParameter("add_stock_year_of_exp")+"-"+request.getParameter("add_stock_month_of_exp")+"-"+request.getParameter("add_stock_day_of_exp");
ResultSet rs=smt.executeQuery("select stock_entry_id from autogen");
if(rs.next())
{
	String stock_entry_id=rs.getString("stock_entry_id");
	rs.close();
	smt.executeUpdate("insert into product_stock values('"+stock_entry_id+"','"+product_id+"','"+quantity+"','"+date_of_mfg+"','"+date_of_exp+"',NOW())");
	smt.executeUpdate("update autogen set stock_entry_id=stock_entry_id+1");
}
response.sendRedirect("manufacturer_stock.jsp");
%>
<%@ include file="manufacturer_bottom.jsp"%>
