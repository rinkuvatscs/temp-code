
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
    Logger logger = Logger.getLogger ("corp_add.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2041))
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
		CorpManager corpMan= new CorpManager();
             corpMan.setConnectionPool(conPool);
	ArrayList corpAl = new ArrayList();
	int defaultplan = Integer.parseInt(TSSJavaUtil.instance().getAppConfigParam("DEFAULT_RATE_PLAN"));
	logger.info("Default RATEPLAN= "+defaultplan); 
	int ret = corpMan.getCorpPlanId(corpAl);

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

		<form name="form" method="post" action="addCorp.jsp" onSubmit="return validate()">
		<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
		<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("corpAdd",defLangId)%><br><br> </td></tr>

		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("corpName",defLangId)%> </td>
		<td ><input type="text" name="corpName" maxlength=25 >    </td>
		</tr>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("corpbillingmobile",defLangId)%></td>
		<td ><input type="text" name="msisdn" maxlength=12 onkeypress="return numberOnly(event)">    </td>
		</tr>
		
		<%--
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("billplan",defLangId)%></td>
		<td ><select name="billId" >
		<%
		for(int x=0;x<corpAl.size();x++)
		{
			CorpUser corpUser = (CorpUser) corpAl.get(x);
			int planId = corpUser.getPlanIndicator();
			if(planId== defaultplan)
			{}
			else
			{
				%>
					<option value="<%=planId%>"selected > <%=corpUser.getPlanRemarks()%></option>
					<%
			}
		}
	%>
		</select>
		</td>
		</tr>
		--%>
		<input type="hidden" name="billId" value='<%=TSSJavaUtil.instance().getAppConfigParam("DEFAULT_RATE_PLAN")%>'/>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("login",defLangId)%> </td>
		<td ><input type="text" name="userName" maxlength=10 >    </td>
		</tr>
		<tr> <td></td><td class="notice">   <sup>*</sup><%=TSSJavaUtil.instance().getKeyValue("passwdconditon2",defLangId)%> </td> 		</tr>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("password",defLangId)%></td>
		<td ><input type="password" name="password" maxlength=10 ></td></tr>
		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("confpassword",defLangId)%> </td>
		<td ><input type="password" name="confpassword" maxlength=10>       </td>
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
