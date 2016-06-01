
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if (sessionHistory == null || !sessionHistory.isAllowed(2072)) 
		{
    %>
     <%@ include file ="../logouterror.jsp" %>
       <%
         session.invalidate();
            request.getSession(true).setAttribute("lang",defLangId);
    }
    else
{   
								RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();
                       rbtrateManager.setConnectionPool(conPool);		 
								RbtRatePlan rbtrateplan  = new RbtRatePlan();		 
								RbtRatePlan rbtrateplan1= new RbtRatePlan();		 
								ArrayList chargecode= new ArrayList();
								int planID =Integer.parseInt(request.getParameter("planId"));
								String values="";	
								int m = rbtrateManager.getRowCodeModify(chargecode,rbtrateplan,planID);
								String hiddeString="";
								int hiddeint=-1;

								%>
																<HTML>
																<HEAD>
																<script type="text/javascript">
																function validate() 
																{
																								if(document.form.crbtchg.value == "Select")
																								{
																																alert("Please select Crbt Charge Code");
																																document.form.crbtchg.focus();
																																return false;
																								}
																								if(document.form.giftchg.value == "Select")
																								{
																																alert("Please select Gift Charge Code");
																																document.form.giftchg.focus();
																																return false;
																								}
																							/*	if(document.form.monotonechg.value == "Select")
																								{
																																alert("Please select Monotone Charge Code");
																																document.form.monotonechg.focus();
																																return false;
																								}
																								if(document.form.nochg.value == "Select")
																								{
																																alert("Please select Crbt No Charge Code");
																																document.form.nochg.focus();
																																return false;
																								}*/
																								if(document.form.normalchg.value == "Select")
																								{
																																alert("Please select Crbt Normal Charge Code");
																																document.form.normalchg.focus();
																																return false;
																								}
																								if(document.form.subchg.value == "Select")
																								{
																																alert("Please select Subscription Charge Code");
																																document.form.subchg.focus();
																																return false;
																								}
																						/*		if(document.form.recordedchg.value == "Select")
																								{
																																alert("Please select Crbt Recorded Charge Code");
																																document.form.recordedchg.focus();
																																return false;
																								}*/
																								var x = document.form.remark.value = document.form.remark.value.trim();
																								if(x == "")
																								{
																																alert("The Remark is Missing");
																																document.form.remark.focus();
																																return false;
																								}
																								if(document.form.monthlychg.value == "Select")
																								{
																																alert("Please select Monthly Rent Code");
																																document.form.monthlychg.focus();
																																return false;
																								}
																								if(document.form.threechg.value == "Select")
																								{
																																alert("Please select Three Week Rent Code");
																																document.form.threechg.focus();
																																return false;
																								}
																								if(document.form.twochg.value == "Select")
																								{
																																alert("Please select Two Week Rent Code");
																																document.form.twochg.focus();
																																return false;
																								}
																								if(document.form.onechg.value == "Select")
																								{
																																alert("Please select One Week Rent Code");
																																document.form.onechg.focus();
																																return false;
																								}
																								return true
																}
								</script>
																</HEAD>

                                                                                                                                 <%@ include file="../lang.jsp" %>
																<%@ include file = "../pagefile/header.html" %>

																<form name="form" method="post" action="rateplanmodify.jsp" onSubmit="return validate()" >
																								<input type=hidden name="pid" value="<%=planID%>">
														
																<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5" name ="table1" id="table1" style="display:block;">
																<tr class="tableheader"><td colspan="2"> Crbt Rate Plan Management - Modify Rate Plan <br><br> </td></tr>
																<tr class="tfield">
																<td >Crbt Charge Code </td>
																<td >  <select name="crbtchg" style="width:250px" >
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%		hiddeString=rbtrateplan1.getRbtChgCode()+"";	
            													}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%>                
																</select>
																	<input type="hidden" name="old_crbtchg" value="<%=hiddeString%>">
																</td>
																</tr>
																<tr class="tfield">
																<td >Gift Charge Code </td>
																<td >  <select name="giftchg" style="width:250px" >
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtGiftChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%	
																								hiddeString=rbtrateplan1.getRbtChgCode()+"";											
                                     				}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%>                
																</select>
