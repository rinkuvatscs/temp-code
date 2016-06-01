
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("deleteCorp.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null ||  !sessionHistory.isAllowed(2043) )
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

	CorpManager corpManager = new CorpManager();
         corpManager.setConnectionPool(conPool);
	String Arr[] = (String []) request.getParameterValues("delCorp");
	ArrayList corpArr = new ArrayList(); 
	for(int x=0;x<Arr.length;x++)
	{
	logger.info("***to delete corpid= "+Arr[x]);
		corpArr.add(Arr[x]);
	}
	int i = corpManager.deleteCorpData(corpArr);

	if(i <0)
	{
		logger.info("webadmin/CorpManager: corporate cannot be deleted");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alnotdelcorp",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
	else if(i==1)
	{
		logger.info("webadmin/CorpManager: Corporates deleted successfully");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alcorpdel",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>
