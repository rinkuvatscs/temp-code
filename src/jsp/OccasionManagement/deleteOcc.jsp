
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("deleteOcc.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null ||  !sessionHistory.isAllowed(1023) )
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
		OccasionManager ocManager = new OccasionManager();
             ocManager.setConnectionPool(conPool);


	String Arr[] = (String []) request.getParameterValues("delOcc");
	if(Arr !=null && Arr.length>0)
	{
	ArrayList ocArr = new ArrayList(); 
	for(int x=0;x<Arr.length;x++)
	{
		ocArr.add(Arr[x]);
	}
	int i = ocManager.deleteOccasion(ocArr);

	if(i <0)
	{
		logger.info("webadmin/OccasionManager: occasion cannot be deleted");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
	else if(i==1)
	{
		logger.info("webadmin/OccasionManager: Occassion deleted successfully");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("aloccdel",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
	}
	else
	{
		   logger.info("webadmin/OccasionManager: No any data selected");
		       %>
		        <script language="JavaScript">
			    alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
                        window.location="home.jsp"
                        </script>
			  <%
	}
}
%>
