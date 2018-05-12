<%@ include file="include_top.jsp"%>
<%
smt.executeUpdate("update user_register set user_name='"+request.getParameter("new_name")+"',user_address='"+request.getParameter("new_address")+"',user_pincode='"+request.getParameter("new_pincode")+"',user_city='"+request.getParameter("new_city")+"',user_contact='"+request.getParameter("new_contact")+"',user_email='"+request.getParameter("new_email")+"' where userid='"+userid+"'");
%>
<%@ include file="include_bottom.jsp"%>
