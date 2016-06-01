
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2063))
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
		String strRangeIdArr[] = (String [])request.getParameterValues("rangeid");
		int rangeIdArr[] = new int[strRangeIdArr.length];
	
		for(int j=0;j <strRangeIdArr.length;j++)
		{
			rangeIdArr[j] = Integer.parseInt(strRangeIdArr[j]);
		}
	
		int i = serviceManager.deletePrePost(rangeIdArr);
		
		if(i < 0)
		{
						%>
										<script language="JavaScript">
										alert("Error!!! Try Again")
										window.location="../home.jsp"
										</script>
										<%
		}
		else
		{
						%>
										<script language="JavaScript">
										alert("Deletion Successful!!!")
										window.location="home.jsp"
										</script>
										<%
		}
}
%>
