
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(122))
	{
		%>
		 <%@ include file ="../logouterror.jsp" %>
		   <%
		    session.invalidate();
		        request.getSession(true).setAttribute("lang",defLangId);
	         }
	
	else
	{
			SmscConfigManager smscConfigManager = new SmscConfigManager();
                      smscConfigManager.setConnectionPool(conPool);
			SmscConfig smscConfig = new SmscConfig();
			ArrayList  smscConfigAl = new ArrayList();
		  int smscId=Integer.parseInt(request.getParameter("id"));
			
			int i = smscConfigManager.getSmscConfig(smscConfigAl, smscId);
		
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
		alert("Enter Proper IP Address ")
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
	
	return true;
 }
</script>
</HEAD>


<%@ include file ="../pagefile/header.html" %>
       
  <form name="form" method="post" action="modifysmsc.jsp?id=<%=smscId%>" onSubmit="return validate()">
  
	    <table width="85%" border="0" cellpadding="2" cellspacing="4" align="center">
        <tr class="tableheader"><td colspan="2">SMSC Configuration - Modify<br><BR> </td></tr>
      <%
			if( i< 0)
			{
			%>
		    <tr> <td class="notice" colspan="2"> There is Some Error.Please Try Later.</td></tr>
     <%
			}
			else if (smscConfigAl.size() <=0)
			{
			%>
		    <tr> <td class="notice" colspan="2"> No SMSC Configuration available!!! Firstly you<a href="smsc_configuration_add.jsp"> Add SMSC Configuration</a> and then Manage SMSC Configuration </td></tr>
     <%
			}
			else
			{
							for(int w =0;w < smscConfigAl.size(); w++)
							{
											smscConfig = (SmscConfig) smscConfigAl.get(w);
		 %>
				<tr class="tfield">
             <td >User Name </td>
             <td ><input type="text" name="username" value = "<%=smscConfig.getUserId()%>">     </td>
												<input type="hidden" name="old_username" value="<%=smscConfig.getUserId()%>">
        </tr>
        <tr class="tfield">
              <td >Password </td>
              <td ><input type="password" name="password" value="<%=smscConfig.getPassword()%>">     </td>
														<input type="hidden" name="old_password" value="<%=smscConfig.getPassword()%>">
        </tr>
        <tr class="tfield">
              <td >Confirm Password </td>
              <td ><input type="password" name="confpassword" value="<%=smscConfig.getPassword()%>">   </td>
        </tr>
        <tr class="tfield">
              <td >Server IP </td>
              <td ><input type="text" name="serverip" value = "<%=smscConfig.getSmscIp()%>" onkeypress="return ipCheck(event)" >    </td>
						<input type="hidden" name="old_serverip" value = "<%=smscConfig.getSmscIp()%>">
        </tr>
        <tr class="tfield">
              <td >Server Port </td>
              <td width="245"><input type="text" name="serverport" value = "<%=smscConfig.getSmscPort()%>" onkeypress="return numberOnly(event)" >
              </td>
															<input type="hidden" name="old_serverport" value = "<%=smscConfig.getSmscPort()%>">
        </tr>
        <tr class="tfield">
              <td >Status </td>
              <td ><SELECT NAME="status" SIZE="1" >
                      <OPTION <% if(smscConfig.getSmscStatus().equals("A")){ %> selected <% } %> >ACTIVATED</OPTION>
                      <OPTION  <% if(smscConfig.getSmscStatus().equals("D")) { %> selected <% } %> >DEACTIVATED</OPTION>
                   </SELECT>
              </td>
													<input type="hidden" name="old_status" value="<%=smscConfig.getSmscStatus()%>">
        </tr>
        <tr class="tfield">
              <td >SMSC Protocol </td>
              <td ><SELECT NAME="protocol" SIZE="1" >
                      <OPTION <% if(smscConfig.getSystemType().equals("SMPP3.4")) { %> selected <% } %> >SMPP3.4</OPTION>
                      <OPTION <% if(smscConfig.getSystemType().equals("CIMD2")) { %> selected <% } %> >CIMD2</OPTION>
                   </SELECT>
              </td>
														<input type="hidden" name="old_protocol" value="<%=smscConfig.getSystemType()%>">
        </tr>
        <tr class="tfield">
              <td >Client Type </td>
              <td ><SELECT NAME="clienttype" SIZE="1" >
                    <OPTION <% if(smscConfig.getClientType().equals("T")) { %> selected <% }%> >TRANSMITTER</OPTION>
                    <OPTION <% if(smscConfig.getClientType().equals("R")) { %> selected <% }%> >RECIEVER</OPTION>
                    <OPTION <% if(smscConfig.getClientType().equals("TR")) { %> selected <% }%> >TRANSRECIEVER</OPTION>
                   </SELECT>
              </td>
													<input type="hidden" name="old_clienttype" value="<%=smscConfig.getClientType()%>">
        </tr>
        <tr class="tfield">
              <td >Address TON </td>
              <td ><input type="text" name="ton" value = "<%=smscConfig.getTon()%>" onkeypress="return numberOnly(event)" >    </td>
														<input type="hidden" name="old_ton" value = "<%=smscConfig.getTon()%>">
        </tr>
        <tr class="tfield">
              <td >Address NPI </td>
              <td ><input type="text" name="npi" value = "<%=smscConfig.getNpi()%>" onkeypress="return numberOnly(event)" > </td>
								<input type="hidden" name="old_npi" value = "<%=smscConfig.getNpi()%>">
        </tr>
        <tr class="tfield">
              <td >Address Range </td>
              <td ><input type="text" name="range" value = "<%=smscConfig.getAddressRange()%>">   </td>
														<input type="hidden" name="old_range" value = "<%=smscConfig.getAddressRange()%>">
        </tr>
        <tr class="tfield">
              <td >Number of Simultaneous Connections Allowed </td>
              <td ><input type="text" name="numofconallow" value = "<%=smscConfig.getNumOfConAllow()%>" onkeypress="return numberOnly(event)" > </td>
														<input type="hidden" name="old_numofconallow" value = "<%=smscConfig.getNumOfConAllow()%>">
        </tr>
        <tr class="tfield">
              <td >Window Size </td>
              <td ><input type="text" name="speed" value = "<%=smscConfig.getSpeed()%>" onkeypress="return numberOnly(event)" > msg/sec  </td>
														<input type="hidden" name="old_speed" value = "<%=smscConfig.getSpeed()%>">
        </tr>
        <tr class="button1">
				      <td colspan="2">
							    <input type="submit" name="submit" value="Save Changes">  <input type="reset" name="clear" value="Clear">
              </td>
        </tr>
      <%
							}  //for
			} //else
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
