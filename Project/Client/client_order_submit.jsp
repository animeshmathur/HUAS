<%@ include file="client_top.jsp"%>
<%
String order_to=ses.getValue("manufacturer").toString();
Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_ORDERS","hucky","13071992");
Statement stmt=cnn.createStatement();

int total_orders=Integer.parseInt(request.getParameter("total_orders"));
String pid[]=new String[total_orders];
String qty[]=new String[total_orders];
String del_date[]=new String[total_orders];

for(int i=0;i<total_orders;i++)
{
	pid[i]=request.getParameter("pid_"+i);
	qty[i]=request.getParameter(pid[i]+"_qty");
	del_date[i]=request.getParameter(pid[i]+"_del_date");
}

for(int i=0;i<total_orders;i++)
{
	ResultSet rs=stmt.executeQuery("select order_id from AUTOGEN");
	if(rs.next())
	{
		if(!del_date[i].equals(""))
		{
			stmt.executeUpdate("insert into PRODUCT_ORDERS values('"+rs.getString("order_id")+"','"+dbuser+"','"+order_to+"','"+pid[i]+"','"+qty[i]+"','N/A',NOW(),'N/A','"+del_date[i]+"')");
			stmt.executeUpdate("update AUTOGEN set order_id=order_id+1");
		}
		else
		{
			stmt.executeUpdate("insert into PRODUCT_ORDERS values('"+rs.getString("order_id")+"','"+dbuser+"','"+order_to+"','"+pid[i]+"','"+qty[i]+"','N/A',NOW(),'N/A','N/A')");
			stmt.executeUpdate("update AUTOGEN set order_id=order_id+1");
		}
	}
}
cnn.close();
%>
<img src="images/tick.jpg"><br><br>
Your order has been placed successfully!
<%@ include file="client_bottom.jsp"%>
