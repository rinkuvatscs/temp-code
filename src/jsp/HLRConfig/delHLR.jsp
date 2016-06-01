
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(283))
	{
            %>
              <%@ include file ="../logouterror.jsp" %>
                 <%
                     session.invalidate();
                        request.getSession(true).setAttribute("lang",defLangId);
           }
	else
	{
		HLRManager hlrManager = new HLRManager();
          hlrManager.setConnectionPool(conPool);
		ArrayList hlrIdAl = new ArrayList();
		String hlrIdArr[] = (String [])request.getParameterValues("delid");
		
		for(int j = 0; j < hlrIdArr.length; j++)
		{
                    String hlrID = hlrIdArr[j];
                    hlrIdAl.add(hlrID);
		}
		
		int i = hlrManager.deleteHLRConfig(hlrIdAl);
		if (i == 0)
		{
		%>
			<script language="JavaScript">
                            alert("HLR Configuration deleted successfully!!")
                            window.location="home.jsp"
			</script>
<%
		}
		else if(i == -2)
		{
		%>
			<script language="JavaScript">
                            alert("Please delete all subscriber ranges for the HLR")
                            history.go(-1)
			</script>
		<%
		}
		else
		{
		%>
			<script language="JavaScript">
                            alert("Please try again")
                            history.go(-1)
			</script>
		<%
		}
	}
%>
