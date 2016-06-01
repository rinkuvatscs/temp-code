
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(122) )
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
		int smscid = Integer.parseInt(request.getParameter("id"));
		String smscstatus = new String("");
	
		String clienttype = new String("");
		if(request.getParameter("clienttype").equals("TRANSMITTER"))
			clienttype="T";
		if(request.getParameter("clienttype").equals("RECIEVER"))
			clienttype="R";
		if(request.getParameter("clienttype").equals("TRANSRECIEVER"))
			clienttype="TR";
		if(request.getParameter("status").equals("ACTIVATED"))
			smscstatus="A";
		if(request.getParameter("status").equals("DEACTIVATED"))
			smscstatus="D";
	
		SmscConfig smscConfig = new SmscConfig();
		SmscConfigManager smscConfigManager = new SmscConfigManager();
                smscConfigManager.setConnectionPool(conPool);
		smscConfig.setSmscId(smscid );
		smscConfig.setUserId( request.getParameter("username"));
		smscConfig.setPassword( request.getParameter("password"));
		smscConfig.setSmscIp( request.getParameter("serverip"));
		smscConfig.setSmscPort( Integer.parseInt(request.getParameter("serverport")));
		smscConfig.setSmscStatus( smscstatus);
		smscConfig.setClientType(clienttype);
		smscConfig.setTon( Integer.parseInt(request.getParameter("ton"),10));
		smscConfig.setNpi( Integer.parseInt(request.getParameter("npi")));
		smscConfig.setAddressRange( request.getParameter("range"));
		smscConfig.setNumOfConAllow( Integer.parseInt(request.getParameter("numofconallow"),10));
		smscConfig.setSpeed(Integer.parseInt(request.getParameter("speed")));
		smscConfig.setSystemType( request.getParameter("protocol"));

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
			String old_values="SMSC_ID:"+smscid+";";	
			String new_values="SMSC_ID:"+smscid+";";	
	if(!request.getParameter("old_clienttype").equals(clienttype))
{
			old_values=old_values+"CLIENT_TYPE:"+request.getParameter("old_clienttype")+";";
			new_values=new_values+"CLIENT_TYPE:"+clienttype+";";
k=1;

}
		if(!request.getParameter("old_status").equals(smscstatus))
	{
			old_values=old_values+"STATUS:"+request.getParameter("old_status")+";";
   new_values=new_values+"STATUS:"+smscstatus+";";
k=1;
	}
if(!request.getParameter("old_username").equals(request.getParameter("username")))
{
old_values=old_values+"SMSC_USER_ID:"+request.getParameter("old_username")+";";
   new_values=new_values+"SMSC_USER_ID:"+request.getParameter("username")+";";
k=1;
}
if(!request.getParameter("old_password").equals(request.getParameter("password")))
{
old_values=old_values+"SMSC_PASSWORD:"+request.getParameter("old_password")+";";
   new_values=new_values+"SMSC_PASSWORD:"+request.getParameter("password")+";";
k=1;
}
if(!request.getParameter("old_serverip").equals(request.getParameter("serverip")))
{
old_values=old_values+"SMSC_IP:"+request.getParameter("old_serverip")+";";
   new_values=new_values+"SMSC_IP:"+request.getParameter("serverip")+";";
k=1;
}
if(!request.getParameter("old_serverport").equals(request.getParameter("serverport")))
{
old_values=old_values+"SMSC_PORT:"+request.getParameter("old_serverport")+";";
   new_values=new_values+"SMSC_PORT:"+request.getParameter("serverport")+";";
k=1;
}
if(!request.getParameter("old_ton").equals(request.getParameter("ton")))
{
old_values=old_values+"TON:"+request.getParameter("old_ton")+";";
   new_values=new_values+"TON:"+request.getParameter("ton")+";";
k=1;

}
if(!request.getParameter("old_npi").equals(request.getParameter("npi")))
{
old_values=old_values+"NPI:"+request.getParameter("old_npi")+";";
   new_values=new_values+"NPI:"+request.getParameter("npi")+";";
k=1;
}
if(!request.getParameter("old_range").equals(request.getParameter("range")))
{
old_values=old_values+"ADDRESS_RANGE:"+request.getParameter("old_range")+";";
   new_values=new_values+"ADDRESS_RANGE:"+request.getParameter("range")+";";
k=1;
}
if(!request.getParameter("old_numofconallow").equals(request.getParameter("numofconallow")))
{
old_values=old_values+"NO_OF_CONNECTIONS:"+request.getParameter("old_numofconallow")+";";
   new_values=new_values+"NO_OF_CONNECTIONS:"+request.getParameter("numofconallow")+";";
k=1;
}
if(!request.getParameter("old_speed").equals(request.getParameter("speed")))
{
old_values=old_values+"SPEED:"+request.getParameter("old_speed")+";";
   new_values=new_values+"SPEED:"+request.getParameter("speed")+";";
k=1;
}
if(!request.getParameter("old_protocol").equals(request.getParameter("protocol")))
{
old_values=old_values+"SYSTEM_TYPE:"+request.getParameter("old_protocol")+";";
   new_values=new_values+"SYSTEM_TYPE:"+request.getParameter("protocol")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("GMAT_SMSC_CONFIG");
                logobj.setlink("smscconfigurationlogs");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}	
		int i = smscConfigManager.updateSMSC(smscConfig);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
System.out.println("logs return =="+res);
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
			alert("SMSC Configuration modified successfully!!")
			window.location="home.jsp"
		</script>
<%
		}
	}
%>
