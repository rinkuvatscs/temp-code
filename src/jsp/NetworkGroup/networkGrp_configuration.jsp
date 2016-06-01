
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
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
				NetworkGroupManager networkGrpManager = new NetworkGroupManager();
                    networkGrpManager.setConnectionPool(conPool);
				ArrayList networkGrpAl = new ArrayList();

				int i = networkGrpManager.viewNetworkGrp(networkGrpAl,"x",-99);
				
				long grpId = 0;
%>
<HTML>
<HEAD>
<TITLE>Network Group Management </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

</HEAD>
<%@ include file = "../pagefile/header.html" %>
     

			<table width="95%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		     <tr><td colspan="16" class="tableheader"> Network Group Configuration <br><br> </td></tr>
   					<tr class="tfields">
						 <td width="15%">Network Group Name</td>
						 <td width="30%">Network Group Description</td>
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
						if (networkGrpAl.size() <= 0 )
						{
				 %>
				 	<tr class="notice"><td colspan="16" align="center"><br>Network Group Configuration not Available<br></td></tr>
				 <%}
				  else
					{
						for(int z=0;z<networkGrpAl.size();z++)
						{
									NetworkGroup network_config = (NetworkGroup) networkGrpAl.get(z);
									grpId = 	network_config.getNetworkId();
								
					%>
					<tr class="tabledata_center">
						<input type="hidden" name="grpid" value="<%=grpId %>" >
						<td align="left"><%=network_config.getName() %>     </td>
						<td align="left"><%=network_config.getDesc() %>     </td>
						<td><%=network_config.getInbound() %>     </td>
						<td><%=network_config.getWaitInterval_In() %>     </td>
						<td><%=network_config.getRepInterval_In() %>     </td>
						<td><%=network_config.getMaxMesg_Time() %>     </td>
						<td><%=network_config.getTime_MaxMesg() %>     </td>
						<td><%=network_config.getOneTime_Mesg() %>     </td>
						<td><%=network_config.getOutbound() %>     </td>
						<td><%=network_config.getWaitInterval_Out() %>     </td>
						<td><%=network_config.getRepInterval_Out() %>     </td>
						<td><%=network_config.getSleep() %></td>
						<td><%=network_config.getSleep_Start_hr()%>:<%=network_config.getSleep_Start_min()%></td>
						<td><%=network_config.getSleep_End_hr()%>:<%=network_config.getSleep_End_min()%></td>
	  	      <td><a href="networkGrp_modify.jsp?name=<%=network_config.getName()%>&grpId=<%=grpId%>">Modify</a>   </td>
		  			<td><a href="networkGrp_modify_delete.jsp?id=del&name=<%=network_config.getName()%>&grpId=<%=grpId%>">Delete</a>  </td>
					</tr>


		 	<%
						}//for
					}//else
			%>
	 </table>

			 
<%@ include file = "../pagefile/footer.html" %>  

<% } %>
	












				
