
<%@ page import = "java.util.*"%>
<%@ page import = "com.telemune.webadmin.webif.*" %>

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

				ret = serviceManager.sendViralSMS(subType, calls);

				if (ret == 1)
				{
								if(subType.equals("1"))
								{
%>
									<script language="JavaScript">
											alert("Viral SMS Enabled")
											window.location="../home.jsp"
									</script>
<%
	  						}
			  else
	  		{
%>
		<script language="JavaScript">
			alert("Viral SMS Disabled")
			window.location="../home.jsp"
		</script>
<%

	  		}
		}
	else
	{
%>
		<script language="JavaScript">
			alert("Try again later")
			window.location="viralsms.jsp"
		</script>
<%
	}
}
%>
