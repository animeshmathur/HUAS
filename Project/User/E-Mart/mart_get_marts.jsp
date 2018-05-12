<%@ include file="../include_top.jsp"%>
<%
ResultSet rs=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_CLIENTS","hucky","13071992").createStatement().executeQuery("select userid,firm_name,firm_address,firm_contact from MERCHANT_REGISTER");
if(rs.next())
{
	Connection cnn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS_MARTS","hucky","13071992");
	String mart_id="";
	%>
	<style>
	.mart_button
	{
		background-color:#FFFFFF;
		color:#0066CC;
		border-radius:10px;
		width:88%;
		padding:10px;
	}
	.mart_button:hover
	{
		background-color:#0066CC;
		color:#FFFFFF;
	}
	.mart_info
	{
		font-size:11px;
	}
	</style>
	<table cellpadding="10" style="width:100%;color:#0066CC;font-size:12px;text-align:center;">
	<tr>
	<%
	int i=0;
	do
	{
		ResultSet rs1=cnn.createStatement().executeQuery("select mart_id from MART_REGISTER where mart_userid='"+rs.getString("userid")+"'");
		if(rs1.next())
		{
			mart_id=rs1.getString("mart_id");
		}
		if(i%3==0&&i!=0)
		{
			%>
			</tr><tr>
			<%
		}
		%>
			<td>
			<button class="mart_button" onclick="loadURL('E-Mart/mart_home.jsp','mart_id=<%=mart_id%>');">
				<b><%=rs.getString("firm_name")%></b><br><i><span class="mart_info"><%=rs.getString("firm_address")%><br><%=rs.getString("firm_contact")%></span></i>
			</button>
			</td>
		<%
		rs1.close();
		i++;
	}while(rs.next());
	if(i%3!=0)
	{
		while(i%3!=0)
		{
			%><td></td><%
			i++;
		}
		%></tr><%
	}
	cnn.close();
	%>
	</table>
	<%
}
%>
<%@ include file="../include_bottom.jsp"%>
