
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*"%>
 <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("servicepromo_execute.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(160))
	{
	%>
	 <%@ include file ="../logouterror.jsp" %>
	   <%
	     session.invalidate();
	        request.getSession(true).setAttribute("lang",defLangId);
	         }
	
	else
	{
				ServicePromotionManager serviceManager = new ServicePromotionManager();			
                        serviceManager.setConnectionPool(conPool);
				String startDate = request.getParameter("date");
				String startTime = request.getParameter("start_time");
				String smsType = request.getParameter("smsType");
				String subType  = request.getParameter("subType");
				String message  = request.getParameter("message");

				long ret = -1;
				logger.info("startDate= "+startDate);
				logger.info("startTime= "+startTime);
				logger.info("smsType= "+smsType);
				logger.info("subType= "+subType);
				logger.info("message= "+message);

				ret = serviceManager.sendPromotionalSMS(startDate,startTime,subType,smsType, message);

				if (ret == 1)
				{
								%>
												<script language="JavaScript">
												alert("Message stored for sending")
												window.location="home.jsp"
												</script>
												<%
				}
				else
				{
								%>
												<script language="JavaScript">
												alert("Try again later")
												window.location="../home.jsp"
												</script>
												<%
				}
	}
%>
