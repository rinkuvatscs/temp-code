<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("alertModify.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
	session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
//			String url = response.encodeRedirectURL("../logouterror.jsp");
//			response.sendRedirect(url);
}
else
{

   SubGroupManager subGroupManager = new SubGroupManager();
  subGroupManager.setConnectionPool(conPool);
	 SubGroup subGroup = new SubGroup();

	 int i = -1;
	 

  String id = request.getParameter("id");

	long grpId=Long.parseLong( request.getParameter("grpId") );
  subGroup.setGrpName( request.getParameter("grpName") );			
	subGroup.setGrpId(grpId);

   
	  if(id.equals("del") )
		{
				logger.info("webadmin/SubGroupManager: delete Alerts: SubGroup Category= "+grpId);
				i = subGroupManager.delSubGroup(subGroup);
		}
		else if(id.equals("mod") )
		{
				logger.info("webadmin/SubGroupManager: modify Alerts: SubGroup Category= "+grpId);
				
						 subGroup.setStartMsisdn( request.getParameter("startMsisdn")) ;
						 subGroup.setEndMsisdn( request.getParameter("endMsisdn")) ;
						 
						 i = subGroupManager.modifySubGroup(subGroup);    
		
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





