   
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.SessionHistory" %>
<%@ page import = "com.telemune.webadmin.webif.TSSJavaUtil" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if(sessionHistory == null || !sessionHistory.isAllowed(740))
{
    %>
     <%@ include file ="../logouterror.jsp" %>
       <%
         session.invalidate();
            request.getSession(true).setAttribute("lang",defLangId);
             }

else
{
	String user      = sessionHistory.getUser();
%>
 <%@ include file="../lang.jsp" %>

<HTML>
<HEAD>

<script Javascript>

function validate()
{
				var opass = document.forms.form.oldpass.value
				var pass1 = document.forms.form.newpass.value
				var pass2 = document.forms.form.newpass1.value

				if(opass == "")
				{
							
						alert("<%=TSSJavaUtil.instance().getKeyValue("type_old_password",defLangId)%>")
							return false
				}

				if(pass1 == "")
				{
								
					alert("<%=TSSJavaUtil.instance().getKeyValue("type_new_password",defLangId)%>")
								return false
				}

				if(pass2 == "")
				{
								//alert("Please retype the new password")
						alert("<%=TSSJavaUtil.instance().getKeyValue("retype_password",defLangId)%>")
								return false
				}

				if ( pass1 != pass2 )
				{
								//alert("Please retype the new password again")
						alert("<%=TSSJavaUtil.instance().getKeyValue("retype_new_password_again",defLangId)%>")
								return false
				}

}

</script>


</HEAD>
 
<%@ include file = "../pagefile/header.html" %>
	<form name="form" method="post" action="changePassword.jsp" onSubmit=" return validate()"> 
		<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4"> 
		  <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("cpTop",defLangId)%> <br><br></td></tr>
	    <tr class="notice"><td colspan="2"><sup>#</sup><%=TSSJavaUtil.instance().getKeyValue("cpHead",defLangId)%> "<%=user.toUpperCase()%>"<br></td></tr>
			<tr class="tfield1">
					<td><%=TSSJavaUtil.instance().getKeyValue("cpOld",defLangId)%>	</td>
					<td > <input type="password" name="oldpass" maxlength=15> </td>
			</tr>
			<tr class="tfield1">
					<td ><%=TSSJavaUtil.instance().getKeyValue("cpNew",defLangId)%> </td>
					<td > <input type="password" name="newpass" maxlength=15> </td>
			</tr>
			<tr class="tfield1">
				<td ><%=TSSJavaUtil.instance().getKeyValue("cpRetype",defLangId)%> </td>
				<td > <input type="password" name="newpass1" maxlength=15> </td>
			</tr>
			<tr class="button1"> 
					<td colspan="2"><br>
								<input type="submit" name="ChangePassword" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> 
								<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%>"> 
					</td>
			</tr> 
		</table>
	</form>

	
<%@ include file = "../pagefile/footer.html" %>

<%
	}
%>



