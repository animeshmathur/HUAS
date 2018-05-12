<%@page import="java.sql.*"%>
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
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbnm,"hucky","13071992");
	Statement smt=cn.createStatement();
%>
<%
String product_id=request.getParameter("pid");
int c_param_no=Integer.parseInt(request.getParameter("c_param_no"));
String param[]=new String[7];
int k=0;
for(int i=1;i<=7;i++)
{
	String temp=request.getParameter("param_"+i);
	if(temp!=null)
	{
		//out.println(temp);
		param[k]=temp;
		k++;
	}
}
smt.executeUpdate("create table product_"+product_id+"_details(parameter_name text,parameter_value text)");
PreparedStatement p_smt=cn.prepareStatement("insert into product_"+product_id+"_details(parameter_name) values(?)");
for(int i=0;i<k;i++)
{
	p_smt.setString(1,param[i]);
	p_smt.executeUpdate();
}
if(c_param_no>0)
{
	for(int i=1;i<=c_param_no;i++)
	{
		if(request.getParameter("c_param_"+i)!=null)
		{
			p_smt.setString(1,request.getParameter("c_param_"+i));
			p_smt.executeUpdate();
		}
	}
}
%>
<%@ include file="manufacturer_bottom.jsp"%>
