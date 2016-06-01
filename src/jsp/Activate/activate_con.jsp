
<%@ page import = "com.telemune.webadmin.webif.*"%>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(170))
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
	Runtime runtime = Runtime.getRuntime();
	runtime.exec("/home/crbtuser/bin/activateallsubs.sh");
%>
	<script language = "Javascript">
		alert("<%=TSSJavaUtil.instance().getKeyValue("activated",defLangId)%> ");
		history.back(-1)
	</script>
<%
}
%>
