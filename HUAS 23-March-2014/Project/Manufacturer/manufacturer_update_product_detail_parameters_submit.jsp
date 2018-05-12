<%@ include file="manufacturer_top.jsp"%>
<%
String product_id=ses.getValue("pid").toString();
String product_name=request.getParameter("pname");
int no_of_param=Integer.parseInt(request.getParameter("no_of_param"));
String param_value[]=new String[no_of_param];
for(int i=0;i<no_of_param;i++)
{
	param_value[i]=request.getParameter("param_"+(i+1));
}
ResultSet rs=smt.executeQuery("select parameter_name from product_"+product_id+"_details");
int i=0;
while(rs.next())
{
	String q="update product_"+product_id+"_details set parameter_value='"+param_value[i]+"' where parameter_name='"+rs.getString("parameter_name")+"'";
	i++;
	cn.createStatement().executeUpdate(q);
}
response.sendRedirect("manufacturer_productions.jsp");
%>
<%@ include file="manufacturer_bottom.jsp"%>
