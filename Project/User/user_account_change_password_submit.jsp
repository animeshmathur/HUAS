<%@ include file="include_top.jsp"%>
<%
smt.executeUpdate("update user_register set user_pwd='"+request.getParameter("new_ac_pwd")+"' where userid='"+userid+"'");
out.println("<script>alert('Your account password has been changed!');closeBox('extra_outer_box','extra_inner_box');</script>");
%>
<%@ include file="include_bottom.jsp"%>

