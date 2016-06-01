
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
        SubGroupManager subGroupManager = new SubGroupManager();
      subGroupManager.setConnectionPool(conPool);
	      SubGroup subGroup = new SubGroup();
			
				int i=-1;
					subGroup.setGrpName( request.getParameter("grpName") );	
					subGroup.setStartMsisdn( request.getParameter("startMsisdn") );	
					subGroup.setEndMsisdn( request.getParameter("endMsisdn") );	
	
	
						 i = subGroupManager.addSubGroup(subGroup);
				 
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
			alert("This Group Name already present"+'\n'+"Select some other group!!!")
//			alert("This Start MSISDN already exist"+'\n'+"same can not be added again!!!")
			history.go(-1)
		</script>
<%
		}
	if (i == -3)
		{
%>
		<script language="JavaScript">
//		alert("This End MSISDN already exist"+'\n'+"same can not be added again!!!")
//		history.go(-1)
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
