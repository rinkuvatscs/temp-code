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
<TITLE>Network Group - Add</TITLE>
<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

		function validate()
		{
			var name = document.forms.form.name.value
			var desc = document.forms.form.desc.value
			var waitInterval_In = document.forms.form.waitInterval_In.value
			var repInterval_In = document.forms.form.repInterval_In.value
			var waitInterval_Out = document.forms.form.waitInterval_Out.value
			var repInterval_Out = document.forms.form.repInterval_Out.value
		  var time_MaxMesg = document.forms.form.time_MaxMesg.value
			var MaxMesg_Time = document.forms.form.MaxMesg_Time.value
			var oneTime_Mesg = document.forms.form.oneTime_Mesg.value
			var sleep_Start_hr = document.forms.form.sleep_Start_hr.value
			var sleep_Start_min = document.forms.form.sleep_Start_min.value
			var sleep_End_hr = document.forms.form.sleep_End_hr.value
			var sleep_End_min = document.forms.form.sleep_End_min.value

			if(name =="")
			 {
							 alert("Enter Network Name ")
							 document.forms.form.name.focus()
							 return false
			 }
			if(desc =="")
			 {
							 alert("Enter Network Description")
							 document.forms.form.desc.focus()
							 return false
			 }
			if(waitInterval_In =="")
			 {
							 alert("Enter New Wait Interval for Inroamer")
							 document.forms.form.waitInterval_In.focus()
							 return false
			 }
			if(repInterval_In =="")
			 {
							 alert("Enter Repetition Interval for Inroamer")
							 document.forms.form.repInterval_In.focus()
							 return false
			 }
			if(waitInterval_Out =="")
			 {
							 alert("Enter New Wait Interval for Outroamer")
							 document.forms.form.waitInterval_Out.focus()
							 return false
			 }
			if(repInterval_Out_In =="")
			 {
							 alert("Enter Repetition Interval for Outroamer")
							 document.forms.form.repInterval_Out.focus()
							 return false
			 }
			if(time_MaxMesg =="")
			 {
							 alert("Enter Time Period for Max. Messages")
							 document.forms.form.time_MaxMesg.focus()
							 return false
			 }
			if(MaxMesg_Time =="")
			 {
							 alert("Enter Max. Messages in Time Period")
							 document.forms.form.MaxMesg_Time.focus()
							 return false
			 }
			if(oneTime_Mesg =="")
							
			 {
							 alert("Enter Max. Messages in One Time")
							 document.forms.form.oneTime_Mesg.focus()
							 return false
			 }
			if(sleep_Start_hr =="")
			 {
							 alert("Enter Sleep Period hrs.")
							 document.forms.form.sleep_Start_hr.focus()
							 return false
			 }
			if(sleep_Start_min =="")
			 {
							 alert("Enter Sleep Period min.")
							 document.forms.form.sleep_Start_min.focus()
							 return false
			 }
			if(sleep_End_hr =="")
			 {
							 alert("Enter Sleep End Time  hrs.")
							 document.forms.form.sleep_End_hr.focus()
							 return false
			 }
			if(sleep_End_min =="")
			 {
							 alert("Enter Sleep End Time min.")
							 document.forms.form.sleep_End__min.focus()
							 return false
			 }
			if(sleep_Start_hr > sleep_End_hr)
			{
							alert("Enter correct time.Start time sholud be less than End time")
							return false
			}
			if( sleep_Start_hr > 24 || sleep_Start_min > 60)
			 {
							 alert("Error in Start Time")
							 document.forms.form.sleep_Start_hr=""
							 document.forms.form.sleep_Start_min=""
							 return false
			 }
			if( sleep_End_hr > 24 || sleep_End_min > 60)
			 {
							 alert("Error in End Time")
							 document.forms.form.sleep_End_hr=""
							 document.forms.form.sleep_End_min=""
							 return false
			 }


			return true;
		}//validate
  function disable()
	{
		 if(document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_Start_hr.disabled = false
						document.forms.form.sleep_Start_min.disabled = false
		 }
		 else if(!document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_Start_hr.disabled = true
						document.forms.form.sleep_Start_min.disabled = true
		 }
		 if(document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_End_hr.disabled = false
						document.forms.form.sleep_End_min.disabled = false
		 }
		 else if(!document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_End_hr.disabled = true
						document.forms.form.sleep_End_min.disabled = true
		 }

	return true;
	}//disable

</script>
</HEAD>
<%@ include file = "../pagefile/header.html" %>

  <form name="form" method="post" action="addNetworkGrp.jsp" onSubmit="return validate()">
   
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">Network Group Details  <br><br></td>	 </tr>
			 <tr class="tfields">      
			 			<td width="40%"><sup class="notice">*</sup> Network Group Name </td>
						<td >&nbsp;<input type="text" name="name" size="15"></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Network Group Description </td>
						<td valign="top">&nbsp;<textarea name="desc" rows="5" cols="50" > </textarea> </td>
		   </tr>
    </table>		
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting This Network [INBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp; Inbound Roamer</td>
					<td  height="20"><input type="checkbox" name="inbound" value="A"></td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="waitInterval_In" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_In" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Time Period for Max. Messages (days)  </td>
						<td >&nbsp;<input type="text" name="time_MaxMesg" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in Time Period  </td>
						<td >&nbsp;<input type="text" name="MaxMesg_Time" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in One Time  </td>
						<td >&nbsp;<input type="text" name="oneTime_Mesg" onkeypress="return numberOnly(event)" ></td>
       </tr>
	</table>
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting From Network [OUTBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp; Outbound Roamer</td>
					<td height="20"><input type="checkbox" name="outbound"value="A" ></td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="waitInterval_Out" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_Out" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Period Enable</td>
						<td >&nbsp;<input type="checkbox" name="sleep_enable"value="A" onClick="return disable()" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Start Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleep_Start_hr" size="10" maxlength="2" value="00"  disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleep_Start_min" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>
				 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep End Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleep_End_hr" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleep_End_min" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>

				<tr class="button1">
						<td colspan="2"> <input type="Submit" name="submit" value="ADD">&nbsp; <input type="reset" name="reset" value="RESET">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</table>	 
		
</form>
        <script language="JavaScript">
		<!--
		document.form1.name.focus();
		//-->
	</script>
<%@ include file = "../pagefile/footer.html" %>  
<%
}
%>
