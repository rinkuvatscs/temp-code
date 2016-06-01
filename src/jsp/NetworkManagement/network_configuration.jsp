
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("network_configuration.jsp");
 
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
				NetworkMasterManager networkManager = new NetworkMasterManager();
              networkManager.setConnectionPool(conPool);
				TimeZoneManager timeZoneManager = new TimeZoneManager();
			      timeZoneManager.setConnectionPool(conPool);	
			 	ArrayList networkMasterAl = new ArrayList();
				ArrayList timeZoneAl = new ArrayList();
				int timeZone= 0;
				String zoneName ="";
				int i = networkManager.viewNetwork(networkMasterAl,"x",-99); //show all networks  viewNetwork(ArrayList ,String name,long networkId)
	
				long networkId = 0;
%>
<HTML>
<HEAD>
<TITLE>Network Management </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

</HEAD>
<%@ include file = "../pagefile/header.html" %>
     

			<table width="95%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		     <tr><td colspan="23" class="tableheader"> Network Master Configuration <br><br> </td></tr>
   					<tr class="tfields">
						 <td width="15%">Network Name</td>
						 <td width="30%">Brand Name </td>
						 <td width="8%">MNC </td>
						 <td width="8%">MCC </td>
						 <td width="8%">Network Type </td>
						 <td width="10%">Time Zone </td>
						 <td width="10%">Default Language </td>
						 <td width="10%">Enable Test </td>
						 <td width="5%">Inbound Roamer</td>
						 <td width="8%"> New Visit/Wait Interval (hr)</td>
						 <td width="8%">Repetition Interval (min)</td>
						 <td width="8%">Time Period for Max. Message (days)</td> 
						 <td width="8%"> Max Message in Time Period</td>
						 <td width="8%"> Max. Message in One Time</td>
						 <td width="8%"> Outbound Roamer</td>
						 <td width="8%"> New Visit/Wait Interval (hr)</td>
						 <td width="8%"> Repetition Interval (min)</td>
						 <td width="8%"> Sleep Enable</td>
						 <td width="8%"> Sleep Start Time (hh:min)</td>
						 <td width="8%"> Sleep End Time (hh:min)</td>
						 <td>Modify </td>
						 <td>Delete </td>
					</tr> 
				 <%
						if (networkMasterAl.size() <= 0 )
						{
				 %>
				 	<tr class="notice"><td colspan="23" align="center"><br>Network Master Details not Available </td></tr>
				 <%}
				  else
					{
						for(int z=0;z<networkMasterAl.size();z++)
						{
									NetworkMaster network_config = (NetworkMaster) networkMasterAl.get(z);
									networkId = 	network_config.getNetworkId();
								
					%>
					<tr class="tabledata_center">
						<input type="hidden" name="networkId" value="<%=networkId %>" >
						<td align="left"><%=network_config.getNetworkName() %>     </td>
						<td align="left"><%=network_config.getBrandName() %>     </td>
						<td ><%=network_config.getMnc() %>     </td>
						<td ><%=network_config.getMcc() %>     </td>
						<td ><%=network_config.getNetworkType() %>     </td>
    
		 <%
		 				 timeZone = network_config.getTimeZone();
						 
						int x = timeZoneManager.viewTimeZone(timeZoneAl,timeZone);
						  
							 for (int w=0;w<timeZoneAl.size();w++)
								{
												TimeZones timeZone_config = (TimeZones) timeZoneAl.get(w);
												 
												 if (timeZone_config.getTimeZone() == timeZone )
												 {
															zoneName = timeZone_config.getZoneName();
												 }
												 else
												 {
																 zoneName = "x";
																 logger.info("webadmin/TimeZones: Zone Name not found");
												 }
								}
		 %>				
						<td ><%=zoneName %>     </td>
						<td align="left"><%=network_config.getDefaultLang() %>     </td>
						<td ><%=network_config.getEnableTest() %>     </td>

						<td><%=network_config.getInbound() %>     </td>
						<td><%=network_config.getVisitInterval_in() %>     </td>
						<td><%=network_config.getRepInterval_in() %>     </td>
						<td><%=network_config.getTimeMaxMesg() %>     </td>
						<td><%=network_config.getMaxMesgTime() %>     </td>
						<td><%=network_config.getMaxMesgOneTime() %>     </td>
						<td><%=network_config.getOutbound() %>     </td>
						<td><%=network_config.getVisitInterval_out() %>     </td>
						<td><%=network_config.getRepInterval_out() %>     </td>
						<td><%=network_config.getSleepEnable() %></td>
						<td><%=network_config.getSleepStartHr()%>:<%=network_config.getSleepStartMin()%></td>
						<td><%=network_config.getSleepEndHr()%>:<%=network_config.getSleepEndMin()%></td>
	  	      <td><a href="network_modify.jsp?name=<%=network_config.getNetworkName()%>&networkId=<%=networkId%>">Modify</a>   </td>
		  			<td><a href="network_modify_delete.jsp?id=del&name=<%=network_config.getNetworkName()%>&networkId=<%=networkId%>">Delete</a>  </td>
					</tr>


		 	<%
						}//for
					}//else
			%>
	 </table>

			 
<%@ include file = "../pagefile/footer.html" %>  

<% } %>
	








