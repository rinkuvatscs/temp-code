
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(121))
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
	var  password = document.forms.form.password.value = document.forms.form.password.value.trim()
	var  confpassword = document.forms.form.confpassword.value = document.forms.form.confpassword.value.trim()
	var  username = document.forms.form.username.value = document.forms.form.username.value.trim()
	var  ip = document.forms.form.serverip.value = document.forms.form.serverip.value.trim()
	var  port = document.forms.form.serverport.value = document.forms.form.serverport.value.trim()
	var  ton = document.forms.form.ton.value = document.forms.form.ton.value.trim()
	var  npi = document.forms.form.npi.value = document.forms.form.npi.value.trim()
	var  range = document.forms.form.range.value = document.forms.form.range.value.trim()
	var  numofconallow = document.forms.form.numofconallow.value = document.forms.form.numofconallow.value.trim()
	var  speed = document.forms.form.speed.value = document.forms.form.speed.value.trim()
	var ValidChars = "0123456789.";
	var ValidChars1 = "0123456789";
	var Char;
	if(username =="")
    	{
		alert("Error!!! You must enter User Name ")
		document.forms.form.username.focus()
		return false
	}
	if(password =="")
	{
		alert("Error!!! You must enter Password ")
		document.forms.form.password.focus()
		return false
	}
	if(confpassword =="")
	{
		alert("Error!!! You must enter Confirm Password ")
		document.forms.form.confpassword.focus()
		return false
	}
	if(ip =="" || ip.length > 15 )
	{
		alert("Enter Proper IP Address")
		document.forms.form.serverip.focus()
		return false
	}
	if(port =="")
	{
		alert("Error!!! You must enter the Port No. ")
		document.forms.form.serverport.focus()
		return false
	}
	if(ton =="")
    	{
		alert("Error!!! You must Address TON ")
		document.forms.form.ton.focus()
		return false
	}
	if(npi =="")
	{
		alert("Error!!! You must enter Address NPI ")
		document.forms.form.npi.focus()
		return false
	}
	if(range =="")
	{
		alert("Error!!! You must enter Address Range ")
		document.forms.form.range.focus()
		return false
	}
	if( numofconallow=="")
	{
		alert("Error!!! You must enter Number of Simultaneous Connections Allowed")
		document.forms.form.numofconallow.focus()
		return false
	}
	if(speed =="")
	{
		alert("Error!!! You must enter Window Size ")
		document.forms.form.speed.focus()
		return false
	}
	if (password.length != confpassword.length)
	{
		alert("Error!!!! Password and Confirm Password must be same")
		document.forms.form.password.focus()
		return false
	}
	else
	{
		for(i = 0; i < password.length ; i++)
		{
			if (password.charAt(i) != confpassword.charAt(i))
			{
				alert("Error!!!! Password and Confirm Password must be same")
				document.forms.form.password.focus()
				return false
			}
		}
	}
	for (i = 0; i < ip.length ; i++)
	{
		Char = ip.charAt(i);
		if (ValidChars.indexOf(Char) == -1)
		{
			alert("Error!!!! IP Address should contain only digits 0-9 & . ")
			return false
		}
	}
	for (i = 0; i < port.length ; i++)
	{
		Char = port.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Port Number should contain only digits ")
			return false
		}
	}
	for (i = 0; i < ton.length ; i++)
	{
		Char = ton.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Address TON should contain only digits")
			return false
		}
	}
	for (i = 0; i < npi.length ; i++)
	{
		Char = npi.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Address NPI should contain only digits ")
			return false
		}
	}
	for (i = 0; i < range.length ; i++)
	{
		Char = range.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Range should contain only digits ")
			return false
		}
	}
	for (i = 0; i < numofconallow.length ; i++)
    	{
		Char = numofconallow.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Number of Simultaneous Connections should contain only digits ")
			return false
		}
	}
	for (i = 0; i < speed.length ; i++)
	{
		Char = speed.charAt(i);
		if (ValidChars1.indexOf(Char) == -1)
		{
			alert("Error!!!! Window Size should contain only digits ")
			return false
		}
	}
	return true;
 }
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
       
  <form name="form" method="post" action="addsmsc.jsp" onSubmit="return validate()">
	  
		<table width="90%"  border="0" cellspacing="4" cellpadding="2" align="center">
			<tr class="tableheader"><td colspan="2">ADD SMSC Configuration </td></tr>
      <tr class="tfield">
          <td > User Name </td>
          <td > <input type="text" name="username" > </td>
      </tr>
      <tr class="tfield"> 
          <td >Password </td>
          <td ><input type="password" name="password" >         </td>
      </tr>
      <tr class="tfield">
          <td >Confirm Password </td>
          <td> <input type="password" name="confpassword">     </td>
      </tr>
			<tr class="tfield">
					<td> Server IP</td>
					<td> <input type="text" name="serverip" onkeypress="return ipCheck(event)" >     </td>
			</tr>
			<tr class="tfield">
					<td >Server Port </td>
					<td ><input type="text" name="serverport" onkeypress="return numberOnly(event)" ></td>
			</tr>
			<tr class="tfield">
					<td >Status </td>
					<td><SELECT NAME="status" SIZE="1" >
								<OPTION>ACTIVATED</OPTION>
								<OPTION>DEACTIVATED</OPTION>
						</SELECT>
					</td>
			</tr>
			<tr class="tfield">
					<td>SMSC Protocol </td>
					<td><SELECT NAME="protocol" SIZE="1" >
									<OPTION>SMPP3.4</OPTION>
									<OPTION>CIMD2</OPTION>
							</SELECT>
					</td>
			</tr>
			<tr class="tfield">
					<td >Client Type </td>
					<td><SELECT NAME="clienttype" SIZE="1" >
									<OPTION>TRANSMITTER</OPTION>
									<OPTION>RECIEVER</OPTION>
									<OPTION>TRANSRECIEVER</OPTION>
							</SELECT>
					</td>	
			</tr>
			<tr class="tfield">
					<td >Address TON </td>
					<td><input type="text" name="ton"onkeypress="return numberOnly(event)"  >	</td>
			</tr>
			<tr class="tfield">
					<td >Address NPI </td>
					<td><input type="text" name="npi"onkeypress="return numberOnly(event)"  >		</td>
			</tr>
			<tr class="tfield">
					<td>Address Range </td>
					<td><input type="text" name="range" >		</td>
			</tr>
			<tr class="tfield">
					<td >Number of Simultaneous Connections Allowed </td>
					<td ><input type="text" name="numofconallow"onkeypress="return numberOnly(event)"  >	</td>
			</tr>
			<tr class="tfield">
					<td >Window Size </td>
					<td ><input type="text" name="speed"onkeypress="return numberOnly(event)"  >&nbsp; msg/sec  </td>
			</tr>
			<tr class="tfield">
					<td colspan="2">&nbsp;</td>
			</tr>
			<tr class="button1">
					<td colspan="2"><input type="submit" name="submit" value="Save Changes">		<input type="reset" name="clear" value="Clear">	</td>
			</tr>
	  </table>
	</form>
			<script language="JavaScript">
			<!--
			document.form.username.focus();
			//-->
			</script>
					
			
			<%@ include file = "../pagefile/footer.html" %>
			<%
			}

%>
