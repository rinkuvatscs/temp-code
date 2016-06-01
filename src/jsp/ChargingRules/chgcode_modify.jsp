<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2052))
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
	ChargingCodeManager chgManager = new ChargingCodeManager() ;
   chgManager.setConnectionPool(conPool);
	ArrayList chgAl =  new ArrayList();

	long chgCode= Long.parseLong(request.getParameter("chgCode"));
	int val = chgManager.getChargingCode(chgAl, chgCode);     
	%>
<head>
				<script language="javascript">
  function validate()
		{
						var chgName = document.forms.form.crname.value.trim()
										var amtp= document.forms.form.amt_p.value.trim()
										var amto= document.forms.form.amt_o.value.trim()

										if(amtp=="")
										{
														alert("Pleae enter Charging amount for Prepaid")
																		return false
										}
						if(amto=="")
						{
										alert("Pleae enter Charging amount for Postpaid")
														return false
						}
						return true
		}

				</script>
</head>
		<%@ include file = "../pagefile/header.html" %>

		<form name="form" method="post" action="modifyChargingRule.jsp?chgcode=<%=chgCode%>" onSubmit="return validate()">
		<table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">

		<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("crTop",defLangId)%> <br><br></td></tr>
          <%
					       for(int x= 0; x<chgAl.size();x++)
								 {
								     ChargingCode chCode= (ChargingCode) chgAl.get(x);
					%>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("crname",defLangId)%> </td>
             <td ><input type="text" name="crname" value="<%=chCode.getDesc()%>" readonly >    </td>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("cramt_p",defLangId)%> </td>
<input type="hidden" name="old_amt_p" value="<%=chCode.getAmountP()%>">
             <td ><input type="text" name="amt_p" maxlength=10 onkeypress="return numberOnly_1(event)" value="<%=chCode.getAmountP()%>" > (amount in cents) </td>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("cramt_o",defLangId)%> </td>
<input type="hidden" name="old_amt_o" value="<%=chCode.getAmountO()%>" >
             <td ><input type="text" name="amt_o" maxlength=10 onkeypress="return numberOnly_1(event)" value="<%=chCode.getAmountO()%>" > (amount in cents) </td>
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

