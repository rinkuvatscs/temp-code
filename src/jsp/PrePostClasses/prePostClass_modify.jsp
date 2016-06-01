
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
  ArrayList serviceDetailAl = new ArrayList();
  PrePostManager serviceManager = new PrePostManager();
   serviceManager.setConnectionPool(conPool);
	 PrePost  serviceDetail = new PrePost();
	int rangeId = Integer.parseInt(request.getParameter("rangeid"));
		int i = serviceManager.getPrePost(serviceDetailAl,rangeId);
	Iterator ite = serviceDetailAl.iterator();
	while(ite.hasNext())
	{
		serviceDetail = (PrePost) ite.next();
		if( serviceDetail.getRangeId() == rangeId )
		{
						break;
		}
	}
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

    <form name="form" method="post" action="modifyprepost.jsp?rangeid=<%=rangeId%>"  onSubmit="return validate()" >
		
       <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
         <tr class="tableheader"><td colspan="2">Service Class Management - Modify<br><br> </td></tr>
				
			 <tr class="tfield">
              <td >Range</td>
              <td><input type="text" name="startat" maxlength="12"value="<%= serviceDetail.getStartsAt()%>" onkeypress="return numberOnly(event)" >
											&nbsp;to
                <input type="text" name="endsat"maxlength="12" value="<%= serviceDetail.getEndsAt()%>">
<input type="hidden" name="old_startval" value="<%= serviceDetail.getStartsAt()%>"><input type="hidden" name="old_endval" value="<%= serviceDetail.getEndsAt()%>"><input type="hidden" name="old_planid" value="<%= serviceDetail.getsub_type()%>">
              </td>
         <tr class="tfield">
               <td width="20%">Subscriber Type</td>
               <td >
										<select name="plan">
										
											<option value="N" <% if(serviceDetail.getsub_type().equals("N")){%>selected<%}%>>None</option>
											<option value="P" <% if(serviceDetail.getsub_type().equals("P")){%>selected<%}%>>Prepaid</option>
											<option value="O" <% if(serviceDetail.getsub_type().equals("O")){%>selected<%}%>>Postpaid</option>
											<option value="H" <% if(serviceDetail.getsub_type().equals("H")){%>selected<%}%>>Hybrid Postpaid</option>
									</select>
							</td>
          </tr>
         </tr>
									
												
            <tr class="button1">
              	<td colspan="2" > <input type="submit" name="submit" value="Submit"> <input type="reset" name="Clear" value="Clear"></td>
            </tr>
          </table>
      
			</form>

<%@ include file = "../pagefile/footer.html" %>
<% } %>
