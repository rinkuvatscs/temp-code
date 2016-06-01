
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file="../lang.jsp" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2061))
	{
			session.invalidate();
%>
<%@ include file="../logouterror.jsp" %>
<%
	}
	else
	{
				 ServiceClassManager serviceManager	 = new ServiceClassManager();
                   serviceManager.setConnectionPool(conPool);
					ArrayList serviceDetailAl  = new ArrayList();
				 int i = serviceManager.getServiceClass(serviceDetailAl);
				 RbtRatePlanManager ratePlanManager=new RbtRatePlanManager();
                     ratePlanManager.setConnectionPool(conPool);
				 ArrayList  rateplanAl = new ArrayList();
				ratePlanManager.getRatePlans(rateplanAl);	
	
%>


 <%@ include file = "../pagefile/header.html" %>
  
   <form name="form" method="post" action="serviceClass_modify.jsp" >
			 <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
          <tr class="tableheader" ><td colspan="4">Service Class Management - Manage  <br><br></td></tr>
<%
				if ( i < 0 || serviceDetailAl.size() <= 0)
				{
%>
       		 <tr class="notice">
							<td colspan="4" align="center"> <p>No Service Class defined!!! <br> Firstly you <a href="serviceClass_add.jsp"> Add Service Class</a> and then you can Modify Service  Class  </P></td></tr>
<%
				}
        else
				{
%>
          <tr class="tfields" bgcolor="#a5c7d0">
              <td >Range<br> </td>
              <td >Rate Plan<br> </td>
              <td >Modify<br></td>
<%
  int r=0;
	Iterator ite = serviceDetailAl.iterator();
 String remarks="";
	while(ite.hasNext())
	{
		ServiceClass serviceDetail = (ServiceClass)ite.next();
  Iterator it= rateplanAl.iterator();
  while(it.hasNext())
  {
																RbtRatePlan rateplan=(RbtRatePlan)it.next();
																if(rateplan.getPlanId()==serviceDetail.getRatePlan())
																{
																												remarks=rateplan.getRemarks();
																								    break;
																								}
																}

%>
        <tr class="tabledata_center"
									 		 <%if ( (r % 2) == 0){ %><%} else {%> bgcolor="#a5c7c2"<%} r++;%>   >
          <td><%= serviceDetail.getStartsAt() %> - <%=serviceDetail.getEndsAt() %> </td>
              <td align="centre">		<%=remarks%> </td>
          <td>   <input type="radio" name="rangeid" value="<%= serviceDetail.getRangeId()%>" checked > </td>
        </tr>
        <%
	}
%>
        <tr class="button1">
          	<td colspan="4"><br> <input type="submit" name="submit" value="MODIFY"> <input type="reset" name="Clear" value="CLEAR"> </TD>
        </tr>
      </table>
    </form>
<%
	}
%>

<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
