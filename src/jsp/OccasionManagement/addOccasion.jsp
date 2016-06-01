<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("addOccasion.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(1020))
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
	OccasionManager 	ocManager = new OccasionManager();
          ocManager.setConnectionPool(conPool);
	Occasion ocob = new Occasion();


	ocob.setOccasionName( request.getParameter("occasionName"));
	ocob.setOccasionDate( request.getParameter("occasionDate"));
	ocob.setIsConstant( request.getParameter("occasionConst"));
	ocob.setDescription( request.getParameter("occasionDesc"));

	int i = ocManager.addOccasion(ocob);

	if(i < 0)
	{
		if(i == -2 )
		{

			logger.info("webadmin/OccassionManagement: The Occasion name already exists");
			%>
				<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("aloccalready",defLangId)%>")
				history.go(-1)
				</script>
				<%
		}
		else
			%>
				<script language="JavaScript">
				alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
				window.location="../home.jsp"
				</script>
				<%
	}
	else if(i > 0)
	{
		logger.info("webadmin/OccassionManagement: The Occasion is added Successfully");
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("aloccadded",defLangId)%>!!!")
			window.location="home.jsp"
			</script>
			<%
	}
}

%>
