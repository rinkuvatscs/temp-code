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
<TITLE><%=TSSJavaUtil.instance().getKeyValue("Country_Management",defLangId)%></TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader" colspan="2"><%=TSSJavaUtil.instance().getKeyValue("Country_Management",defLangId)%> <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr>
				<td>   <a href="country_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("Add_Country",defLangId)%></a></td>
			</tr>	
			<tr><td  >&nbsp; </td> </tr>
<%
    }
%>
      <tr>
				<td> <a href="country_configuration.jsp"><%=TSSJavaUtil.instance().getKeyValue("Country_Configuration-Management",defLangId)%></a></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
