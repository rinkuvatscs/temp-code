
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
       Logger logger = Logger.getLogger ("modifyIMSI.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(313) )
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

	String user_name=sessionHistory.getUser();	
		String imsiId = request.getParameter("id");
		IMSIManager imsiManager = new IMSIManager();		
      imsiManager.setConnectionPool(conPool);
		IMSI imsi = new IMSI();
		imsi.setRangeId(imsiId);
		imsi.setStartAt(request.getParameter("startat"));
		imsi.setEndsAt(request.getParameter("endsat"));
		imsi.setSubscriberType(request.getParameter("subType"));

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
   String old_values="RANGE_ID:"+imsiId+";";
   String new_values="RANGE_ID:"+imsiId+";";
if(!request.getParameter("old_startat").equals(request.getParameter("startat")))
{
old_values=old_values+"START_AT:"+request.getParameter("old_startat")+";";
new_values=new_values+"START_AT:"+request.getParameter("startat")+";";
k=1;
}
if(!request.getParameter("old_endsat").equals(request.getParameter("endsat")))
{
old_values=old_values+"ENDS_AT:"+request.getParameter("old_endsat")+";";
new_values=new_values+"ENDS_AT:"+request.getParameter("endsat")+";";
k=1;
}
if(!request.getParameter("old_subType").equals(request.getParameter("subType")))
{
old_values=old_values+"SUBSCRIBER_TYPE:"+request.getParameter("old_subType")+";";
new_values=new_values+"SUBSCRIBER_TYPE:"+request.getParameter("subType")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("IMSI_RANGE");
                logobj.setlink("imsiconfiglog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}

		int i = imsiManager.updateIMSIConfig(imsi);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}

		if(i < 0)
		{
			%>
			<script language="JavaScript">
				//alert("Error!!! Please try again")
		alert("<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>")
				history.go(-1)
			</script>
			<%
		}
		else
		{
%>
		<script language="JavaScript">
	//		alert("IMSI Configuration modified successfully!!")
	alert("<%=TSSJavaUtil.instance().getKeyValue("IMSI_Conf_modf_succes",defLangId)%>")
			window.location="home.jsp"
		</script>
<%
		}
	}
%>
