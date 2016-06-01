
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("addServiceClass.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2060) )
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
	ServiceClassManager  serviceManager = new ServiceClassManager();
       serviceManager.setConnectionPool(conPool);
	ServiceClass serviceDetail = new ServiceClass();


	int startAt = Integer.parseInt(request.getParameter("startat"));
	int endsAt = Integer.parseInt(request.getParameter("endsat"));
	int  plan= Integer.parseInt(request.getParameter("plan"));
	serviceDetail.setStartsAt(startAt);
	serviceDetail.setEndsAt(endsAt);
	serviceDetail.setRatePlan(plan);

	int i = serviceManager.addServiceClass(serviceDetail);
	if(i < 0)
	{
		if(i == -2 || i==-3 || i==-4)
		{
			%>
				<script language="JavaScript">
				alert("Error!!!  New Range is overlapping with an Existing Range")
				history.go(-1)
				</script>
				<%
		}
		else
		{
			if(i==-5)
			{
				%>
					<script language="JavaScript">
					alert("Error!!! Other Numbers are overlapping with  existing Other Numbers")
					history.go(-1)
					</script>
					<%
			}
			else
			{
				if(i==-6)
				{
					%>
						<script language="JavaScript">
						alert("Error!!!  New Range is overlapping with already existing Other Numbers")
						history.go(-1)
						</script>
						<%
				}
				else
				{
					%>
						<script language="JavaScript">
						alert("Error!!!  Please try again")
						window.location="../home.jsp"
						</script>
						<%
				}
			}
		}
	}
	else
	{
		logger.info("webadmin/HomeSubscriberManager: Home Susbscriber Range is Added Successfully");
		%>
			<script language="JavaScript">
			alert("Service Class Added Successfully")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>
