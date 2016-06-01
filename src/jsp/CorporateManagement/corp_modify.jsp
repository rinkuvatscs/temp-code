<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2042))
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
	     long corpId= Long.parseLong(request.getParameter("corpId"));  
			 String corpName=request.getParameter("corpname");
			 
       int defaultplan = Integer.parseInt(TSSJavaUtil.instance().getAppConfigParam("DEFAULT_RATE_PLAN"));
			CorpManager corpMan = new CorpManager();
             corpMan.setConnectionPool(conPool);
			ArrayList corpAl = new ArrayList();
			ArrayList corp1Al = new ArrayList();

			int ret = corpMan.getCorporateData(corpAl,corpId, corpName);
			int ret1 = corpMan.getCorpPlanId(corp1Al);
      
%>
<html>
<head>

<script type="text/javascript">
  function validate()
	{
									var corpName = document.forms.form.corpName.value = document.forms.form.corpName.value.trim()
									var msisdn = document.forms.form.msisdn.value = document.forms.form.msisdn.value.trim()
									var userName = document.forms.form.userName.value = document.forms.form.userName.value.trim()
									var password = document.forms.form.password.value = document.forms.form.password.value.trim()
									var confpassword = document.forms.form.confpassword.value = document.forms.form.confpassword.value.trim()
								
								if(corpName=="")
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alentcorp",defLangId)%>")
																	return false
									}
								if(msisdn=="")
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alentbillnum",defLangId)%>")
																	return false
									}
									else if(userName=="")
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alentusr",defLangId)%>")
																	return false
									}
									else if(userName==corpName)
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alnottouse",defLangId)%>")
																	return false
									}
									else if(password=="" || password.length < 5 || password.length > 10 )
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alpass510",defLangId)%>")
																	document.forms.form.password.value = ""
																	document.forms.form.confpassword.value=""
																	document.forms.form.password.focus()
																	return false
									}
									else if(confpassword==""|| confpassword.length < 5 || confpassword.length >10 )
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alentconfpass",defLangId)%>")
																	document.forms.form.password.value = ""
																	document.forms.form.confpassword.value=""
																	document.forms.form.password.focus()
																	return false
									}
									else if (password.length != confpassword.length)
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("alnotsame",defLangId)%>")
																	document.forms.form.password.value = ""
																	document.forms.form.confpassword.value=""
																	document.forms.form.password.focus()
																	return false
									}
									else
									{
													for(i = 0; i < password.length ; i++)
													{
																	if (password.charAt(i) != confpassword.charAt(i))
																	{
																					alert("<%=TSSJavaUtil.instance().getKeyValue("alnotsame",defLangId)%>")
																									return false
																	}
													}
									}

					return true
	}
</script>

</head>

<%@ include file ="../pagefile/header.html" %>

    <form name="form" method="post" action="updateCorp.jsp?corpId=<%=corpId%>" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
          <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("corpmodify",defLangId)%><br><br> </td></tr>

          <%
					       for(int x= 0; x<corpAl.size();x++)
								 {
								     CorpUser corpUser = (CorpUser) corpAl.get(x);
					%>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("corpName",defLangId)%> </td>
             <td ><%=corpUser.getCorpName()%>  </td>
             <input type="hidden" name="corpName" value="<%=corpUser.getCorpName()%>">
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("corpbillingmobile",defLangId)%></td>
             <td ><input type="text" name="msisdn" maxlength=12 onkeypress="return numberOnly(event)" value="<%=corpUser.getChargingMsisdn()%>"> 
<input type="hidden" name="old_msisdn" value="<%=corpUser.getChargingMsisdn()%>">
   </td>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("login",defLangId)%> </td>
             <td ><%=corpUser.getUserName()%> </td>
             <input type="hidden" name="userName" value="<%=corpUser.getUserName()%>">
          </tr>
<input type="hidden" name="old_planName" value="<%=corpUser.getPlanIndicator()%>">
<input type="hidden" name="planName" value="<%=corpUser.getPlanIndicator()%>">

	<%--
         	<tr class="tfield">

             <td ><%=TSSJavaUtil.instance().getKeyValue("billplan",defLangId)%></td>
             <td ><select name="planName" >
								 <%
								  for(int k=0;k<corp1Al.size();k++)
										{
														CorpUser corpUser1 = (CorpUser) corp1Al.get(k);
														int planId = corpUser1.getPlanIndicator();
														if(planId== defaultplan)
														{}
														else
														{
                                                                                                                System.out.println("corp name "+corpUser.getPlanRemarks());
 
																		%>
																						<option value="<%=planId%>" <% if(planId== corpUser.getPlanIndicator()){%>selected<%}%> > <%=corpUser.getPlanRemarks()%></option>
																						<%
														}
										}
									%>
								</select>
						 </td>
          </tr>
	--%>

        <!--  <tr class="tfield">
             <td >Billing Plan </td>
             <td ><input type="text" name="planName" maxlength=10 value="<%=corpUser.getPlanIndicator()%>" readonly>    </td>
             <input type="hidden" name="planName" value="<%=corpUser.getPlanIndicator()%>">
          </tr>
				-->	
	  			<tr> <td></td><td class="notice">   <sup>*</sup><%=TSSJavaUtil.instance().getKeyValue("passwdconditon2",defLangId)%>   </td> 		</tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("password",defLangId)%></td>
             <td ><input type="password" name="password" maxlength=10 value="<%=corpUser.getPassword()%>"></td>
<input type="hidden" name="old_password" value="<%=corpUser.getPassword()%>">
</tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("confpassword",defLangId)%> </td>
             <td ><input type="password" name="confpassword" maxlength=10 value="<%=corpUser.getPassword()%>">       </td>
          </tr>
				<%
				     }
						%> 
				  <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
%>
