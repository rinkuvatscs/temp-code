
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
				RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();		
               rbtrateManager.setConnectionPool(conPool); 
				RbtRatePlan rbtrateplan  = new RbtRatePlan();		 
        ArrayList chargecode= new ArrayList();
        //ArrayList packageAl = new ArrayList();
				
				int m = rbtrateManager.getRowCode(chargecode);
//        int n = keywordManager.getPackages(packageAl);
        
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
					/*if(document.form.monotonechg.value == "Select")
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

<%@ include file = "../pagefile/header.html" %>

     <form name="form" method="post" action="setrateplan.jsp" onSubmit="return validate()" >
    <!-- <form name="form" method="post" >-->
         <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5" name ="table1" id="table1" style="display:block;">
				    <tr class="tableheader"><td colspan="2"> Crbt Rate Plan Management - Add Rate Plan <br><br> </td></tr>
<%
            if(m <= 0 ) //Process or package not in existence
            {
%>  
	          <tr class="notice"> <td colspan="2">There is Some Error. Please try Later</td></tr>
<%
						}
					  else if( chargecode.size() <= 0 )
		 				{
%>
	          <tr class="notice"> <td colspan="2">Neccessary Data Not found. Please try Later</td></tr>
<%			    
						} 
						else
						{
%>
					       <tr class="tfield">
              <td >Crbt Charge Code </td>
              <td >  <select name="crbtchg" style="width:250px" >
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
												<tr class="tfield">
              <td >Gift Charge Code </td>
              <td >  <select name="giftchg" style="width:250px" >
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
											<!--	<tr class="tfield">
              <td >Monotone Charge Code </td>
              <td >  <select name="monotonechg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
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
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
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
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
	<tr class="tfield">
              <td >Subscription Charge Code</td>
              <td >  <select name="subchg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
            <!--	<tr class="tfield">
              <td >Crbt Recorded Charge Code</td>
              <td >  <select name="recordedchg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>-->
													<tr class="tfield">
              <td >Remark</td>
              <td >
                <TEXTAREA NAME="remark" id="remark" COLS=20 ROWS=2 ></TEXTAREA>
               <!-- <input type="text" NAME="vperiod" id="vperiod" >-->
              </td>
            </tr>

	<tr class="tfield">
              <td >Monthly Rent Code </td>
              <td >  <select name="monthlychg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
	<tr class="tfield">
              <td >Three Week Rent Code </td>
              <td >  <select name="threechg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
	<tr class="tfield">
              <td >Two Week Rent Code </td>
              <td >  <select name="twochg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>
<tr class="tfield">
              <td >One Week Rent Code </td>
              <td >  <select name="onechg" style="width:250px">
            <option value="Select">Select Code</option>
<%            
            for(int j	=	0;	j	<	chargecode.size()	;	j++)
            {
                rbtrateplan = (RbtRatePlan) chargecode.get(j);
%>
               <option value="<%=rbtrateplan.getChgCode()%>" ><%=rbtrateplan.getDesc()%></option>
<%
            }
%>                
                </select>
              </td>
            </tr>


													
            <tr class="button1">
              <td colspan="2" align="left"><br> <input type="submit" name="submit" value="Add Rate Plan" > <input type="reset" name="Clear" value="Clear"> </td>
     <!--         <td colspan="2" align="left"><br> <input type="button" name="button" value="Add Rate Plan" onclick="javascript:setRatePlan()"> <input type="reset" name="Clear" value="Clear"> </td>-->
            </tr>

			<% 			} %>			
        </table>

						<!--	<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5" name="table2" id="table2" style="display:none;">
        <tr class="tableheader"><td colspan="2"> Crbt Rate Plan Management - Add Rate Plan <br><br><br><br> </td></tr>
								<tr><td class="homemenu" id="result"></td></tr>
								</table>-->
<!--<a href="#" onclick="setTable('table1');return false">Show/Hide Table</a>-->
<tr class="homemenu"><td></td><td><a href="home.jsp">Back</a></td></tr>
    </form>

<%@ include file = "../pagefile/footer.html" %>
<%
    }

%>
			<script type="text/javascript">
								var url = "setrateplan.jsp?crbtchgcode=";
								var http = getHTTPObject(); 
								function handleHttpResponse() 
								{
								    if (http.readyState == 4) 
												{
																if (http.status == 200) 
																{
																								results = http.responseText;
																										setTable('table1');
																										setTable('table2');
																								if(results[0]=="1")
																								{
																																document.getElementById("result").innerHTML="New Rate Plan Add Successfully";
																									//								alert("New Rate Plan Add Successfully");
																								}
																								else
																								{
																																document.getElementById("result").innerHTML="Error!!!  Try Again";
																													//	alert("Error!!!  Try Again");
																								}
																}
												}
								}
								function setRatePlan() 
								{
										url=url+document.form.crbtchg.options[document.form.crbtchg.selectedIndex].value;
										url=url+"&giftchg="+document.form.giftchg.options[document.form.giftchg.selectedIndex].value;
										url=url+"&monotonechg="+document.form.monotonechg.options[document.form.monotonechg.selectedIndex].value;
										url=url+"&nochg="+document.form.nochg.options[document.form.nochg.selectedIndex].value;
										url=url+"&normalchg="+document.form.normalchg.options[document.form.normalchg.selectedIndex].value;
										url=url+"&subchg="+document.form.subchg.options[document.form.subchg.selectedIndex].value;
										url=url+"&recordedchg="+document.form.recordedchg.options[document.form.recordedchg.selectedIndex].value;
										url=url+"&remark="+document.getElementById("remark").value;
										url=url+"&monthlychg="+document.form.monthlychg.options[document.form.monthlychg.selectedIndex].value;
										url=url+"&threechg="+document.form.threechg.options[document.form.threechg.selectedIndex].value;
										url=url+"&twochg="+document.form.twochg.options[document.form.twochg.selectedIndex].value;
										url=url+"&onechg="+document.form.onechg.options[document.form.onechg.selectedIndex].value;
									//alert(url);
												http.open("GET", url , true);
												http.onreadystatechange = handleHttpResponse;
												http.send(null);
								}
					 
								function getHTTPObject() 
								{																																																																																																																												    var xmlhttp;																																																																																																												    	if (window.XMLHttpRequest) 
												{																																																																																																																					        		xmlhttp = new XMLHttpRequest();																																																																																							    } 
												else if (window.ActiveXObject) 
												{																																																																																																																									        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");																																																																			    }																																																																																																																								    return xmlhttp;																																																																																																										}				
			

function setTable(what)
{
			//		alert("hi");
								if(document.getElementById(what).style.display=="none"){
														document.getElementById(what).style.display="block";
						}
						else if(document.getElementById(what).style.display=="block"){
														document.getElementById(what).style.display="none";
						}
}
			</script>
