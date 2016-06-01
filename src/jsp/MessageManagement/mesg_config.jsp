
<%@ page import="com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>
<%@ include file = "../conPool.jsp" %>
<%

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
					MessageMapManager mesgMapManager = new MessageMapManager();
                           mesgMapManager.setConnectionPool(conPool);
					ArrayList mesgConfigAl = new ArrayList();

					int i = mesgMapManager.viewMap(mesgConfigAl,0,-1); // view all values from MessageMapManager
            
					int mapSize = mesgConfigAl.size();
					
					long messageId=0;
					String roamerType="";
					String eventType="";
					String visitType="";
					String mapType="";
					long mapValue=0;
					String startDate="";
					String endDate="";
					String subType="";
					int mesgOrder=-1;
					String deliCriteria="";
					String deliOrder="";
					 

%>

<html>

<head>
 <title> MessageMap Management </title>

 <link rel="stylesheet" href="../pagefile/webadmin_style.css" type="text/css">
 <META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset-iso=8859-1">

 </head>

 <%@ include file="../pagefile/header.html"%>

	<table border="1" cellpadding="0" cellspacing="0" width="70%" align="center">
	 <tr class="tableheader">
	   <td colspan="13">Message Mapping Configuration<br></td>
	</tr> 
	<tr class="tfields">
	  <td>Roamer Type</td>
		<td>Message Sent on</td>
		<td>Roamin Visit Type</td>
		<td>Message Destination</td>
		<td>Destination number</td>
		<td>Start Date</td>	
		<td>End Date</td>
		<td> Subscriber	Type</td>
		<td>Message Ordering</td>
		<td>Message Delivery Criteria</td>
		<td>Message Delivery Order</td>
		<td>Modify</td>
		<td>Delete</td>
	</tr>
	 <%
          if(i<=0 || mapSize <=0)
					{
	 %>
		<tr><td class="notice" colspan="13" align="center">Message Mapping Configurations not found!!!</td> </tr>	
		<%
          }
					else
					{
									for(int x=0;x<mapSize;x++)
									{
													MessageMap mesgMap = (MessageMap) mesgConfigAl.get(x);
													 messageId  = mesgMap.getMesgId();
                          if(mesgMap.getMesgType() == 1)
														 	{ roamerType ="In Roamer";}
													 else
															{ roamerType ="Out Roamer";}
												
													if(mesgMap.getEventType() == 1)
														 { eventType = "Entry" ;}
													else 
													   { eventType="Exit";}
												
													if(mesgMap.getVisitType() == 1)
														 { visitType = "New" ;}
													else if(mesgMap.getVisitType()==2)
													   { visitType="Repeat";}
													else if(mesgMap.getVisitType()==3)
													   { visitType="Frequent Repeat";}
						/*							else if(mesgMap.getVisitType()==4)
													   { visitType="Repeat & Frequent Repeat";}
													else if(mesgMap.getVisitType()==5)
													   { visitType="Any";}
						*/
						              if(mesgMap.getMapType()==1)
															{ mapType ="IMSI";}
						              else if(mesgMap.getMapType()==2)
															{ mapType ="MSISDN";}
						              else if(mesgMap.getMapType()==3)
															{ mapType ="MNC";}
						              else if(mesgMap.getMapType()==4)
															{ mapType ="NDC";}
						              else if(mesgMap.getMapType()==5)
															{ mapType ="NW Group Id";}
						              else if(mesgMap.getMapType()==6)
															{ mapType ="MCC";}
						              else if(mesgMap.getMapType()==7)
															{ mapType ="CC";}
						              else if(mesgMap.getMapType()==8)
															{ mapType ="VLR Number";}
						              else if(mesgMap.getMapType()==9)
															{ mapType ="Default";}
											 
												  mapValue = mesgMap.getMapValue();
                          startDate  = mesgMap.getStartDate();
													endDate = mesgMap.getEndDate();
													mesgOrder = mesgMap.getMesgOrder();

													if(mesgMap.getSubType()==0)
														{ subType="Not Applicable";}
													else if(mesgMap.getSubType()==1)
														{ subType="Prepaid";}
													else if(mesgMap.getSubType()==2)
														{ subType="Postpaid";}
                           
													if(mesgMap.getDeliveryCriteria().equals("AL"))
														{ deliCriteria ="Always";}
													else if(mesgMap.getDeliveryCriteria().equals("NF"))
														{ deliCriteria ="When Not Found";}
													else if(mesgMap.getDeliveryCriteria().equals("NA"))
														{ deliCriteria ="Not Applicable";}


													if(mesgMap.getDeliveryOrder().equals("NA")|| mesgMap.getDeliveryOrder().equals("N") )
														{ deliOrder ="Not Applicable";}
													else if(mesgMap.getDeliveryOrder().equals("B"))
														{ deliOrder ="Before";}
													else if(mesgMap.getDeliveryOrder().equals("A"))
														{ deliOrder ="After";}

													
		%>
		<tr class="tabledata_center">
		  <td><%=roamerType%></td>
      <td><%=eventType%></td>
			<td><%=visitType%></td>
			<td><%=mapType%></td>
			<td><%=mapValue%></tD>
			<td><%=startDate%></td>
			<td><%=endDate%></td>
			<tD><%=subType%></td>
			<td><%=mesgOrder%></td>
			<td><%=deliCriteria%></td>
			<td><%=deliOrder%></td>
		  <td><a href="mesg_modify.jsp?messageId=<%=messageId%>&mesgType=<%=roamerType%>">Modify</a></td>	
		  <td><a href="mesg_modify_delete.jsp?id=del&messageId=<%=messageId%>">Delete</a></td>	
		</tr>
		<%
									}
					}
		%>
			

 </table>	

 <%@ include file="../pagefile/footer.html"%>


 <%
	}
	%>
