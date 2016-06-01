
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("modifyChargingRule.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2052))
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
					ChargingCodeManager 	chgManager = new ChargingCodeManager();
                         chgManager.setConnectionPool(conPool);
					ChargingCode chCode= new ChargingCode();
					long chgcode= Long.parseLong(request.getParameter("chgcode"));
					double amt_p = (new Float(request.getParameter("amt_p"))).doubleValue();
					double amt_o = (new Float(request.getParameter("amt_o"))).doubleValue();
					chCode.setDesc( request.getParameter("crname"));
					chCode.setAmountP(amt_p);
					chCode.setAmountO(amt_o);

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
   String old_values="Charging_Code:"+chgcode+";";
   String new_values="Charging_Code:"+chgcode+";";
if(!request.getParameter("old_amt_p").equals(request.getParameter("amt_p")))
{
old_values=old_values+"AMOUNT_PRE:"+request.getParameter("old_amt_p")+";";
new_values=new_values+"AMOUNT_PRE:"+request.getParameter("amt_p")+";";
k=1;
}
if(!request.getParameter("old_amt_o").equals(request.getParameter("amt_o")))
{
old_values=old_values+"AMOUNT_POST:"+request.getParameter("old_amt_o")+";";
new_values=new_values+"AMOUNT_POST:"+request.getParameter("amt_o")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("CRBT_CHARGING_CODE");
                logobj.setlink("chargingruleslog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
	int i = chgManager.updateChargingCode(chCode, chgcode);	
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}
	
			if(i == 1)
	  	{
					logger.info("webadmin/ChargingRule: ChargingRule modified successfully");
			%>
				<script language="JavaScript">
					alert("Charging Rule is modified successfully")
					window.location="home.jsp"
				</script>
<%
		  }
				else
				{
			%>
				<script language="JavaScript">
					alert("Error!!! Try Again")
					window.location="../home.jsp"
				</script>
			<%}
	}
%>
