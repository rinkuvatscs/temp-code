<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(310))
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
<%@ include file = "../pagefile/header.html"%>

   <table width="80%" border="0" align="center" cellpadding="4" cellspacing="2">
        <tr class="tableheader"><td><%=TSSJavaUtil.instance().getKeyValue("IMSI_Config_Mgt",defLangId)%><br><br></td></tr>
<%
    if(sessionHistory.isAllowed(311))
    {
%>
      <tr class="homemenu">
			   <td><a href="imsiConfig_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("IMSI_Config_Add",defLangId)%></a></td>
      </tr>
<%
    }
%>
      <tr class="homemenu">
       <td> <a href="imsiConfig_manage.jsp"><%=TSSJavaUtil.instance().getKeyValue("IMSI_Config_Manag",defLangId)%></a></td>
			</tr> 
	</table>		
<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>