<input type="hidden" name="old_giftchg" value="<%=hiddeString%>">
																</td>
																</tr>
														<!--		<tr class="tfield">
																<td >Monotone Charge Code </td>
																<td >  <select name="monotonechg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtMonoChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%																}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
																</td>
																</tr>
																<tr class="tfield">
																<td >Crbt No Charge Code </td>
																<td >  <select name="nochg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtNoChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%																}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 


																</select>
																</td>
																</tr>-->
																<tr class="tfield">
																<td >Crbt Normal Charge Code </td>
																<td >  <select name="normalchg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtNormalChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%			
hiddeString=rbtrateplan1.getRbtChgCode()+"";
													}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
<input type="hidden" name="old_normalchg" value="<%=hiddeString%>">
																</td>
																</tr>
																<tr class="tfield">
																<td >Subscription Charge Code</td>
																<td >  <select name="subchg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getSubChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%	
hiddeString=rbtrateplan1.getRbtChgCode()+"";
															}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
<input type="hidden" name="old_subchg" value="<%=hiddeString%>">
																</td>
																</tr>
														<!--		<tr class="tfield">
																<td >Crbt Recorded Charge Code</td>
																<td >  <select name="recordedchg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getRbtRecChgCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%																}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 


																</select>
																</td>
																</tr>-->
																<tr class="tfield">
																<td >Remark</td>
																<td >
																<TEXTAREA NAME="remark" id="remark" COLS=20 ROWS=2 ><%=rbtrateplan.getRemarks()%> </TEXTAREA>
																<input type="hidden" name="old_remark" value="<%=rbtrateplan.getRemarks()%>">
																</td>
																</tr>

																<tr class="tfield">
																<td >Monthly Rent Code </td>
																<td >  <select name="monthlychg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getMRentCode()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%						
hiddeString=rbtrateplan1.getRbtChgCode()+"";
										}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
<input type="hidden" name="old_monthlychg" value="<%=hiddeString%>">
																</td>
																</tr>
																<tr class="tfield">
																<td >Three Week Rent Code </td>
																<td >  <select name="threechg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getThreeWeek()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%		
hiddeString=rbtrateplan1.getRbtChgCode()+"";
														}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 


																</select>
<input type="hidden" name="old_threechg" value="<%=hiddeString%>">
																</td>
																</tr>
																<tr class="tfield">
																<td >Two Week Rent Code </td>
																<td >  <select name="twochg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getTwoWeek()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%						
hiddeString=rbtrateplan1.getRbtChgCode()+"";
										}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
<input type="hidden" name="old_twochg" value="<%=hiddeString%>">
																</td>
																</tr>
																<tr class="tfield">
																<td >One Week Rent Code </td>
																<td >  <select name="onechg" style="width:250px">
																<option value="Select">Select Code</option>
																<%            
																for(int j	=	0;	j	<	chargecode.size()	;	j++)
																{
																								rbtrateplan1 = (RbtRatePlan) chargecode.get(j);
																								if(rbtrateplan1.getRbtChgCode().equals(rbtrateplan.getOneWeek()))
																								{%>
																																<option value="<%=rbtrateplan1.getRbtChgCode()%>" selected ><%=rbtrateplan1.getDesc()%></option>

																																								<%			
hiddeString=rbtrateplan1.getRbtChgCode()+"";
													}
																								else
																								{	
																																%>
																																								<option value="<%=rbtrateplan1.getRbtChgCode()%>" ><%=rbtrateplan1.getDesc()%></option>
																																								<%
																								}
																}
								%> 

																</select>
<input type="hidden" name="old_onechg" value="<%=hiddeString%>">
																</td>
																</tr>

																<tr class="button1">
																<td colspan="2" align="left"><br> <input type="submit" name="submit" value="Modify" > <input type="reset" name="Clear" value="Clear"> </td>
																</tr>

																</table>

																<tr class="homemenu"><td></td><td><a href="rateplan_manage.jsp?pid=0&keywords=PLAN_INDICATOR&srchtext=X&order=ASC&searchId=0">Back</a></td></tr>
																</form>

																<%@ include file = "../pagefile/footer.html" %>
																<%
}
%>

