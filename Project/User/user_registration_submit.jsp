<%@page import="java.sql.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","guest_user","iamhuasuser");
	Statement smt=cn.createStatement();
	
	String emailid=request.getParameter("emailid");
	String pwd=request.getParameter("pwd");
	String user_name=request.getParameter("user_name");
	String user_address=request.getParameter("user_address");
	String user_pincode=request.getParameter("user_pincode");
	String user_city=request.getParameter("user_city");
	String user_contact=request.getParameter("user_contact");
	String user_email=request.getParameter("user_email");
	
        ResultSet rs=smt.executeQuery("select userid from autogen");
        if(rs.next())
        {
            smt.executeUpdate("insert into user_register values('HUAS"+rs.getString("userid")+"','"+emailid+"','"+pwd+"','"+user_name+"','"+user_address+"','"+user_pincode+"','"+user_city+"','"+user_contact+"')");
            smt.executeUpdate("update autogen set userid=userid+1");
        }
        cn.close();
	response.sendRedirect("userchecklogin.jsp?emailid="+emailid+"&pwd="+pwd);
}
catch(Exception ex)
{
	response.sendRedirect("../index.jsp");
}
%>

