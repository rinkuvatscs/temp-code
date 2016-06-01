
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(123))
	{
	 %>
	  <%@ include file ="../logouterror.jsp" %>
	    <%
	      session.invalidate();
	         request.getSession(true).setAttribute("lang",defLangId);
	          }

	else
	{
	SmscConfigManager smscConfigManager = new SmscConfigManager();	
             smscConfigManager.setConnectionPool(conPool);
		ArrayList smscIdAl = new ArrayList();
		String smscIdArr[] = (String [])request.getParameterValues("delid");
		
		for(int j = 0; j < smscIdArr.length; j++)
		{
                    String smscID = smscIdArr[j];
                    smscIdAl.add(smscID);
		}
		int i = smscConfigManager.deleteSMSC(smscIdAl);
		if(i < 0)
		{
		%>
			<script language="JavaScript">
                            alert("Error!!! Please try again")
                            history.go(-1)
			</script>
		<%
		}
		else
		{
		%>
			<script language="JavaScript">
                            alert("SMSC Configuration deleted successfully!!")
                            window.location="home.jsp"
			</script>
<%
		}
	}
%>
