
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("modifyhomesub.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(143))
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

				HomeSubscriberManager homeManager = new HomeSubscriberManager();
             homeManager.setConnectionPool(conPool);
				HomeSubDetail homesubDetail = new HomeSubDetail();
				
				ArrayList excludesAl = new ArrayList();
				
				String startAt = request.getParameter("startat");
				String endsAt = request.getParameter("endsat");
				String excludes = request.getParameter("excludes");
				int hlrId = Integer.parseInt( request.getParameter("hlr") );

				int rangeId = Integer.parseInt(request.getParameter("rangeid"));
				
				//space, comma, tab, carriage return, new line all will be delimeters 		
				StringTokenizer st = new StringTokenizer(excludes," ,\t\r\n");
				
				while(st.hasMoreTokens())
				{
								excludesAl.add(st.nextToken());
				}


				homesubDetail.setRangeId(rangeId);
				homesubDetail.setStartAt(startAt);
				homesubDetail.setEndsAt(endsAt);
				homesubDetail.setExcludes(excludesAl);
				homesubDetail.setHLRId(hlrId);

				int i = homeManager.updateHomeSubscriber(homesubDetail);
				if(i < 0)
				{
								if(i == -2 || i==-3 || i==-4)
								{
												logger.info("webadmin/HomeSubscriberManager: Modified Range is overlapping with someother Existing Range, please enter another");
												%>
																<script language="JavaScript">
			//alert("Modified Range is overlapping with someother Existing Range, please enter another ")
			alert("<%=TSSJavaUtil.instance().getKeyValue("Modified_Range",defLangId)%>")
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
																				//alert("Modified Other Numbers are overlapping with some existing Other Numbers")
																				alert("<%=TSSJavaUtil.instance().getKeyValue("Modified_Other_Numbers",defLangId)%>")
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
																								//alert("Modified Range is overlapping with some already existing Other Numbers")
																								alert("<%=TSSJavaUtil.instance().getKeyValue("Modified_Range",defLangId)%>")
																								history.go(-1)
																								</script>
																								<%
																}
																else
																{
																			logger.info("There is some System Error.Try later");
																				%>
																								<script language="JavaScript">
																							//	alert("Please try again, There is some System Error.")
																							alert("<%=TSSJavaUtil.instance().getKeyValue(" Try_Again",defLangId)%>")
																								window.location="../home.jsp"
																								
																								</script>
																								<%
																}
												}
								}
				}
				else
				{
						logger.info("The updation of Home Subscriber Range is Successful");
								%>
												<script language="JavaScript">
						//alert("Updation of Home Subscriber Range is Successful!!")
						alert("<%=TSSJavaUtil.instance().getKeyValue("Updation_of_Home",defLangId)%>")
												window.location="home.jsp"
												</script>
												<%
				}
	}
%>
