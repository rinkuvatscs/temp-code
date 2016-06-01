<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
    <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("viralsmsrangemodify.jsp");
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
				ViralSMSRange viralsmsrange  = new ViralSMSRange();		 
          viralsmsrange.setConnectionPool(conPool);
			String oldmsisdn=request.getParameter("oldmsisdn");
			String msisdn=request.getParameter("msisdn");

WebAdminLogManager webadminlogs= new WebAdminLogManager();
  webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
String old_values="";
String new_values="";
if(!request.getParameter("oldmsisdn").equals(request.getParameter("msisdn")))
{
			old_values="MSISDN_RANGE:"+oldmsisdn+";";	
			new_values="MSISDN_RANGE:"+msisdn+";";
k=1;
}
   int res=viralsmsrange.rangeEdit(msisdn,oldmsisdn);
if(k==1)
{
																logobj.setTableName("VIRAL_SMS_ALLOWED_RANGES");
                logobj.setlink("viralsmslog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
if(res>=0 && k==1)
{
int rest = webadminlogs.createLog(logobj);
logger.info("logs return =="+rest);
}
			logger.info("get result=="+res);
    if(res == 0 )
    {
%>
        <script language="JavaScript">
            alert("MSISDN Ranage Modify successfully!!!")
            window.location="home.jsp"
        </script>
<%
     }
    else
 	  {
%>
            <script language="JavaScript">
                alert("Error!!! Try Again");
                window.location="home.jsp";
            </script>
<%
    }


}




		/*logger.info(result);
		response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write(result);*/
%>
