
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
%>
<%
    Logger logger = Logger.getLogger ("modifyRole.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(192) )
	{
%>
		<%@ include file ="../logouterror.jsp" %>
<%
	}
	else
	{
	%>
	
<%@ include file="../lang.jsp" %>
   <%	
		RoleTypeManager roleManager = new RoleTypeManager();
		roleManager.setConnectionPool(conPool);
		int roleId = Integer.parseInt(request.getParameter("id"));
		String[] links = request.getParameterValues("links");

		int i = roleManager.updateRoleData(roleId, links);
		
		if(i < 0)
		{
		%>
			<script language="JavaScript">
				alert("Error!!!<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
				window.location="../home.jsp"
			</script>
<%
		}
	else
	{
					logger.info("webadmin/RoleManager: Updation of RoleType "+roleId+" Successfull");
	%>
			<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("alrolemodi",defLangId)%>!!!")
				window.location="home.jsp"
			</script>
<%
	}
}
%>
