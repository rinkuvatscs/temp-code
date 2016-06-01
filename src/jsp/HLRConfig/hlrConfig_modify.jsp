
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(281))
	{
          %>
            <%@ include file ="logouterror.jsp" %>
               <%
                   session.invalidate();
                      request.getSession(true).setAttribute("lang",defLangId);
         }
	else
	{
		HLRManager hlrManager = new HLRManager();
          hlrManager.setConnectionPool(conPool);
		HLR hlr = new HLR();
		ArrayList hlrConfigAl = new ArrayList();
		int hlrId=Integer.parseInt(request.getParameter("id"));
		
		int i = hlrManager.getHLRConfig(hlrConfigAl, hlrId);
		
%>
<HTML>
<HEAD>
<script type="text/javascript">
	function validate()
	{
					var  ip = document.forms.form.serverip.value = document.forms.form.serverip.value.trim()
					var  port = document.forms.form.serverport.value = document.forms.form.serverport.value.trim()
					var  login = document.forms.form.login.value
					var  password = document.forms.form.password.value
					var  numofconallow = document.forms.form.numofconallow.value = document.forms.form.numofconallow.value.trim()
					var ValidChars = "0123456789.";
					var ValidChars1 = "0123456789";
					var Char;
					if(ip =="")
					{
									alert("Please enter Server IP address ")
													document.forms.form.serverip.focus()
													return false
					}
					if(port =="")
					{
									alert("Please enter the Port No. ")
													document.forms.form.serverport.focus()
													return false
					}
					if(login =="")
					{
									alert("Please enter the login name")
													document.forms.form.login.focus()
													return false
					}
					if(/[^A-Za-z0-9_]/.test(login))
					{
									alert("Login name contains some illegal character, Use A-Z a-z 0-9");
									document.forms.form.login.focus();
									return false;
					}
					if(password =="")
					{
									alert("Please enter the password")
													document.forms.form.password.focus()
													return false
					}
					if(/[^A-Za-z0-9_]/.test(password))
					{
									alert("password contains some illegal character, Use A-Z a-z 0-9");
									document.forms.form.password.focus();
									return false;
					}
					if( numofconallow=="")
					{
									alert("Please enter number of simultaneous connections allowed")
													document.forms.form.numofconallow.focus()
													return false
					}
					for (i = 0; i < ip.length ; i++)
					{
									Char = ip.charAt(i);
									if (ValidChars.indexOf(Char) == -1)
									{
													alert("IP Address should contain only digits 0-9 & . ")
																	return false
									}
					}
					for (i = 0; i < port.length ; i++)
					{
									Char = port.charAt(i);
									if (ValidChars1.indexOf(Char) == -1)
									{
													alert("Port Number should contain only digits ")
																	return false
									}
					}
					for (i = 0; i < numofconallow.length ; i++)
					{
									Char = numofconallow.charAt(i);
									if (ValidChars1.indexOf(Char) == -1)
									{
													alert(" Number of Simultaneous Connections should contain only digits ")
																	return false
									}
					}
					return true;
	}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

    <form name="form" method="post" action="modifyHLR.jsp?id=<%=hlrId%>" onSubmit="return validate()">
        <table width="80%" border="0" cellpadding="2" cellspacing="4" align="center">
        <tr class="tableheader"<td colspan="2">HLR Configuration - Modify<br><br> </td></tr>
         <%
				 if( i < 0 || hlrConfigAl.size() <= 0)
				 {
				 %>
				 <tr class="notice"><td colspan="2">There is some Error, Please Try Later.</td></tr>
				 <%
				 }
				 else
				 {
								 for(int k = 0; k< hlrConfigAl.size(); k++)
								 {
												 hlr = (HLR) hlrConfigAl.get(k);
				 %>
        <tr class="tfield">
            <td width="30%" >Name </td>
            <td ><input type="text" name="username" value = "<%=hlr.getHLRName()%>" disabled>  </td>
        </tr>
				<tr class="tfield">
							<td width="30%" >Server IP </td>
							<td ><input type="text" name="serverip" value = "<%=hlr.getHLRIp()%>" maxlength="15" onkeypress="return ipCheck(event)" >
<input type="hidden" name="old_serverip" value = "<%=hlr.getHLRIp()%>">
 </td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Server Port </td>
							<td ><input type="text" name="serverport" value = "<%=hlr.getHLRPort()%>" maxlength="6" onkeypress="return numberOnly(event)">
<input type="hidden" name="old_serverport" value = "<%=hlr.getHLRPort()%>">
	</td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Login </td>
							<td ><input type="text" name="login" value = "<%=hlr.getLogin()%>" maxlength="20">
<input type="hidden" name="old_login" value = "<%=hlr.getLogin()%>">
</td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Password </td>
							<td ><input type="password" name="password" value = "<%=hlr.getPassword()%>" maxlength="20">
<input type="hidden" name="old_password" value = "<%=hlr.getPassword()%>">
	</td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Number of Simultaneous Connections Allowed </td>
							<td ><input type="text" name="numofconallow" value = "<%=hlr.getConnection()%>" maxlength="5" onkeypress="return numberOnly(event)">
<input type="hidden" name="old_numofconallow" value = "<%=hlr.getConnection()%>">
	</td>
				</tr>
				<tr class="button1">
							<td colspan="2">  <input type="submit" name="submit" value="Submit"><input type="reset" name="clear" value="Clear"></td>
				</tr>
		  <%
								 } //for
			  }//else
			%>	 
        </table>
      </form>
        <script language="JavaScript">
		<!--
		document.form.password.focus();
		//-->
	</script>

<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
