<%@page import="java.sql.*" %>
<%
try
{
	HttpSession ses=request.getSession(true);
	String dbuser=ses.getValue("dbuser").toString();
	ses.putValue("dbuser",dbuser);
	String dbpwd=ses.getValue("dbpwd").toString();
	ses.putValue("dbpwd",dbpwd);
	String dbnm=ses.getValue("dbnm").toString();
	ses.putValue("dbnm",dbnm);
	String firmnm=ses.getValue("firmnm").toString();
	ses.putValue("firmnm",firmnm);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,dbuser,dbpwd);
	Statement smt=cn.createStatement();
	
	String product_nm=request.getParameter("pnm");
	String product_code=request.getParameter("pcode");
	if(product_code.equals("null")||product_code==null)
	{
		product_code="-";
	}
	String product_specification=request.getParameter("pspec");
	
	ResultSet rs=smt.executeQuery("select product_id from autogen;");
	if(rs.next())
	{
		String new_product_id=rs.getString(1);
		smt.executeUpdate("insert into products values('"+new_product_id+"','"+product_nm+"','"+product_code+"','"+product_specification+"')");
		smt.executeUpdate("update autogen set product_id=product_id+1");
		out.println(new_product_id);
	}
}
catch(Exception ex)
{
	%>
	Error: <%=ex%>
	<%
}
%>
