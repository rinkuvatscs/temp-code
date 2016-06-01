
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(152))
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
		AdminUserManager adminManager = new AdminUserManager();
			adminManager.setConnectionPool(conPool);			
		ArrayList adminUserAl = new ArrayList();
		String adminUserArr[] = (String [])request.getParameterValues("delUser");
		
		for(int j = 0; j < adminUserArr.length; j++)
		{
			String userName = adminUserArr[j];
			adminUserAl.add(userName);
		}
		
		int i = adminManager.deleteUser(adminUserAl);
		
		if(i < 0)
		{
			%>
			<script language="JavaScript">
				alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
				window.location="../home.jsp"
			</script>
<%
		}
		else
		{
			%>
			<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("aluserdel",defLangId)%>")
				window.location="home.jsp"
			</script>
<%
	  } 
  }
%>
