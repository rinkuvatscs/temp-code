<%--
	All authentication logic resides in this class
	This class also initializes a SubscriberProfile Object depending on profile
	of msisdn. This SubscriberProfile Object is then used later by other jsps
--%>
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("addUser.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(153))
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
		  AdminUserManager 	adminManager = new AdminUserManager();
                adminManager.setConnectionPool(conPool);
		AdminUser adminUser = new AdminUser();

		adminUser.setUserName( request.getParameter("userName"));
		adminUser.setPassword( request.getParameter("password"));
		adminUser.setEmail( request.getParameter("email"));
		adminUser.setMobileNum( request.getParameter("mobilenum"));
		adminUser.setRoleId(Integer.parseInt( request.getParameter("roleType"))) ;
	
		int i = adminManager.addUser(adminUser);

		if(i < 0)
		{
			if(i == -2 )
			{
		
						logger.info("webadmin/UserManagement: The User name already exists");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alusrexist",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else
			%>
				<script language="JavaScript">
					alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
					window.location="../home.jsp"
				</script>
			<%
		}
		else
		{
						logger.info("webadmin/UserManagement: The User is added Successfully");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alusradded",defLangId)%>!!!")
					window.location="home.jsp"
				</script>
<%
		}
	}
%>
