
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(141))
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
		String strRangeIdArr[] = (String [])request.getParameterValues("rangeid");
		int rangeIdArr[] = new int[strRangeIdArr.length];
	
		for(int j=0;j <strRangeIdArr.length;j++)
		{
			rangeIdArr[j] = Integer.parseInt(strRangeIdArr[j]);
		}
	
		int i = homeManager.deleteHomeSubscriber(rangeIdArr);
		
		if(i < 0)
		{
						%>
										<script language="JavaScript">
										//alert("Error!!! Try Again")
				 alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
										window.location="../home.jsp"
										</script>
										<%
		}
		else
		{
						%>
										<script language="JavaScript">
										//alert("Deletion Successful!!!")
		alert("<%=TSSJavaUtil.instance().getKeyValue("Deletion_Successful",defLangId)%>")
										window.location="home.jsp"
										</script>
										<%
		}
}
%>
