
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
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

				PrePostManager  serviceManager = new PrePostManager();
            serviceManager.setConnectionPool(conPool);

				PrePost serviceDetail = new PrePost();


				int startAt = Integer.parseInt(request.getParameter("startat"));
				int endsAt = Integer.parseInt(request.getParameter("endsat"));
				String  plan= request.getParameter("plan");
				serviceDetail.setStartsAt(startAt);
				serviceDetail.setEndsAt(endsAt);
				serviceDetail.setsub_type(plan);

				int i = serviceManager.addPrePost(serviceDetail);
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
								%>
												<script language="JavaScript">
												alert("Service Class Added Successfully")
												window.location="home.jsp"
												</script>
												<%
				}
}
%>
