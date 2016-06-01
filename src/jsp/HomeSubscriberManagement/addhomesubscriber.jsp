
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("addhomesubscriber.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(142) )
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
		
		StringTokenizer st = new StringTokenizer(excludes," ,\r\n");
		
		while(st.hasMoreTokens())
		{
			excludesAl.add(st.nextToken());
 		}
		
		
		homesubDetail.setStartAt(startAt);
		homesubDetail.setEndsAt(endsAt);
		homesubDetail.setExcludes(excludesAl);
		homesubDetail.setHLRId(hlrId);

		int i = homeManager.addHomeSubscriber(homesubDetail);
		if(i < 0)
		{
			if(i == -2 || i==-3 || i==-4)
			{
				%>
					<script language="JavaScript">
						//alert("Error!!!  New Range is overlapping with an Existing Range")
						alert("<%=TSSJavaUtil.instance().getKeyValue("New_Range_overlapping",defLangId)%>")
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
							//alert("Error!!! Other Numbers are overlapping with  existing Other Numbers")
                                             alert("<%=TSSJavaUtil.instance().getKeyValue("Other_Numb_overlappipping",defLangId)%>")
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
							//	alert("Error!!!  New Range is overlapping with already existing Other Numbers")
					alert("<%=TSSJavaUtil.instance().getKeyValue("New_Range_is_overlapping",defLangId)%>")
								history.go(-1)
							</script>
						<%
					}
					else
					{
						%>
							<script language="JavaScript">
								//alert("Error!!!  Please try again")
				alert("<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>")
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
			//alert("Home Subscriber Range is Added Successfully")
alert("<%=TSSJavaUtil.instance().getKeyValue("Home_sub_Range",defLangId)%>")
			window.location="home.jsp"
		</script>
<%
	}
}
%>
