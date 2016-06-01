<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2051) )
{
	%>
		<%@ include file ="../logouterror.jsp" %>
		<%
}
else
{
	%>
	 <%@ include file="../lang.jsp" %>
		<head>
		<script language="javascript">
		function validate()
		{
			var chgName = document.forms.form.crname.value.trim()
				var amtp= document.forms.form.amt_p.value.trim()
				var amto= document.forms.form.amt_o.value.trim()

				if(chgName=="")
				{
					//alert("Please enter Charging Rule Name")
					alert("<%=TSSJavaUtil.instance().getKeyValue("alchgname",defLangId)%>")
						document.forms.form.crname.focus()
						return false
				}
			if(amtp=="")
			{
				//alert("Please enter Charging amount for Prepaid")
				alert("<%=TSSJavaUtil.instance().getKeyValue("alentpre",defLangId)%>")
					document.forms.form.amt_p.focus()
					return false
			}
			if(amto=="")
			{
				//alert("Please enter Charging amount for Postpaid")
				alert("<%=TSSJavaUtil.instance().getKeyValue("alpostamnt",defLangId)%>")
					document.forms.form.amt_o.focus()
					return false
			}
			return true
		}

	</script>
		</head>

		<%@ include file = "../pagefile/header.html" %>
		<form name="form" method="post" action="addRule.jsp" onSubmit="return validate()">
		<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
		<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("crdefinerule",defLangId)%><br><br> </td></tr>


		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("crname",defLangId)%> </td>
		<td ><input type="text" name="crname" maxlength=25 >    </td>
		</tr>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("cramt_p",defLangId)%> </td>
		<td ><input type="text" name="amt_p" maxlength=10 onkeypress="return numberOnly_1(event)" > (amount in cents) </td>
		</tr>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("cramt_o",defLangId)%> </td>
		<td ><input type="text" name="amt_o" maxlength=10 onkeypress="return numberOnly_1(event)" > (amount in cents) </td>
		</tr>
		<tr class="button1">
		<td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
		</tr>

		</table>

		</form>

		<%@ include file = "../pagefile/footer.html" %>
		<%
}
%>
