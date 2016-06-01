 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@page import = "org.apache.log4j.*" %>
<%
    Logger logger = Logger.getLogger ("modifyAdminUser.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(151))
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
		AdminUser adminUser = new AdminUser();
String user_name=sessionHistory.getUser();		
		adminUser.setUserName( request.getParameter("userName"));
		adminUser.setPassword( request.getParameter("password"));
		adminUser.setEmail( request.getParameter("email"));
		adminUser.setMobileNum( request.getParameter("mobilenum"));
		adminUser.setRoleId(Integer.parseInt( request.getParameter("roletype")) );

WebAdminLogManager webadminlogs= new WebAdminLogManager();
  webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
   String old_values="USER_NAME:"+request.getParameter("userName")+";";
   String new_values="USER_NAME:"+request.getParameter("userName")+";";
if(!request.getParameter("old_password").equals(request.getParameter("password")))
{
old_values=old_values+"PASSWORD:"+request.getParameter("old_password")+";";
new_values=new_values+"PASSWORD:"+request.getParameter("password")+";";
k=1;
}
if(!request.getParameter("old_email").equals(request.getParameter("email")))
{
old_values=old_values+"EMAIL:"+request.getParameter("old_email")+";";
new_values=new_values+"EMAIL:"+request.getParameter("email")+";";
k=1;
}	
if(!request.getParameter("old_mobilenum").equals(request.getParameter("mobilenum")))
{
old_values=old_values+"MOBILE_NUM:"+request.getParameter("old_mobilenum")+";";
new_values=new_values+"MOBILE_NUM:"+request.getParameter("mobilenum")+";";
k=1;
}
if(!request.getParameter("old_roletype").equals(request.getParameter("roletype")))
{
old_values=old_values+"ROLE_ID:"+request.getParameter("old_roletype")+";";
new_values=new_values+"ROLE_ID:"+request.getParameter("roletype")+";";
k=1;
}
	if(k==1)
{
																logobj.setTableName("CRBT_ADMINUSER");
                logobj.setlink("usermanagementlog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
		int i = adminManager.updateUser(adminUser);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}
		if(i < 0)
		{
				logger.info("webadmin/UserManagement: There is some Error in updateUser() function.");
%>
			<script language="JavaScript">
				alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
				window.location="../home.jsp"
			</script>
<%
		}
		else
		{
				logger.info("User Data is modified successfully");
%>
			<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("alusrmodi",defLangId)%>!!!")
				window.location="home.jsp"
			</script>
<%
		}
	}
%>
