<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
     %>
      <%@ include file ="../logouterror.jsp" %>
        <%
          session.invalidate();
             request.getSession(true).setAttribute("lang",defLangId);
     }
else
{
%>
<HTML>
<HEAD>
<TITLE>Network Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader" colspan="2"> Network  Management <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr>
				<td>   <a href="network_add.jsp">Add Network</a>		</td>
			</tr>	
			<tr><td  >&nbsp; </td> </tr>
<%
    }
%>
      <tr>
				<td> <a href="network_configuration.jsp">Network - Management</a></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
