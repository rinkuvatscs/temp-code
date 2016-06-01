
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("modifyHLR.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(281) )
	{
        %>
          <%@ include file ="../logouterror.jsp" %>
             <%
                 session.invalidate();
                    request.getSession(true).setAttribute("lang",defLangId);
        }
	else
  {
String user_name=sessionHistory.getUser();		
		int hlrId = Integer.parseInt(request.getParameter("id"));
		HLRManager hlrManager = new HLRManager();
            hlrManager.setConnectionPool(conPool);

		HLR hlr = new HLR();
		
		hlr.setHLRId(hlrId );
		hlr.setHLRIp(request.getParameter("serverip"));
		hlr.setHLRPort(Integer.parseInt(request.getParameter("serverport")));
		hlr.setLogin(request.getParameter("login"));
		hlr.setPassword(request.getParameter("password"));
		hlr.setConnection(Integer.parseInt(request.getParameter("numofconallow"),10));
	
WebAdminLogManager webadminlogs= new WebAdminLogManager();
  webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
			String old_values="HLR_ID:"+hlrId+";";	
			String new_values="HLR_ID:"+hlrId+";";	
if(!request.getParameter("old_serverip").equals(request.getParameter("serverip")))
{
old_values=old_values+"HLR_IP:"+request.getParameter("old_serverip")+";";
new_values=new_values+"HLR_IP:"+request.getParameter("serverip")+";";
k=1;
}
if(!request.getParameter("old_serverport").equals(request.getParameter("serverport")))
{
old_values=old_values+"HLR_PORT:"+request.getParameter("old_serverport")+";";
new_values=new_values+"HLR_PORT:"+request.getParameter("serverport")+";";
k=1;
}
if(!request.getParameter("old_login").equals(request.getParameter("login")))
{
old_values=old_values+"LOGIN:"+request.getParameter("old_login")+";";
new_values=new_values+"LOGIN:"+request.getParameter("login")+";";
k=1;
}	
if(!request.getParameter("old_password").equals(request.getParameter("password")))
{
old_values=old_values+"PASSWORD:"+request.getParameter("old_password")+";";
new_values=new_values+"PASSWORD:"+request.getParameter("password")+";";
k=1;
}
if(!request.getParameter("old_numofconallow").equals(request.getParameter("numofconallow")))
{
old_values=old_values+"CONNECTIONS:"+request.getParameter("old_numofconallow")+";";
new_values=new_values+"CONNECTIONS:"+request.getParameter("numofconallow")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("CRBT_HLR_CONFIG");
                logobj.setlink("hlrconfiglog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
		int i = hlrManager.updateHLRConfig(hlr);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}

		if(i < 0)
		{
			%>
			<script language="JavaScript">
				alert("Error!!! Please try again")
				history.go(-1)
			</script>
			<%
		}
		else
		{
%>
		<script language="JavaScript">
			alert("HLR Configuration modified successfully!!")
			window.location="home.jsp"
		</script>
<%
		}
	}
%>
