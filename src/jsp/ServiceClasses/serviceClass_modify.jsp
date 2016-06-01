
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2061))
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
  ArrayList serviceDetailAl = new ArrayList();
  ServiceClassManager serviceManager = new ServiceClassManager();
  serviceManager.setConnectionPool(conPool);
	 ServiceClass  serviceDetail = new ServiceClass();
		RbtRatePlanManager ratePlanManager=new RbtRatePlanManager();
         ratePlanManager.setConnectionPool(conPool);
	int rangeId = Integer.parseInt(request.getParameter("rangeid"));
		int i = serviceManager.getServiceClass(serviceDetailAl,rangeId);
	Iterator ite = serviceDetailAl.iterator();
	while(ite.hasNext())
	{
		serviceDetail = (ServiceClass) ite.next();
		if( serviceDetail.getRangeId() == rangeId )
		{
						break;
		}
	}
	ArrayList  rateplanAl = new ArrayList();
  ratePlanManager.getRatePlans(rateplanAl);
	int plan_id = -1;
	int j=rateplanAl.size();
%>

<html>
<head>
<script language="javascript">
	function validate()
		{
			return validRange()  // checks for validity of MSISDN, in Scripts/SubscriberRange.js
		}
</script>
</head>

<%@ include file = "../pagefile/header.html" %>

    <form name="form" method="post" action="modifyServiceClass.jsp?rangeid=<%=rangeId%>"  onSubmit="return validate()" >
		
       <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
         <tr class="tableheader"><td colspan="2">Service Class Management - Modify<br><br> </td></tr>
         <%
												if ( j < 0 )
												{
								%>						 
								
         <tr class="notice">
				      <td colspan="2" align="center"><p> Data not Found. Please try Later !!!</p> </td>
								</tr>			
					
					
			<%
				}	
					else
					{
			%>	
				
			 <tr class="tfield">
              <td >Range</td>
														
              <td><input type="text" name="startat" maxlength="12"value="<%= serviceDetail.getStartsAt()%>" onkeypress="return numberOnly(event)" >
											&nbsp;to
                <input type="text" name="endsat"maxlength="12" value="<%= serviceDetail.getEndsAt()%>">
<input type="hidden" name="old_startval" value="<%= serviceDetail.getStartsAt()%>"> <input type="hidden" name="old_endval" value="<%= serviceDetail.getEndsAt()%>"> <input type="hidden" name="old_planid" value="<%= serviceDetail.getRatePlan()%>">
              </td>
         <tr class="tfield">
               <td width="20%">Rate Plans</td>
               <td >
										<select name="plan">
								 <%
												for (i=0; i<rateplanAl.size(); i++)
												{
																RbtRatePlan plan = (RbtRatePlan) rateplanAl.get(i);
																
								%>
																<option value="<%=plan.getPlanId()%>" <%if( serviceDetail.getRatePlan()==plan.getPlanId()){%>selected <%}%>><%=plan.getRemarks()%></option>
								<%
												}	
								%>
									</select>
							</td>
          </tr>
         </tr>
									
												
            <tr class="button1">
              	<td colspan="2" > <input type="submit" name="submit" value="Submit"> <input type="reset" name="Clear" value="Clear"></td>
            </tr>
			<%
			  	} 
			%>
          </table>
      
			</form>

<%@ include file = "../pagefile/footer.html" %>
<% } %>
