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
 <%@ include file="../lang.jsp" %>
<HTML>
<HEAD>
<TITLE> <%=TSSJavaUtil.instance().getKeyValue("Network_Group_Management",defLangId)%></TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader"> <%=TSSJavaUtil.instance().getKeyValue("Network_Group_Management",defLangId)%><br><br> </td></tr>
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr class="usermenu"
      <td valign="middle">   <a href="networkGrp_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("Add_Network_Group",defLangId)%> </a><br><br>	</td>
			</tr>	
<%
    }
%>
      <tr class="usermenu">
				<td valign="middle"> <a href="networkGrp_configuration.jsp"> <%=TSSJavaUtil.instance().getKeyValue("Network_Group_Management",defLangId)%> </a><br><br></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
