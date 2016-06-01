
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("serviceClass_add.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2060))
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
 RbtRatePlanManager ratePlanManager=new RbtRatePlanManager();
         ratePlanManager.setConnectionPool(conPool);
	ArrayList  rateplanAl = new ArrayList();
	ratePlanManager.getRatePlans(rateplanAl);
	int hlrId = -1;
	int i = rateplanAl.size();
	logger.info("RATE PLAN LIST SIZE"+rateplanAl.size());

%>
<html>
<head>
	<script type="text/javascript">
		function validate()
		{
			return validRange()   // check for validity of mobile numbers entered, in Scripts/SunscriberRange.js

  } //validate
		
	</script>
</head>

<%@ include file = "../pagefile/header.html" %>

   <form name="form" method="post" action="addServiceClass.jsp" onsubmit="return validate()">
       <table width="80%" border="0" align="center" cellspacing="2" cellpadding="4">
         <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("serviceclassdefine",defLangId)%><br><br></td></tr>
			<%
			   if ( i < 0 )
					 {
			%>						 
								<tr class="notice">
												  <td colspan="2" align="center"><p> Neccessary Data not Found. <a href="../RatePlans/rateplan_add.jsp">Add Rate Plans</a> First!!!</p> </td>
									 </tr> 	
				
				<%	
				  }
					else
					{
			%>	
				 <tr class="tfield">				 
              <td width="10%">Range </td>
              <td >  <input type="text" name="startat" maxLength="10" onkeypress="return numberOnly(event)">&nbsp;
                  to &nbsp; 
									   <input type="text" name="endsat"maxLength="10"  onkeypress="return numberOnly(event)">
              </td>
				 </tr>			
         <tr class="tfield">
               <td width="20%">Rate Plans</td>
               <td >
										<select name="plan">
<%
						for (i=0; i<rateplanAl.size(); i++)
							{
									RbtRatePlan plan = (RbtRatePlan) rateplanAl.get(i);
%>
											<option value="<%=plan.getPlanId()%>"><%=plan.getRemarks()%></option>
<%
							}
%>
									</select>
							</td>
          </tr>
										
          <tr class="button1">
                <td colspan="2"><br> <input type="submit" name="submit" value="ADD"> <input type="reset" name="clear" value="CLEAR"></td>
          </tr>
				<%
					}  //else
				%>	
        </table>
    </form>
        <script language="javascript">
		<!--
		document.form.startat.focus();
		//-->
	</script>

<%@ include file = "../pagefile/footer.html" %>

<%
	
}
%>
