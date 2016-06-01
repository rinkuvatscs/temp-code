
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
<TITLE>Subscriber Group Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader">Subscriber Group Management <br><br> </td></tr>
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr class="usermenu">
				<td valign="middle">   <a href="grp_add.jsp">Add Subscriber Group</a><br><br>		</td>
			</tr>	
			<tr class="usermenu">
				<td valign="middle">   <a href="alert_add.jsp">Define Alert for Sub. Group</a><br><br>		</td>
			</tr>	
<%
    }
%>
      <tr class="usermenu">
				<td valign="middle"><b>Subscriber Group Management</b><br>
				                       &nbsp;&nbsp;&nbsp;1. <a href="config_subgrp.jsp">Manage Subscriber Group</a><br>
															 &nbsp;&nbsp;&nbsp;2. <a href="config_alert.jsp">Manage Alerts</a><br> 
				</td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
