
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("networkGrp_modify_delete.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory==null || !sessionHistory.isAllowed(100) )
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
		NetworkGroupManager networkGrpManager = new NetworkGroupManager();
          networkGrpManager.setConnectionPool(conPool);
		NetworkGroup networkgrp = new NetworkGroup();
				int i  = -1;

	  String id = request.getParameter("id");
	
			networkgrp.setNetworkId( Long.parseLong(request.getParameter("grpId") ));	
			networkgrp.setName( request.getParameter("name") );	
		
		if(id.equals("del")) //delete NetworkGrp
			{
				logger.info("webadmin/NetworkGroup: delete NetworkGrp");	
				 i = networkGrpManager.delNetworkGrp(networkgrp);
			}
	 else	if(id.equals("mod"))  //modify NetworkGrp
			{
			networkgrp.setDesc( request.getParameter("desc") );	
			networkgrp.setWaitInterval_In( Integer.parseInt(request.getParameter("waitInterval_In")) );	
			networkgrp.setWaitInterval_Out( Integer.parseInt(request.getParameter("waitInterval_Out")) );	
			networkgrp.setRepInterval_In( Integer.parseInt(request.getParameter("repInterval_In")) );	
			networkgrp.setRepInterval_Out( Integer.parseInt(request.getParameter("repInterval_Out")) );	
			networkgrp.setMaxMesg_Time( Integer.parseInt(request.getParameter("MaxMesg_Time")) );	
			networkgrp.setTime_MaxMesg( Integer.parseInt(request.getParameter("time_MaxMesg")) );	
			networkgrp.setOneTime_Mesg( Integer.parseInt(request.getParameter("oneTime_Mesg")) );	
	
			String inbound = request.getParameter("inbound");			
			String outbound = request.getParameter("outbound");			
			
			int sleep = -1;
			int sleep_Start_hr = -1;	
			int sleep_Start_min = -1;	
			int sleep_End_hr = -1;	
			int sleep_End_min = -1;	
	
			String sleep_enable =  request.getParameter("sleep_enable") ;	
			if(sleep_enable != null)
			{
						sleep = 1; //enable sleep	
		     sleep_Start_hr = Integer.parseInt(request.getParameter("sleep_Start_hr") );	
		     sleep_Start_min =  Integer.parseInt(request.getParameter("sleep_Start_min") ) ;	
	  	   sleep_End_hr = Integer.parseInt(request.getParameter("sleep_End_hr") );	
	   	   sleep_End_min =  Integer.parseInt(request.getParameter("sleep_End_min") ) ;
				 	
					networkgrp.setSleep_Start_hr(sleep_Start_hr);	
	 				networkgrp.setSleep_Start_min(sleep_Start_min);	
					networkgrp.setSleep_End_hr(sleep_End_hr);	
	 				networkgrp.setSleep_End_min(sleep_End_min);	
			}
			else if(sleep_enable == null)
			{
							sleep = 0;  // disable sleep 
/*							sleep_Start_hr = 0;
							sleep_Start_min = 0;
							sleep_End_hr = 0;
							sleep_End_min = 0;
*/							
			}

					networkgrp.setSleep(sleep);
			
			if ( inbound == null ) inbound = "N";			
			if ( outbound == null ) outbound = "N";			

			networkgrp.setInbound(inbound);
			networkgrp.setOutbound(outbound);
				logger.info("webadmin/NetworkGroup: modifying NetworkGrp");	
				 i = networkGrpManager.modifyNetworkGrp(networkgrp);
			}

	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
		
			 alert(<%=TSSJavaUtil.instance().getKeyValue("Network_Group_",defLangId)%>)
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
                             alert(<%=TSSJavaUtil.instance().getKeyValue("Network_Group!",defLangId)%>)
			
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
                   alert(<%=TSSJavaUtil.instance().getKeyValue("try_again",defLangId)%>)
		
			history.go(-1)
		</script>
<%
	}
}
%>

