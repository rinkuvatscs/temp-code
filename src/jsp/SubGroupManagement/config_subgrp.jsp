
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
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
				 ArrayList subGroupAl = new ArrayList();

				 int i = -1;
				 i = subGroupManager.viewSubGroupAlert(subGroupAl, 0);
				 

 %>
<HTML>
<HEAD>
<TITLE>Subscriber Group Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
     
		 <table border="1" width="80%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="8">Subscriber Group Configuration</td></tr>
			<tr class="tfields">
			  <td width="10%">Group Name </td>
			  <td width="20%">Description </td>
			  <td width="8%">Instant Alert </td>
			  <td width="10%">Periodic Alert (in min.) </td>
			  <td width="10%">Calls Alert (after n calls)</td>
			  <td width="5%">Charging</td>
			  <td width="5%">Modify </td>
			  <td width="5%">Delete </td>
      </tr>
			<% 
			       if(i<=0 || subGroupAl.size()<=0)
						 {
			%>
			 <tr class="notice"><td colspan="8">No Subscriber Group Found!!! </tD></tr>
			<%
						 }
						 else
										{
														String charge  = "";
														String instantAlert  = "";
														String periodicAlert="";
														String callAlert = "";
														String desc="";
														for(int x =0;x<subGroupAl.size();x++)
															{
																			subGroup = (SubGroup) subGroupAl.get(x);

																			int charging = subGroup.getCharging();

																			desc=subGroup.getDesc();
																			if(desc==null){desc="---";}
																							
																			
																			if(charging==1){ charge="../images/tick.jpg"; }
																			else if(charging==0){ charge="../images/cross.jpg"; }

																			if(subGroup.getInstantAlert() == 1){instantAlert="../images/tick.jpg";}
																			else if(subGroup.getInstantAlert() == 0){instantAlert="../images/cross.jpg";}

																			periodicAlert = subGroup.getPeriodicAlert()+"";
																		  callAlert = subGroup.getCallAlert()+"";


			%>
			<tr class="tabledata_center">
			  <td align="left"><%=subGroup.getGrpName()%> </td> 	
			  <td align="left"><%=desc%> </td> 	
			  <td valign="middle"><img src="<%=instantAlert%>" border="0"> </td> 	
        		<%
									if( periodicAlert.equals("-5")) 
									{
													 periodicAlert="../images/cross.jpg"; 
						%>
			  <td valign="middle"><img src="<%=periodicAlert%>" border="0"> </td> 	
						<%
									}
									else
									{ 
													periodicAlert= subGroup.getPeriodicAlert()+""; 
						 %>							 
			  <td><%=periodicAlert%> </td> 	
						 <%		}
									if( callAlert.equals("-5"))
									 {
												  callAlert="../images/cross.jpg"; 
							%>
			  <td valign="middle"><img src="<%=callAlert%>" border="0"> </td> 	
						<%			}
									else
									{ 
													callAlert= subGroup.getCallAlert()+""; 
						 %>	
			  <td><%=callAlert%> </td> <%}%>	
			  <td><img src="<%=charge%>" border="0"> </td> 	
			  <td><a href="grp_modify.jsp?grpId=<%=subGroup.getGrpId()%>">Modify</a> </td> 	
			  <td><a href="modify.jsp?grpId=<%=subGroup.getGrpId()%>&id=del&grpName=<%=subGroup.getGrpName()%>">Delete</a> </td> 
			</tr>
			  <%
															}
										}
				%>
		</table>
	        	
<%@ include file = "../pagefile/footer.html" %>
<% 
}
%>	
			
					
