<%
cn.close();
}
catch(Exception ex)
{
	//response.sendRedirect("../index.jsp?invalid_access=1");
	out.println(ex);
}
%>
