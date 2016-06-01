
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(282))
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

	<script type="text/javascript">
	function validate()
	{
					var  name = document.forms.form.name.value = document.forms.form.name.value.trim()
									var  ip = document.forms.form.serverip.value = document.forms.form.serverip.value.trim()
									var  port = document.forms.form.serverport.value = document.forms.form.serverport.value.trim()
									var  login = document.forms.form.login.value
									var  password = document.forms.form.password.value
									var  numofconallow = document.forms.form.numofconallow.value = document.forms.form.numofconallow.value.trim()
									var ValidChars = "0123456789.";
					var ValidChars1 = "0123456789";
					var Char;
					if(name =="")
					{
									alert("Please enter a name ")
													document.forms.form.name.focus()
													return false
					}
					if(ip =="" )
					{
									alert("Enter Proper Server IP address ")
													document.forms.form.serverip.focus()
													return false
					}
					if(port =="")
					{
									alert("Please enter the Port No.")
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
									alert("Please enter maximum number of simultaneous connections allowed")
													document.forms.form.numofconallow.focus()
													return false
					}
					for (i = 0; i < ip.length ; i++)
					{
									Char = ip.charAt(i);
									if (ValidChars.indexOf(Char) == -1)
									{
													alert("Error! IP Address should contain only digits 0-9 & . ")
																	return false
									}
					}
					for (i = 0; i < port.length ; i++)
					{
									Char = port.charAt(i);
									if (ValidChars1.indexOf(Char) == -1)
									{
													alert("Error! Port Number should contain only digits ")
																	return false
									}
					}
					for (i = 0; i < numofconallow.length ; i++)
					{
									Char = numofconallow.charAt(i);
									if (ValidChars1.indexOf(Char) == -1)
									{
													alert("Error! Number of Simultaneous Connections should contain only digits ")
																	return false
									}
					}
					return true;
	}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
	    
	  <form name="form" method="post" action="addHLR.jsp" onSubmit="return validate()">
		
        <table width="80%" border="0" cellpadding="2" cellspacing="4" align="center">
				  <tr><td class="tableheader" colspan="2">HLR Configuration - Add<br> </td></tr>
					<tr class="tfield" >
							<td width="30%" >HLR Name </td>
							<td ><input type="text" name="name" maxlength="20">        </td>
					</tr>
					<tr class="tfield">
							<td width="30%"  >Server IP </td>
							<td ><input type="text" name="serverip" maxlength="15" onkeypress="return ipCheck(event)">  </td>
					</tr>
					<tr class="tfield">
							<td width="30%" >Server Port </td>
							<td ><input type="text" name="serverport" maxlength="6" onkeypress="return numberOnly(event)">   </td>
					</tr>
					<tr class="tfield">
							<td width="30%" >Login </td>
							<td ><input type="text" name="login" maxlength="20">    </td>
					</tr>
					<tr class="tfield">
							<td width="30%" >Password </td>
							<td ><input type="password" name="password" maxlength="20">   </td>
					</tr>
					<tr class="tfield">
							<td width="30%" >Number of Simultaneous Connections Allowed </td>
							<td ><input type="text" name="numofconallow" maxlength="5" onkeypress="return numberOnly(event)">   </td>
					</tr>
					<tr class="button1">
							<td colspan="2" >	<input type="submit" name="submit" value="Save Changes"><input type="reset" name="clear" value="Clear"></td>
					</tr>
					
       </table>
    
		 </form>
        <script language="JavaScript">
		<!--
		document.form.name.focus();
		//-->
	</script>

<%@ include file = "../pagefile/footer.html" %>  
<%
	}

%>
