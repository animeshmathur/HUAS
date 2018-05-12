<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=ses.getValue("pid").toString();
String param=request.getParameter("param");
String param_value=request.getParameter("param_value");
if(param!=null&&param_value!=null)
smt.executeUpdate("insert into product_"+product_id+"_details values('"+param+"','"+param_value+"')");
%>
<%@ include file="manufacturer_bottom.jsp"%>
