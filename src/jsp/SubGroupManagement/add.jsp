 <%@ include file = "../conPool.jsp" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("add.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
     %>
      <%@ include file ="../logouterror.jsp" %>
        <%
          session.invalidate();
             request.getSession(true).setAttribute("lang",defLangId);
              }

else
{
        SubGroupManager subGroupManager = new SubGroupManager();
    subGroupManager.setConnectionPool(conPool);
				 SubGroup subGroup = new SubGroup();
				int i=-1;
				int instantAlert	= -1;
				
					subGroup.setGrpName( request.getParameter("grpName").toUpperCase() );	
					subGroup.setDesc( request.getParameter("desc") );	
					subGroup.setCharging( Integer.parseInt( request.getParameter("charging")) );       // 1 - enable charging
					                                                                                   // 0 - disable	
			  int	alertType = Integer.parseInt( request.getParameter("alertType") );
			  logger.info("webadmin/SubGroupManager: alertType= "+alertType);
				 switch (alertType)
					{
                 case 1:
			  									logger.info("alertType:  instantAlert");
								 					instantAlert = 1;
								 					subGroup.setInstantAlert(instantAlert);
													break;
								 case	2:
			  									logger.info("alertType:  periodicAlert");
								          subGroup.setPeriodicAlert( Integer.parseInt(request.getParameter("periodicAlert") ));
													break;
								 case 3:
			  									logger.info("alertType:  callAlert");
								          subGroup.setCallAlert( Integer.parseInt(request.getParameter("callAlert")) ); 				 
													break;
					}
				
					 i = subGroupManager.addSubGroupAlert(subGroup);
				 
				if(i == 0)
				 {
%>
				<script language="JavaScript">
					alert("Subscriber Group with Alert Added successfully!!")
					window.location="home.jsp"
			</script>
<%
		      }
		if (i == -2)
	{
%>
		<script language="JavaScript">
			alert("This Subscriber Group Name already exist, please select different name")
			history.go(-1)
		</script>
<%
	}
	else 
	{
%>
		<script language="JavaScript">
			alert("Error!!! Please try again")
			history.go(-1)
		</script>
<%
	}
}
%>
