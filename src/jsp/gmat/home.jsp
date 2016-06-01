

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
  SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory ==null || !sessionHistory.isAllowed(143) )
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

<%@ include file="../pagefile/header.html"%>
      <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader" colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("GMAT_Management",defLangId)%> <br><br></td></tr>
				
    	
			<tr>
				<td class="homemenu">   <a href="gmat_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("Add_GMAT",defLangId)%></a>	</td>
			</tr>	
			<tr><td  >&nbsp; </td> </tr>
      <tr>
				<td class="homemenu"> <a href="gmat_config.jsp"><%=TSSJavaUtil.instance().getKeyValue("Modify_GMAT",defLangId)%> </a></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
