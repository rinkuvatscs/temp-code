
<%@ page import="com.telemune.webadmin.webif.*"%>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("network_modify_delete.jsp");
   SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	 if(sessionHistory ==null || !sessionHistory.isAllowed(100) )
	 {
        %>
         <%@ include file ="../logouterror.jsp" %>
           <%
             session.invalidate();
                request.getSession(true).setAttribute("lang",defLangId);
        }
	 else
	 {
					 NetworkMasterManager networkManager = new NetworkMasterManager();
                      networkManager.setConnectionPool(conPool);
					 NetworkMaster networkMaster = new NetworkMaster();
           int i=-1;
					String id  = request.getParameter("id");
							
							networkMaster.setNetworkName( request.getParameter("name") );
							networkMaster.setNetworkId( Long.parseLong( request.getParameter("networkId")) );
			
		if(id.equals("del") )  //delete from NetworkMasterManager
				{
   						logger.info("webadmin/NetworkMasterManager: delete NetworkMasterManager");
							i = networkManager.delNetwork(networkMaster);
				}
		else if(id.equals("mod")) //modify this NetworkMasterManager
				{
					networkMaster.setBrandName( request.getParameter("brandName") );
					networkMaster.setMnc( Integer.parseInt( request.getParameter("mnc")) );
					networkMaster.setMcc( Integer.parseInt( request.getParameter("mcc")) );
					networkMaster.setNetworkType( request.getParameter("networkType") );
					networkMaster.setTimeZone(Integer.parseInt ( request.getParameter("timeZone") ) );
				
					networkMaster.setDefaultLang( request.getParameter("defaultLang")) ;
					networkMaster.setEnableTest( Integer.parseInt( request.getParameter("enableTest") ));
				  networkMaster.setVisitInterval_in ( Integer.parseInt( request.getParameter ("visitInterval_In") ))	;
				  networkMaster.setRepInterval_in( Integer.parseInt( request.getParameter ("repInterval_In") ))	;
				  networkMaster.setVisitInterval_out( Integer.parseInt( request.getParameter ("visitInterval_Out") ))	;
				  networkMaster.setRepInterval_out(Integer.parseInt( request.getParameter ("repInterval_Out") ))	;
					networkMaster.setTimeMaxMesg( Integer.parseInt( request.getParameter("timeMaxMesg"))) ;
					networkMaster.setMaxMesgTime( Integer.parseInt( request.getParameter("maxMesgTime"))) ;
					networkMaster.setMaxMesgOneTime( Integer.parseInt( request.getParameter("maxMesgOneTime"))) ;
				
					String inbound  =  request.getParameter("inbound") ;
					  if(inbound == null) inbound="N";
							networkMaster.setInbound(inbound);
						
					String outbound  =  request.getParameter("outbound") ;
						if(outbound == null) outbound="N";
							networkMaster.setOutbound(outbound);
		
		  int sleep = -1; //for  sleepEnable	Integer
			int sleepStartHr = -1;	
			int sleepStartMin = -1;	
			int sleepEndHr = -1;	
			int sleepEndMin = -1;	
					
				String	sleepEnable =   request.getParameter("sleepEnable")  ;
				 if(sleepEnable != null)
				 {			 	
					sleep = 1;  //enable sleep period
					sleepStartHr = Integer.parseInt( request.getParameter("sleepStartHr"));
					sleepStartMin = Integer.parseInt( request.getParameter("sleepStartMin"));
					sleepEndHr = Integer.parseInt( request.getParameter("sleepEndHr"));
					sleepEndMin = Integer.parseInt( request.getParameter("sleepEndMin"));
					
					networkMaster.setSleepStartHr(sleepStartHr);
					networkMaster.setSleepStartMin(sleepStartMin);
					networkMaster.setSleepEndHr(sleepEndHr);
					networkMaster.setSleepEndMin(sleepEndMin);
				 }
				else if(sleepEnable == null)
				 {
						sleep = 0 ;  //enable sleep period;
/*						sleepStartHr = 0;
							sleepStartMin = 0;
							sleepEndHr = 0;
							sleepEndMin = 0;
*/							
				 }

					 networkMaster.setSleepEnable(sleep);
	
						logger.info("webadmin/NetworkMasterManager: modify NetworkMasterManager");
						i = networkManager.modifyNetwork(networkMaster);

		} //else modify

				
	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("Network Master modified successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("Network Master Deleted successfully!!")
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

									
									

