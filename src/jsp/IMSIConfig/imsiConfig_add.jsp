
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(311))
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
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript" SRC="../Scripts/UtilityFunc.js" TYPE="TEXT/JAVASCRIPT"> </SCRIPT>
<script type="text/javascript">
function validate()
{
	var Id = document.forms.form.Id.value = document.forms.form.Id.value.trim()
	var  start = document.forms.form.startat.value = document.forms.form.startat.value.trim()
	var  end = document.forms.form.endsat.value = document.forms.form.endsat.value.trim()
	var ValidChars = "0123456789";
	if(Id =="")
    	{
		alert("Please enter a Id")
		document.forms.form.Id.focus()
		return false
	}
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
 }
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
        
		<form name="form" method="post" action="addIMSI.jsp" onSubmit="return validate()">
    	 <table width="80%" border="0" align="center" cellpadding="3" cellspacing="3">
			    <tr class="tableheader"><td colspan="2"> IMSI Configuration - Add <br><br> </td></tr>
           <tr class="tfield">
              <td >Id </td>
              <td ><input type="text" name="Id" maxlength="5">       </td>
           </tr>
           <tr class="tfield">
              <td >Range</td>
              <td >	<input type="text" name="startat" maxlength="15" onkeypress="return numberOnly(event)">
																to
										<input type="text" name="endsat" maxlength="15" onkeypress="return numberOnly(event)">
              </td>
            </tr>
            <tr class="tfield">
              <td >Subscriber Type </td>
              <td >		<select name="subType">
													<option value="P">Prepaid</option>
													<option value="O">Postpaid</option>
											</select>
              </td>
            </tr>
            <tr class="button1">
              <td colspan="2"><input type="submit" name="submit" value="Save Changes"><input type="reset" name="clear" value="Clear"> </td>
            </tr>
          </table>
        </form>
        <script language="JavaScript">
		<!--
		document.forms.form.Id.focus();
		//-->
	</script>
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
