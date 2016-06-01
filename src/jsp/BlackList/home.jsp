
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(320))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
//			String url = response.encodeRedirectURL("../logouterror.jsp");
//			response.sendRedirect(url);
}
else
{
%>
<HTML>
<HEAD>
<TITLE>BlackList Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr class="tableheader"><td > <%=TSSJavaUtil.instance().getKeyValue("blManage")%> <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(321))
    {
%>
    	
			<tr>
				<td>   <a href="blacklist.jsp"><%=TSSJavaUtil.instance().getKeyValue("advManage")%><%=TSSJavaUtil.instance().getKeyValue("adlistin")%></a><br><br>		</td>
			</tr>	
<%
    }
%>
      <tr>
				<td> <a href="config.jsp"><%=TSSJavaUtil.instance().getKeyValue("blConfig")%> - <%=TSSJavaUtil.instance().getKeyValue("mngment")%></a><br><br></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
