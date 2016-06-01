
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ include file="../lang.jsp" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("modifyServiceClass.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2063))
	{
			session.invalidate();
%>
<%@ include file="../logouterror.jsp" %>
<%
	}
	else
{
String user_name=sessionHistory.getUser();
				ServiceClassManager serviceManager = new ServiceClassManager();
                     serviceManager.setConnectionPool(conPool);
				ServiceClass serviceDetail = new ServiceClass();


				int startAt = Integer.parseInt(request.getParameter("startat"));
				int endsAt = Integer.parseInt(request.getParameter("endsat"));
				int rangeId = Integer.parseInt(request.getParameter("rangeid"));
				int plan= Integer.parseInt(request.getParameter("plan"));
				String old_startAt = request.getParameter("old_startval");
				String old_endsAt = request.getParameter("old_endval");
				String old_plan = request.getParameter("old_planid");
				WebAdminLogManager webadminlogs= new WebAdminLogManager();
                webadminlogs.setConnectionPool(conPool);
				WebAdminLog logobj=new WebAdminLog();
				int k=0;
				String old_values="Range ID:"+rangeId+";";
				String new_values="Range_ID:"+rangeId+";";
				if(!request.getParameter("old_startval").equals(request.getParameter("startat")))
				{
								old_values=old_values+"Start Range:"+request.getParameter("old_startval")+";";
								new_values=new_values+"Start Range:"+request.getParameter("startat")+";";
								k=1;
				}
				if(!request.getParameter("old_endval").equals(request.getParameter("endsat")))
				{
								old_values=old_values+"End Range:"+request.getParameter("old_endval")+";";
								new_values=new_values+"End Range:"+request.getParameter("endsat")+";";
								k=1;
				}
				if(!request.getParameter("old_planid").equals(request.getParameter("plan")))
				{
								old_values=old_values+"Plan ID:"+request.getParameter("old_planid")+";";
								new_values=new_values+"Plan ID:"+request.getParameter("plan")+";";
								k=1;
				}
				if(k==1)
				{
								logobj.setTableName("SERVICE_CLASS_RANGES");
								logobj.setlink("serviceclasslog");
								logobj.setuser(user_name);
								logobj.setPreviousvalue(old_values);
								logobj.setCurrentvalue(new_values);
				}



				serviceDetail.setRatePlan(plan);
				serviceDetail.setStartsAt(startAt);
				serviceDetail.setEndsAt(endsAt);

				int i = serviceManager.updateServiceClass(serviceDetail,rangeId);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}

				if(i < 0)
				{
								if(i == -2 || i==-3 || i==-4)
								{
												logger.info("webadmin/HomeSubscriberManager: Modified Range is overlapping with someother Existing Range, please enter another");
												%>
																<script language="JavaScript">
																alert("Modified Range is overlapping with someother Existing Range, please enter another ")
																history.go(-1)
																</script>
																<%
								}
								else
								{
												if(i==-5)
												{
																logger.info("webadmin/HomeSubscriberManager: Modified other Numbers are  overlapping with some Existing Numbers ");
																%>
																				<script language="JavaScript">
																				alert("Modified Other Numbers are overlapping with some existing Other Numbers")
																				history.go(-1)
																				</script>
																				<%
												}
												else
												{
																if(i==-6)
																{
																				logger.info("Modified Range is overlapping with some Existing Numbers ");
																				%>
																								<script language="JavaScript">
																								alert("Modified Range is overlapping with some already existing Other Numbers")
																								history.go(-1)
																								</script>
																								<%
																}
																else
																{
																				logger.info("There is some System Error.Try later");
																				%>
																								<script language="JavaScript">
																								alert("Please try again, There is some System Error.")
																								window.location="../home.jsp"

																								</script>
																								<%
																}
												}
								}
				}
				else
				{
								logger.info("The updation of Subscriber Range is Successful");
								%>
												<script language="JavaScript">
												alert("Updation of Subscriber Range is Successful!!")
												window.location="home.jsp"
												</script>
												<%
				}
}
%>
