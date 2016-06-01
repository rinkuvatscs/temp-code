
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*"%>
 <%@ include file = "../conPool.jsp" %>
<%
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
	String subType  = request.getParameter("subs");
	String calls  = request.getParameter("calls");
	long ret = -1;

	ret = serviceManager.sendRingtoneSMS(subType, calls);

	if (ret == 1)
	{
	  if(subType.equals("1"))
	  {
%>
		<script language="JavaScript">
			alert("Ringtone promotion Enabled")
			window.location="home.jsp"
		</script>
<%
	  }
	  else
	  {
%>
		<script language="JavaScript">
			alert("Ringtone promotion Disabled")
			window.location="home.jsp"
		</script>
<%
	  }
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
