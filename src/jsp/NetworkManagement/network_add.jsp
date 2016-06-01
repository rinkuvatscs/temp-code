<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*"  %>
  <%@ include file = "../conPool.jsp" %>
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
			TimeZoneManager timeZoneManager = new TimeZoneManager();
                   timeZoneManager.setConnectionPool(conPool);
			ArrayList timeZoneAl = new ArrayList();

			int i = timeZoneManager.viewTimeZone(timeZoneAl);
		  int	number_timeZone = timeZoneAl.size() ;

%>
<HTML>
<HEAD>
<TITLE>Network Master - Add</TITLE>
<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

		function validate()
		{
			var name = document.forms.form.name.value
			var brandName = document.forms.form.brandName.value
			var mnc = document.forms.form.mnc.value
			var mcc = document.forms.form.mcc.value
			var networkType = document.forms.form.networkType.value
			var timeZone = document.forms.form.timeZone.value
  
			var defaultLang = document.forms.form.defaultLang.value
			var enableTest = document.forms.form.enableTest.value
			var visitInterval_In = document.forms.form.visitInterval_In.value
			var repInterval_In = document.forms.form.repInterval_In.value
			var visitInterval_Out = document.forms.form.visitInterval_Out.value
			var repInterval_Out = document.forms.form.repInterval_Out.value
		  var time_MaxMesg = document.forms.form.timeMaxMesg.value
			var MaxMesg_Time = document.forms.form.maxMesgTime.value
			var oneTime_Mesg = document.forms.form.maxMesgOneTime.value
			var sleep_Start_hr = document.forms.form.sleepStartHr.value
			var sleep_Start_min = document.forms.form.sleepStartMin.value
			var sleep_End_hr = document.forms.form.sleepEndHr.value
			var sleep_End_min = document.forms.form.sleepEndMin.value
     
			if(name =="")
			 {
							 alert("Enter Network Name ")
							 document.forms.form.name.focus()
							 return false
			 }
			if(brandName =="")
			 {
							 alert("Enter Network Brand Name")
							 document.forms.form.brandName.focus()
							 return false
			 }
			if(mnc=="")
			 {
							 alert("Enter MNC")
							 document.forms.form.mnc.focus()
							 return false
			 }
			if(mcc=="")
			 {
							 alert("Enter MCC")
							 document.forms.form.mcc.focus()
							 return false
			 }
			if(networkType=="")
			 {
							 alert("Enter Network Type")
							 document.forms.form.networkType.focus()
							 return false
			 }

			if(timeZone=="" || timeZone=="No Time Zone Found")
			 {
							 alert("Enter Time Zone")
							 document.forms.form.timeZone.focus()
							 return false
			 }

			if(defaultLang=="")
			 {
							 alert("Enter Default Language")
							 document.forms.form.defaultLang.focus()
							 return false
			 }
			if(enableTest=="")
			 {
							 alert("Enter Enable Test")
							 document.forms.form.enableTest.focus()
							 return false
			 }

			if(waitInterval_In =="")
			 {
							 alert("Enter New Wait Interval for Inroamer")
							 document.forms.form.visitInterval_In.focus()
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
							 document.forms.form.visitInterval_Out.focus()
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
							 document.forms.form.timeMaxMesg.focus()
							 return false
			 }
			if(MaxMesg_Time =="")
			 {
							 alert("Enter Max. Messages in Time Period")
							 document.forms.form.maxMesgTime.focus()
							 return false
			 }
			if(oneTime_Mesg =="")
							
			 {
							 alert("Enter Max. Messages in One Time")
							 document.forms.form.maxMesgOneTime.focus()
							 return false
			 }
			if(sleep_Start_hr =="")
			 {
							 alert("Enter Sleep Period hrs.")
							 document.forms.form.sleepStartHr.focus()
							 return false
			 }
			if(sleep_Start_min =="")
			 {
							 alert("Enter Sleep Period min.")
							 document.forms.form.sleepStartMin.focus()
							 return false
			 }
			if(sleep_End_hr =="")
			 {
							 alert("Enter Sleep End Time  hrs.")
							 document.forms.form.sleepEndHr.focus()
							 return false
			 }
			if(sleep_End_min =="")
			 {
							 alert("Enter Sleep End Time min.")
							 document.forms.form.sleepEndMin.focus()
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

  <form name="form" method="post" action="addNetwork.jsp" onSubmit="return validate()">
   
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">Network Master Details  <br><br></td>	 </tr>
			 <tr class="tfields">      
			 			<td width="40%">Network Name<sup class="notice">*</sup>  </td>
						<td ><input type="text" name="name" size="15"></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Brand Name </td>
						<td valign="top"><input type="text" name="brandName" >  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%">MNC </td>
						<td valign="top"><input type="text" name="mnc" onkeypress="return numberOnly(event)">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> MCC </td>
						<td valign="top"><input type="text" name="mcc" onkeypress="return numberOnly(event)">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Network Type </td>
						<td valign="top"><input type="text" name="networkType">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Time Zone </td>
						<td valign="top">
						         <select name="timeZone" id="timeZone">
								<% if (number_timeZone <= 0)
									 {
								%>
								   <option selected>No Time Zone Found </option>
								<% }
								   else
										 {
						         for (int z = 0; z< number_timeZone;z++) 
							  			  {
													TimeZones timeZone_config = (TimeZones) timeZoneAl.get(z);
								%>		
										    	 <option value="<%=timeZone_config.getTimeZone()%>" selected ><%=timeZone_config.getZoneName()%></option>
							<%  		
												}//for
										 }//else
							 %>												
									  	</select>
						</td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%">Default Language </td>
						<td valign="top"><input type="text" name="defaultLang">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Enable Test </td>
						<td valign="top"><input type="text" name="enableTest" onkeypress="return numberOnly(event)"> </td>
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
						<td >&nbsp;<input type="text" name="visitInterval_In" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_In" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Time Period for Max. Messages (days)  </td>
						<td >&nbsp;<input type="text" name="timeMaxMesg" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in Time Period  </td>
						<td >&nbsp;<input type="text" name="maxMesgTime" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in One Time  </td>
						<td >&nbsp;<input type="text" name="maxMesgOneTime" onkeypress="return numberOnly(event)" ></td>
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
						<td >&nbsp;<input type="text" name="visitInterval_Out" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_Out" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Period Enable</td>
						<td >&nbsp;<input type="checkbox" name="sleepEnable"value="A" onClick="return disable()" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Start Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleepStartHr" size="10" maxlength="2" value="00"  disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleepStartMin" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>
				 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep End Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleepEndHr" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleepEndMin" size="10" maxlength="2" value="00" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>

				<tr class="button1">
						<td colspan="2"> <input type="Submit" name="submit" value="ADD">&nbsp; <input type="reset" name="reset" value="RESET">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
