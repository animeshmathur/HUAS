<%@ include file="include_top.jsp"%>
<%
		String search_keyword=request.getParameter("search_keyword");
		String search_option=request.getParameter("search_option");
		
		search_keyword=search_keyword.replace(" ","+");
		
		switch(Integer.parseInt(search_option))
		{
			case 1:
			response.sendRedirect("user_buyer_search_item.jsp?item_keyword="+search_keyword);
			break;
			case 2:
			response.sendRedirect("user_demand_search_demander.jsp?demand_article="+search_keyword);
			break;
			case 3:
			response.sendRedirect("user_rent_search.jsp?keyword="+search_keyword);
			break;
		}
%>
<%@ include file="include_bottom.jsp"%>

