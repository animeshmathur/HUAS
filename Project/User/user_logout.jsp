<%@ include file="include_top.jsp"%>
<%
	ses.invalidate();
	cookies[0].setMaxAge(0);
	response.sendRedirect("../index.jsp");
%>
<%@ include file="include_bottom.jsp"%>
