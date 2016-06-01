
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(110) )
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
     <%
		SystemConfigManager systemConfigManager = new SystemConfigManager();
              systemConfigManager.setConnectionPool(conPool);
		ArrayList systemConfigAl = new ArrayList();
		int i =   systemConfigManager.getSystemConfig(systemConfigAl);
%>
<%@ include file = "../pagefile/header.html" %>
    <tr class="tableheader"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%><br><br> </td></tr>
    <table width="90%" border="1" align="center" cellpadding="2" cellspacing="4">
     <tr class="tfields">
      <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("syscCol1",defLangId)%></td>
       <td width="5%"><%=TSSJavaUtil.instance().getKeyValue("syscCol2",defLangId)%></td>
      <td width="50%"><%=TSSJavaUtil.instance().getKeyValue("syscCol3",defLangId)%></td>
<%
		if (sessionHistory.isAllowed(111))
		{
%>
         <td><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
<%
		}
%>
					</tr>
<%
 		if(i < 0)
		{
%>
    <tr class="notice"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%></td></tr> 
<%
		}
		else
		{
				Iterator ite = systemConfigAl.iterator();
				while(ite.hasNext())
				{
				SystemConfig systemConfig = (SystemConfig)ite.next();
			if (systemConfig.getParamTag().equalsIgnoreCase("IVR_DEFAULT_LANGUAGE"))
				{
		SystemConfigManager systemivr_Language = new SystemConfigManager();
            systemivr_Language.setConnectionPool(conPool);
             
		String ivr_language=systemivr_Language.IVR_Language(systemConfig.getParamValue());	
%>
        <tr class="tabledata_center">
          <td align="left" ><%=systemConfig.getParamTag()%></td>
          <td  ><%=ivr_language%></td>
          <td align="left" ><%= systemConfig.getRemarks()%></td>
<%
}
else
{
%>
        <tr class="tabledata_center">
          <td align="left" ><%=systemConfig.getParamTag()%></td>
          <td  ><%=systemConfig.getParamValue()%></td>
          <td align="left" ><%= systemConfig.getRemarks()%></td>
<%

}
				if( sessionHistory.isAllowed(111)) 
					{
%>
					<td ><a href="systemConfig_modify.jsp?param=<%=systemConfig.getParamTag()%>&value=<%=systemConfig.getParamValue()%>&remark=<%=systemConfig.getRemarks()%>"><img src="../images/modify.gif" height="20" border="0"></a> </td>
<%
 			}
%>
			</tr>
<%
			}//while%>
<%		}
%>
   </table>
<tr class="homemenu"><td><a href="home.jsp">Go back</a></td></tr>
      
<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>

