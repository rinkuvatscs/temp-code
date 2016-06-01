
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if(sessionHistory == null)
{
%>
	<%@ include file="logouterror.jsp" %>
<%
}
else
{
%>
 <%@ include file="../lang.jsp" %>

<%@ include file = "pagefile/headerError.html"%>
			
			<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>!

			
<%@ include file = "pagefile/footer.html"%>

<%}%>
