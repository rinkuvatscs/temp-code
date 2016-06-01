<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("modify.jsp");
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

	 int i = -1;
	 

  String id = request.getParameter("id");

	long grpId=Long.parseLong( request.getParameter("grpId") );
  subGroup.setGrpName( request.getParameter("grpName").toUpperCase() );			
	subGroup.setGrpId(grpId);

   
	  if(id.equals("del") )
		{
				i = subGroupManager.delSubGroupAlert(subGroup);
		}
		else if(id.equals("mod") )
		{
				
				int instantAlert	= -1;
					subGroup.setDesc( request.getParameter("desc") );	
					subGroup.setCharging( Integer.parseInt( request.getParameter("charging")) );       // 1 - enable charging
					                                                                                   // 0 - disable	
			  int	alertType = Integer.parseInt( request.getParameter("alertType") );
			  logger.info("webadmin/SubGroupManager: alertType= "+alertType);
				 switch (alertType)
					{
                 case 1:
								 					instantAlert = 1 ;
								 					subGroup.setInstantAlert(instantAlert);
													break;
								 case	2:
								         subGroup.setPeriodicAlert( Integer.parseInt(request.getParameter("periodicAlert") ));
													break;
								 case 3:
								         subGroup.setCallAlert( Integer.parseInt(request.getParameter("callAlert")) ); 				 
													break;
					} 
					
					 i = subGroupManager.modifySubGroupAlert(subGroup);    
		
		}
	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("SubGroup  Details modified successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("SubGroup Details deleted successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			alert("Error!!! Please try again")
			history.go(-1)
		</script>
<%
	}
} //else main
%>





