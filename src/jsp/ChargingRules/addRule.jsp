<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("addRule.jsp");
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

					double amt_p = (new Float(request.getParameter("amt_p"))).doubleValue();
					double amt_o = (new Float(request.getParameter("amt_o"))).doubleValue();

		chCode.setDesc( request.getParameter("crname"));
	chCode.setAmountP(amt_p);
	chCode.setAmountO(amt_o);

	int i = chgManager.addChargingCode(chCode);

	if(i < 0)
	{
		if(i == -2 )
		{

			logger.info("webadmin/ChargingRules: This Charging Rule already exists");
			%>
				<script language="JavaScript">
				alert("Charging Rule already exists")
				history.go(-1)
				</script>
				<%
		}
		else
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

