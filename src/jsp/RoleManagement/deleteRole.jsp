
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
  <%@page import = "org.apache.log4j.*" %>

<%
   Logger logger = Logger.getLogger ("deleteRole.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null ||  !sessionHistory.isAllowed(193) )
	{
%>
		<%@ include file="../logouterror.jsp" %>
<%
	}
	else
{
%>
 
<%@ include file="../lang.jsp" %>
<%
	RoleTypeManager roleManager = new RoleTypeManager();
      roleManager.setConnectionPool(conPool);

	String RoleArr[] = request.getParameterValues("delRole");
	int i = roleManager.deleteRoleData(RoleArr);

	if(i == -66)
	{
		logger.info("webadmin/RoleManager: This RoleType cannot be deleted");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alnoroledel",defLangId)%>")
			window.location="roleManagement.jsp"
			</script>
			<%
	}
	else
	{
		logger.info("webadmin/RoleManager: The RoleType deleted successfully");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alroledel",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>
