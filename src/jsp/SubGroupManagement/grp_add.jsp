
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
<TITLE>Subscriber Group Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

    function validate()
		{
			if(document.forms.form.grpName.value=="")
			{
							alert("Enter Name for Group")
							document.forms.form.grpName.focus()
							return false
			}
	    if(document.forms.form.alertType[1].checked)   //Periodic Alert
			{
					document.forms.form.periodicAlert.focus()
			}
	    if(document.forms.form.alertType[1].checked)
		   {
							if(document.forms.form.periodicAlert.value=="")   //Periodic Alert
			        {
									alert("Enter Time Period (min.)"+'\n'+" After Which Missed Call Alert to Send")		
									document.forms.form.periodicAlert.focus()
									return false
							}
							if(	document.forms.form.periodicAlert.value < 1 || document.forms.form.periodicAlert.value>60) // periodicAlert can be
																																																					 // 1 min to 60 min. 	time
							{
								alert("Time Period can be 1 min. to 60 min. only")
								document.forms.form.periodicAlert.value=""
								document.forms.form.periodicAlert.focus()
								return false

							}
				
			 }
			
			
	    if(document.forms.form.alertType[2].checked)   //Call Alert
			{
					document.forms.form.callAlert.focus()
			}
	    if(document.forms.form.alertType[2].checked && document.forms.form.callAlert.value=="")   //Call Alert
			{
					alert("Enter Number of Calls"+'\n'+" After Which Missed Call Alert to Send")		
					document.forms.form.callAlert.focus()
							return false
			}
					for(count=0;count< document.forms.form.alertType.length;count++)
			{
		     
			    if(document.forms.form.alertType[count].checked)
						{
										
							 			  alert(document.forms.form.alertType[count].value)	
			 			}
			}
			
			return  true;
		}//validate

</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
<form name="form" method="post" action="add.jsp" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2">Add New Subscriber Group</td></tr>
			<tr class="tfields">
			  <td> Group Name</td>
				<td align="left"><input type="text" name="grpName" size="20"></td>
			</tr>
			<tr class="tfields">
			  <td> Description</td>
				<td align="left"><textarea name="desc" rows="5" cols="30" maxLength="100"></textarea></td>
			</tr>
			<tr class="tfields">
			  <td colspan="2"><input type="radio" name="alertType" value="1" checked> Instant Alert</td>
			</tr>
			<tr class="tfields">
			  <td> <input type="radio" name="alertType" value="2"> Periodic Alerts(after a given time in minutes)</td>
				<td> <input type="text" name="periodicAlert" maxlength="2" onkeypress="return numberOnly(event)"></td>
			</tr>
			<tr class="tfields">
			  <td> <input type="radio" name="alertType" value="3"> Alert After Calls (specify no. of calls)</td>
				<td> <input type="text" name="callAlert" maxlength="2" onkeypress="return numberOnly(event)"></td>
			</tr>
			<tr class="tfields">
			  <td colspan="2" >Charging Status: <input type="radio" name="charging" value="1" checked> Enable
						  	 &nbsp;&nbsp;<input type="radio" name="charging" value="0"> Disable</td>
			</tr>
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="SUBMIT"> <input type="reset" name="reset" value="CLEAR">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
 
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%

}

%>
