
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
    	 <table width="80%" border="0" align="center" cellpadding="3" cellspacing="3">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(313))
	{
       %>
        <%@ include file ="../logouterror.jsp" %>
          <%
            session.invalidate();
               request.getSession(true).setAttribute("lang",defLangId);
       }
	else
	{
			IMSIManager imsiManager = new IMSIManager();
             imsiManager.setConnectionPool(conPool);		
			IMSI imsi = new IMSI();
			String imsiId = request.getParameter("id");
			ArrayList imsiConfigAl = new ArrayList();
			int i = imsiManager.getIMSIConfig(imsiConfigAl,imsiId);

%>
<html>
<head>
<script language="JavaScript" src="../Scripts/UtilityFunc.js" type="text/javascript"> </script>
<script type="text/javascript">
function validate()
{
	var  start = document.forms.form.startat.value = document.forms.form.startat.value.trim()
	var  end = document.forms.form.endsat.value = document.forms.form.endsat.value.trim()
	var ValidChars = "0123456789";
	if(start =="")
	{
		alert("Please enter starting IMSI")
		document.forms.form.startat.focus()
		return false
	}
	if(end =="")
	{
		alert("Please enter ending IMSI")
		document.forms.form.endsat.focus()
		return false
	}
	if(/[^0-9]/.test(start))
	{
		alert("Start number contains some illegal character, use 0-9");
		document.forms.form.startat.focus();
		return false;
	}
	if(/[^0-9]/.test(end))
	{
		alert("End number contains some illegal character, use 0-9");
		document.forms.form.endsat.focus();
		return false;
	}
	if (parseInt(start) >= parseInt(end))
	{
		alert("End number should be greater than start number");
		document.forms.form.endsat.focus();
		return false;
	}
	return true;
}
</script>
</head>

<%@ include file = "../pagefile/header.html" %>
      
  <form name="form" method="post" action="modifyIMSI.jsp?id=<%=imsiId%>" onSubmit="return validate()">
     <table width="70%" border="1" align="center">
        <tr class="tableheader"<td colspan="2">IMSI Configuration - Modify </td></tr>
        <tr class="tfield">
          <td width="20%">Id </td>
          <td ><input type="text" name="Id" value = "<%=imsiId%>" disabled>       </td>
        </tr>
				<%
					for(int x=0;x<imsiConfigAl.size();x++)
					{
									imsi = (IMSI) imsiConfigAl.get(x);
				%>
        <tr class="tfield">
          <td >Range</td>
          <td width="80%">	<input type="text" name="startat" value="<%=imsi.getStartAt()%>" maxlength="15" onkeypress="return numberOnly(event)">
<input type="hidden" name="old_startat" value="<%=imsi.getStartAt()%>">
															to
														<input type="text" name="endsat"  value="<%=imsi.getEndsAt()%>" maxlength="15" onkeypress="return numberOnly(event)">
<input type="hidden" name="old_endsat" value="<%=imsi.getEndsAt()%>">
          </td>
         </tr>
         <tr class="tfield">
           <td>Subscriber Type</td>
<input type="hidden" name="old_subType" value="<%=imsi.getSubscriberType()%>">
           <td width="80%"><select name="subType">
<%
		if (imsi.getSubscriberType().equalsIgnoreCase("P"))
		{
%>
								<option selected value="P">Prepaid</option>
								<option value="O">Postpaid</option>
<%
		}
		else
		{
%>

			<option value="P">Prepaid</option>
			<option selected value="O">Postpaid</option>
<%
		}
%>
		</select>
         </td>
      </tr>
      <tr class="button1">
			    <td colspan="2"><input type="submit" name="submit" value="Submit"> <input type="reset" name="clear" value="Clear"></td>
       </tr>
	<%
	 	} //for
	 %>		 
     </table>
    </form>
        <script language="JavaScript">
		<!--
		document.form.startat.focus();
		//-->
	</script>
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
