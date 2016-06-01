
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
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
<%@ include file = "../pagefile/header.html" %>
    <table width="90%" border="0" align="center" >
    <tr class="tableheader"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%><br><br> </td></tr>
    <tr class="homemenu"><td colspan="1"><!-- <%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%>--><a href="viewModifyConfig.jsp">View/Modify System Configuration</a><br> </td></tr>
<!--<tr class="homemenu"><td colspan="1"> <%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%><a href="systemConfiglogs.jsp"> Check System Configuration logs</a><br><br> </td></tr>-->
     <tr class="tfields">
					</tr>
   </table>
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>

