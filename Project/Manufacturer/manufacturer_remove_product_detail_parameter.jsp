<%@include file="manufacturer_top.jsp"%>
<%
String product_id=ses.getValue("pid").toString();
String param=request.getParameter("param");
smt.executeUpdate("delete from product_"+product_id+"_details where parameter_name='"+param+"'");
%>
<%@include file="manufacturer_bottom.jsp"%>
