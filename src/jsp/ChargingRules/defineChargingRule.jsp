<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("defineChargingRule.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2051) )
{
	%>
		<%@ include file ="../logouterror.jsp" %>
		<%
}
else
{
	ChargingCodeManager 	chgManager = new ChargingCodeManager();
       chgManager.setConnectionPool(conPool);

	ChargingCode chCode = new ChargingCode();

	chCode.setSubChgCode(request.getParameter("subCharge"));
	chCode.setRbtChgCode(request.getParameter("rbtCharge"));
	chCode.setRbtNormalChgCode(request.getParameter("rbtNormalCharge"));
	chCode.setRbtNoChgCode(request.getParameter("rbtNoCharge"));
	chCode.setRbtRecChgCode(request.getParameter("rbtRecCharge"));
	chCode.setRbtGiftChgCode(request.getParameter("rbtGiftCharge"));
	chCode.setRbtMonoChgCode(request.getParameter("rbtMonoCharge"));
	chCode.setRbtFree(Integer.parseInt(request.getParameter("rbtFree")));
	chCode.setValidity (Integer.parseInt(request.getParameter("validity")));
	chCode.setRemarks (request.getParameter("remarks"));

	int i = chgManager.defineChargingRule(chCode);

	if(i < 0)
	{
		%>
			<script language="JavaScript">
			alert("Error!!! Try Again")
			window.location="home.jsp"
			</script>
			<%
	}
	else if(i > 0)
	{
		logger.info("webadmin/ChargingRules: Chrging Rule is added Successfully");
		%>
			<script language="JavaScript">
			alert("Charging Rule added successfully!!!")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>



