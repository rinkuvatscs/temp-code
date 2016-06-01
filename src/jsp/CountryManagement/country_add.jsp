
<%@ page import ="com.telemune.webadmin.webif.*"  %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if( sessionHistory == null || !sessionHistory.isAllowed(100) )
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
<html>
 <head>
  <title>Country Add </title>

	<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css">
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
		<script type="text/javascript">

			
		function validate()
		{
			var code = document.forms.form.code.value
			var country_name = document.forms.form.country_name.value
			var cc = document.forms.form.cc.value
			var mcc = document.forms.form.mcc.value
			
			if(code =="")
			 {
							 alert("Enter country code field")
							 document.forms.form.code.focus()
							 return false
			 }
			if(country_name =="")
			 {
							 alert("Enter country name field")
							 document.forms.form.country_name.focus()
							 return false
			 }
			if(cc =="")
			 {
							 alert("Enter cc field")
							 document.forms.form.cc.focus()
							 return false
			 }
			if(mcc =="")
			 {
							 alert("Enter mcc field")
							 document.forms.form.mcc.focus()
							 return false
			 }
	
			return true
		}//validate
		</script>
 </head>

<%@ include file = "../pagefile/header.html" %>
			
			<form name="form" action="addCountry.jsp" method="post" onSubmit="return validate()">
		
			<table border="1" cellspacing="0" cellpadding="0" align="center" width="70%">

				<tr> <td colspan="2" class="tableheader"> Country Details <br><br></td></tr>
 
				<tr class="tfields">
					<td width="20%"><sup class="notice">*</sup>Country Code(100 9166-1)</td>
					<td align="left"><input type="text" name="code" size="30" maxlength="4" ></td>
				</tr>	
				<tr class="tfields">
					<td width="30%"><sup class="notice">*</sup>Country Name)</td>
					<td align="left"><input type="text" name="country_name" size="30" ></td>
				</tr>	
				<tr class="tfields">
					<td width="20%"><sup class="notice">*</sup>CC</td>
					<td align="left"><input type="text" name="cc" size="30" onkeypress="return numberOnly(event)" >
									<sup class="notice">* digits (0-9) only</sup></td>
				</tr>	
				<tr class="tfields">
					<td width="20%"><sup class="notice">*</sup>MCC</td>
					<td align="left"><input type="text" name="mcc" size="30" onkeypress="return numberOnly(event)">
									<sup class="notice">* digits (0-9) only</sup></td>
				</tr>	
			</table>
				
			<br><Br>
			
			<table border="1" cellspacing="0" cellpadding="0" align="center" width="70%">
				<tr> <td colspan="2" class="tableheader">Enable/Disable Country for Roamer <br><br></td></tr>
				<tr class="tfields">
					<td width="30%">Inbound Roamer</td>
					<td align="left" height="20"><input type="checkbox" name="inbound" value="A"></td>
				</tr>	
				<tr class="tfields">
					<td width="30%">Outbound Roamer</td>
					<td align="left" height="20"><input type="checkbox" name="outbound"value="A" ></td>
				</tr>	
				<tr>
						<td class="button1" colspan="2"><input type="submit" name="submit" value="ADD"> <input type="reset" name="reset" value="CANCEL"></td>
				</tr>		


			</table>		
	</form>
	
<%@ include file = "../pagefile/footer.html" %>  
	<%
	}
	%>
 
