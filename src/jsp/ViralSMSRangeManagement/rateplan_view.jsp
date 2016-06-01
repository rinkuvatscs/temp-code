
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if (sessionHistory == null || !sessionHistory.isAllowed(2056)) 
		{
         %>
          <%@ include file ="../logouterror.jsp" %>
            <%
              session.invalidate();
                 request.getSession(true).setAttribute("lang",defLangId);
                  }

    else
    {
								int planId=0;
								planId =Integer.parseInt(request.getParameter("planId"));
				RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();		
                        rbtrateManager.setConnectionPool(conPool); 
				RbtRatePlan rbtrateplan  = new RbtRatePlan();		 
				int m = rbtrateManager.viewRatePlan(rbtrateplan,planId);
        
%>
<HTML>
<HEAD>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

         <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5" name ="table1" id="table1" style="display:block;">
				    <tr class="tableheader"><td colspan="2"> Crbt Rate Plan Management - View Rate Plan <br><br> </td></tr>
												<tr class="tfield">
              <td >Plan Indicator </td>
              <td > <%=planId%>  </td>
            </tr>

					       <tr class="tfield">
              <td >Crbt Charge Code </td>
              <td > <%=rbtrateplan.getRbtChgCode()%>  </td>
            </tr>
												<tr class="tfield">
              <td >Gift Charge Code </td>
              <td ><%=rbtrateplan.getRbtGiftChgCode()%> </td>
            </tr>
												<tr class="tfield">
              <td >Monotone Charge Code </td>
              <td ><%=rbtrateplan.getRbtMonoChgCode()%>  </td>
            </tr>
													<tr class="tfield">
              <td >Crbt No Charge Code </td>
              <td ><%=rbtrateplan.getRbtNoChgCode()%>  </td>
            </tr>
												<tr class="tfield">
              <td >Crbt Normal Charge Code </td>
              <td ><%=rbtrateplan.getRbtNormalChgCode()%>   </td>
            </tr>
	<tr class="tfield">
              <td >Subscription Charge Code</td>
              <td > <%=rbtrateplan.getSubChgCode()%>  </td>
            </tr>
	<tr class="tfield">
              <td >Crbt Recorded Charge Code</td>
              <td > <%=rbtrateplan.getRbtRecChgCode()%>  </td>
            </tr>
													<tr class="tfield">
              <td >Remark</td>
              <td >
                <%=rbtrateplan.getRemarks()%>
              </td>
            </tr>

	<tr class="tfield">
              <td >Monthly Rent Code </td>
              <td ><%=rbtrateplan.getMRentCode()%>  </td>
            </tr>
	<tr class="tfield">
              <td >Three Week Rent Code </td>
              <td > <%=rbtrateplan.getThreeWeek()%> </td>
            </tr>
	<tr class="tfield">
              <td >Two Week Rent Code </td>
              <td > <%=rbtrateplan.getTwoWeek()%> </td>
            </tr>
<tr class="tfield">
              <td >One Week Rent Code </td>
              <td ><%=rbtrateplan.getOneWeek()%>  </td>
            </tr>
           
			<% 			} %>			
        </table>
<tr class="homemenu"><td></td><td><a href="rateplan_manage.jsp?pid=0&keywords=PLAN_INDICATOR&srchtext=X&order=ASC&searchId=0">Back</a></td></tr>

<%@ include file = "../pagefile/footer.html" %>

