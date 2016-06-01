
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
    <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("updateCorp.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(155))
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
 
		  CorpManager 	corpManager = new CorpManager();
           corpManager.setConnectionPool(conPool);
		  CorpUser corpUser = new CorpUser();
String user_name=sessionHistory.getUser();
		String msisdn = TSSJavaUtil.instance().getInternationalNumber(request.getParameter("msisdn").trim());
		
		corpUser.setCorpName( request.getParameter("corpName"));
		corpUser.setChargingMsisdn(msisdn);
		corpUser.setUserName( request.getParameter("userName"));
		corpUser.setPassword( request.getParameter("password"));
		corpUser.setPlanIndicator(Integer.parseInt(request.getParameter("planName")));
		corpUser.setCorpId(Long.parseLong(request.getParameter("corpId")));
WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
   String old_values="CORP_ID:"+request.getParameter("corpId")+";";
   String new_values="CORP_ID:"+request.getParameter("corpId")+";";
	if(!request.getParameter("old_msisdn").equals(request.getParameter("msisdn")))
{
old_values=old_values+"CHARGING_MSISDN:"+request.getParameter("old_msisdn")+";";
new_values=new_values+"CHARGING_MSISDN:"+request.getParameter("msisdn")+";";
k=1;
}
if(!request.getParameter("old_planName").equals(request.getParameter("planName")))
{
old_values=old_values+"PLAN_INDICATOR:"+request.getParameter("old_planName")+";";
new_values=new_values+"PLAN_INDICATOR:"+request.getParameter("planName")+";";
k=1;
}
if(!request.getParameter("old_password").equals(request.getParameter("password")))
{
old_values=old_values+"PASSWORD:"+request.getParameter("old_password")+";";
new_values=new_values+"PASSWORD:"+request.getParameter("password")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("CRBT_CORP_DETAIL");
                logobj.setlink("corporatemanagementlog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
		int i = corpManager.updateCorp(corpUser);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}
			if(i == -3 )
			{
		
						logger.info("webadmin/CorporateManagement: The Corporate billing msisdn already exists for other corpUser");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("albillnumal",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else if(i == -12 )
			{
				logger.info("webadmin/CorporateManagement: The billing msisdn is not in specified range");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alnumrng",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else if(i == 1)
	  	{
					logger.info("webadmin/UserManagement: The Corporate details are modified successfully");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alcorpmodi",defLangId)%>")
					window.location="home.jsp"
				</script>
<%
		  }
		 else
			{
			%>
				<script language="JavaScript">
					alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
					window.location="../home.jsp"
				</script>
			<%
		 }
	}
%>
